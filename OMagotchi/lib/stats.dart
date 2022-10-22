import 'package:flutter/material.dart';
import 'package:omagotchi/omagotchi.dart';

class Stats {
  int _level = 1;
  int _happiness = 10;
  int _hunger = 0; // if below 50, they are hungry
  int _alertness = 100;
  int _thirstiness = 0;
  int _dirtiness = 0;

  int get level => _level;
  set level(int level) => _level = level;

  int get happiness => _happiness;
  set happiness(int value) => _happiness = value;

  int get hunger => _hunger;
  set hunger(int value) => _hunger = value;

  int get alertness => _alertness;
  set alertness(int value) => _alertness = value;

  int get thirstiness => _thirstiness;
  set thirstiness(int value) => _thirstiness = value;

  int get dirtiness => _dirtiness;
  set dirtiness(int value) => _dirtiness = value;
}

class StatsPage extends StatefulWidget {
  StatsPage({required avatar}) :
      _avatar = avatar;

  Omagotchi _avatar;

  @override
  State<StatsPage> createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Hero(
                tag: 'omagotchi',
                child: Image.network(
                    'https://images.cults3d.com/VZbUtir7YbI0hWo40lcqHoMZcXM=/516x516/filters:format(webp)/https://files.cults3d.com/uploaders/14743537/illustration-file/de3bc5be-56ff-416d-92c2-cb8fd0a8c622/PIC1.jpg',
                scale: 4.0,),
              ),
            ),
            const Spacer(),
            Center(
              child: Text('Stats Page'),
            ),
          ],
        ),
      ),
    );
  }
}