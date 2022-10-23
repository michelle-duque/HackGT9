import 'package:flutter/material.dart';
import 'package:omagotchi/omagotchi.dart';
import 'package:circle_list/circle_list.dart';

class Stats {
  int _level = 1;
  int _happiness = 10;
  int _hunger = 0; // if below 50, they are hungry
  int _alertness = 100;
  int _thirstiness = 0;
  int _dirtiness = 0;

  Map<String, int> toMap() {
    return {'Level': _level, 'Happiness': _happiness, 'Hunger': _hunger, 'Thirstiness': _thirstiness,
      'Dirtiness': _dirtiness, 'Alertness': _alertness};
  }

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
  late List<MapEntry<String, int>> statList = widget._avatar.stats.toMap().entries.toList().cast<MapEntry<String, int>>();

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
        child: Center(
          child: SizedBox(
            height: 200,
            width: 200,
            child: Stack(
              clipBehavior: Clip.none,
                children: [
                AnimatedPositioned(
                  height: 200,
                  width: 200,
                  duration: const Duration(milliseconds: 200),
                  child: Image.asset('assets/images/dragon-flying.png', fit: BoxFit.fitWidth,),
                ),
            ]),
          ),
        )),
    ),
            Expanded(
              flex: 5,
              child: CircleList(
                showInitialAnimation: true,
                centerWidget: Center(child: Text('STATS')),
                childrenPadding: 0,
                innerRadius: 75,
                origin: Offset.zero,
                children: List.generate(statList.length, (index) =>
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text('${statList[index].key} ${statList[index].value}'),
                      TweenAnimationBuilder(
                        curve: Curves.easeOutSine,
                        tween: Tween<double>(begin: 0, end: statList[index].value / 100),
                          duration: const Duration(seconds: 1),
                          builder: (context, double tween, child) => SizedBox(
                            height: 200,
                              width: 200,
                              child: CircularProgressIndicator(value: tween, strokeWidth: 10, backgroundColor: Colors.blue[100],))),
                    ],
                  ),
                )),
              ),
            ), const Spacer()
            ],
          ),
      ),
    );
  }
}