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
  late Omagotchi avatar;

  @override
  void initState() {
    // TODO: implement saved avatars
    super.initState();
    avatar = Omagotchi(name: 'Chester', imagePath: 'no image');
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          shape: const BeveledRectangleBorder(),
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        child: ListView(
          children: [
            DrawerHeader(child: Text('This is a drawer header')),
            ListTile(
              title: const Text('Completed Tasks'),
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
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Spacer(),
                const Text(
                  'Name...',
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StatsPage(
                          avatar: avatar))),
                  child: Hero(
                    tag: 'omagotchi',
                    child: Image.network(
                        'https://images.cults3d.com/VZbUtir7YbI0hWo40lcqHoMZcXM=/516x516/filters:format(webp)/https://files.cults3d.com/uploaders/14743537/illustration-file/de3bc5be-56ff-416d-92c2-cb8fd0a8c622/PIC1.jpg'),
                  ),
                ),
                Text(
                  'Mood',
                ),
                const Spacer(),
                Task(
                    title: 'First task',
                    description:
                        'this is a very helpful mindfulness task that you must complete so that your Omagotchi won'
                        't go into CS mode.',
                    totalPoints: 500,
                    pointsCollected: 50)
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
