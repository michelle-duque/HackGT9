import 'dart:async';

import 'package:flutter/material.dart';
import 'package:omagotchi/omagotchi.dart';
import 'package:omagotchi/settings.dart';
import 'package:omagotchi/stats.dart';
import 'package:omagotchi/task.dart';

import 'animal.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Omagotchi avatar = Omagotchi(name: 'Chester', imagePath: 'no image');
  double avatarPosition = 0;
  Curve positionCurve = Curves.easeOutSine;
  late List<Widget> tasks = [Task(
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
        pointsCollected: 400)];

  @override
  void initState() {
    // TODO: implement saved avatars
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background-1.png'),
          fit: BoxFit.cover
        )
      ),
      child: Scaffold(
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Spacer(flex: 2,),
                    Text(
                      avatar.name,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StatsPage(avatar: avatar))),
                      onDoubleTap: () =>
                          Timer.periodic(const Duration(milliseconds: 200), (timer) {
                        setState(() {
                          positionCurve = Curves.easeOutSine;
                          avatarPosition = avatarPosition == 100 ? 0 : 100;
                        });
                        if (timer.tick == 6) {
                          setState(() {
                            timer.cancel();
                            avatar.stats.happiness += 5;
                            avatar.setMood();
                          });
                        } // stop jumping after 3 jumps
                      }),
                      onLongPress: () => Timer.periodic(const Duration(milliseconds: 200), (timer) {
                        setState(() {
                          positionCurve = Curves.bounceInOut;
                          avatarPosition = avatarPosition == 100 ? 0 : 100;
                        });
                        if (timer.tick == 6) {
                          setState(() {
                            avatar.stats.happiness += 5;
                            avatar.setMood();
                            timer.cancel();
                          });
                        } // stop jumping after 3 jumps
                      }),
                      child: SizedBox(
                        height: 350,
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
                              duration: const Duration(milliseconds: 200),
                              child: Image.asset(avatar.imagePath, fit: BoxFit.fitHeight, scale: 5),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    Text(
                      avatar.mood,
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        clipBehavior: Clip.none,
                        physics: const BouncingScrollPhysics(),
                        itemCount: tasks.length,
                          itemBuilder: (context, index) => tasks[index]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
