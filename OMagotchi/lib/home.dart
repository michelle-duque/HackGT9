import 'dart:async';
import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:omagotchi/omagotchi.dart';
import 'package:omagotchi/settings.dart';
import 'package:omagotchi/stats.dart';
import 'package:omagotchi/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'animal.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final List<Omagotchi> omis = [
    Omagotchi(
        name: 'Chester',
        neutral: 'assets/images/dragon-neutral.png',
        happy: 'assets/images/dragon-happy.png')
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Omagotchi avatar;
  late SharedPreferences prefs;
  bool firstTime = true;
  Future<bool> _avatarFuture = Future.value(false);

  /// allows for closure of drawer programmatically when selecting a new OMi
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  /// controller that starts fade scale animation for image and task view
  late final AnimationController _fadeScaleController =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

  double avatarPosition = 0;
  Curve positionCurve = Curves.easeOutSine;
  List<Widget> tasks = [
    Task(
        title: 'First task',
        description:
            'this is a very helpful mindfulness task that you must complete so that your Omagotchi won'
            't go into CS mode.',
        totalPoints: 500,
        pointsCollected: 50),
    Task(
        title: 'Second task',
        description:
            'this is a very helpful mindfulness task that you must complete so that your Omagotchi won'
            't go into CS mode.',
        totalPoints: 500,
        pointsCollected: 400)
  ];

  @override
  void initState() {
    // TODO: implement saved avatars
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences value) {
      prefs = value;
      firstTime = prefs.getBool('firstTime') ?? true;
      if (!firstTime) {
        setState(() {
          avatar = Omagotchi.fromJSON(jsonDecode(prefs.getString('avatar')!));
        });
      }

      // runs the choose avatar process, which immediately returns true if avater not null
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _avatarFuture =
              !firstTime ? Future.value(true) : chooseAvatar(context);
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          _fadeScaleController.forward();
        });
      });
    });
  }

  Future<bool> chooseAvatar(BuildContext context) {
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      _scaffoldKey.currentState?.closeDrawer();
    }
    return showDialog(
        barrierDismissible: !firstTime,
        context: context,
        builder: (context) => SimpleDialog(
          title: const Center(child: Text('Choose your OMagotchi!')),
              children: List.generate(
                  widget.omis.length,
                  (index) => SimpleDialogOption(
                        child: Column(
                          children: [
                            SizedBox(
                                width: 200,
                                height: 200,
                                child: Image.asset(
                                  widget.omis[index].image,
                                  fit: BoxFit.contain,
                                )),
                            Text(widget.omis[index].name)
                          ],
                        ),
                        onPressed: () {
                          setState(() => avatar = widget.omis[index]);
                          firstTime = false;
                          prefs.setBool('firstTime', firstTime);
                          prefs.setString('avatar', jsonEncode(avatar));
                          Navigator.of(context, rootNavigator: true).pop(true);
                        },
                      )),
            )).then((value) => true);
  }

  @override
  Widget build(BuildContext context) {
    // WillPopScope calls _save before closing app to save data
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background-1.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            shape: const BeveledRectangleBorder(),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'OMagotchi',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              )),
              ListTile(
                title: const Text('Choose new OMi'),
                onTap: () => chooseAvatar(context),
              ),
              const ListTile(
                title: Text('Completed Tasks'),
              ),
              ListTile(
                title: const Text('Settings'),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage())),
              ),
              const ListTile(
                title: Text('More features coming soon'),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: FutureBuilder<bool>(
                future: _avatarFuture,
                builder: (context, finished) => (!(finished.data ?? false))
                    ? const CircularProgressIndicator()
                    : FadeScaleTransition(
                        animation: _fadeScaleController,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Spacer(
                              flex: 2,
                            ),
                            Text(
                              '${avatar.name} is feeling ${avatar.mood}',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StatsPage(avatar: avatar))),
                              onDoubleTap: () => Timer.periodic(
                                  const Duration(milliseconds: 200), (timer) {
                                setState(() {
                                  positionCurve = Curves.easeOutSine;
                                  avatarPosition =
                                      avatarPosition == 100 ? 0 : 100;
                                });
                                if (timer.tick == 6) {
                                  timer.cancel();
                                  setState(() {
                                    avatar.stats.happiness += 5;
                                    avatar.setMood();
                                    prefs.setString(
                                        'avatar', jsonEncode(avatar));
                                  });
                                } // stop jumping after 3 jumps
                              }),
                              onLongPress: () => Timer.periodic(
                                  const Duration(milliseconds: 100), (timer) {
                                setState(() {
                                  positionCurve = Curves.bounceInOut;
                                  avatarPosition =
                                      avatarPosition == 100 ? 0 : 100;
                                });
                                if (timer.tick == 6) {
                                  setState(() {
                                    avatar.stats.alertness -= 5;
                                    avatar.stats.hunger += 2;
                                    prefs.setString(
                                        'avatar', jsonEncode(avatar));
                                  });
                                  timer.cancel();
                                } // stop jumping after 3 jumps
                              }),
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Hero(
                                  tag: 'omagotchi',
                                  child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedPositioned(
                                          height: 250,
                                          width: 250,
                                          bottom: avatarPosition,
                                          curve: positionCurve,
                                          duration:
                                              const Duration(milliseconds: 200),
                                          child: Image.asset(
                                            avatar.image,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              flex: 3,
                              child: ListView.builder(
                                  clipBehavior: Clip.none,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: tasks.length,
                                  itemBuilder: (context, index) =>
                                      tasks[index]),
                            )
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
