import 'package:flutter/material.dart';
import 'package:omagotchi/omagotchi.dart';
import 'package:circle_list/circle_list.dart';

class Stats {
  Stats();

  int _level = 1;
  int _happiness = 10;
  int _hunger = 0; // if below 50, they are hungry
  int _alertness = 100;
  int _thirstiness = 0;
  int _dirtiness = 0;

  Stats.fromJson(Map<String, dynamic> json) {
    _level = json['level']!;
    _happiness = json['happiness']!;
    _hunger = json['hunger']!;
    _alertness = json['alertness']!;
    _thirstiness = json['thirstiness']!;
    _dirtiness = json['dirtiness']!;
  }

  Map<String, int> toJson() {
    return {
      'level': _level,
      'happiness': _happiness,
      'hunger': _hunger,
      'thirstiness': _thirstiness,
      'dirtiness': _dirtiness,
      'alertness': _alertness
    };
  }

  int get level => _level;

  set level(int level) => _level = level;

  int get happiness => _happiness;

  set happiness(int value) => _happiness = value < 0
      ? 0
      : value > 100
          ? 100
          : value;

  int get hunger => _hunger;

  set hunger(int value) => _hunger = value < 0
      ? 0
      : value > 100
          ? 100
          : value;

  int get alertness => _alertness;

  set alertness(int value) => _alertness = value < 0
      ? 0
      : value > 100
          ? 100
          : value;

  int get thirstiness => _thirstiness;

  set thirstiness(int value) => _thirstiness = value < 0
      ? 0
      : value > 100
          ? 100
          : value;

  int get dirtiness => _dirtiness;

  set dirtiness(int value) => _dirtiness = value < 0
      ? 0
      : value > 100
          ? 100
          : value;
}

/// ease of use to capitalize keys to display on stats page
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class StatsPage extends StatefulWidget {
  const StatsPage({super.key, required avatar}) : _avatar = avatar;

  final Omagotchi _avatar;

  @override
  State<StatsPage> createState() => StatsPageState();
}

class StatsPageState extends State<StatsPage> {
  late List<MapEntry<String, int>> statList = widget._avatar.stats
      .toJson()
      .entries
      .toList()
      .cast<MapEntry<String, int>>();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/background-1.png'),
    fit: BoxFit.cover)),
    child: Scaffold(
      backgroundColor: Colors.transparent,
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
                      child: Stack(clipBehavior: Clip.none, children: [
                        AnimatedPositioned(
                          height: 200,
                          width: 200,
                          duration: const Duration(milliseconds: 200),
                          child: Image.asset(
                            'assets/images/dragon-flying.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ]),
                    ),
                  )),
            ),
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(.3)),
              child: CircleList(
                showInitialAnimation: true,
                animationSetting: AnimationSetting(curve: Curves.easeOutCirc),
                centerWidget: const Center(child: Text('STATS')),
                childrenPadding: 0,
                innerRadius: 75,
                origin: Offset.zero,
                children: List.generate(
                    statList.length,
                    (index) => Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                  '${statList[index].key.capitalize()} ${statList[index].value}'),
                              TweenAnimationBuilder(
                                  curve: Curves.easeOutSine,
                                  tween: Tween<double>(
                                      begin: 0,
                                      end: statList[index].value / 100),
                                  duration: const Duration(seconds: 1),
                                  builder: (context, double tween, child) =>
                                      SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: CircularProgressIndicator(
                                            value: tween,
                                            strokeWidth: 10,
                                            backgroundColor: Colors.blue[100],
                                          ))),
                            ],
                          ),
                        )),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    ));
  }
}
