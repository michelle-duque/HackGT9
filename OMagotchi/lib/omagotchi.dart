import 'stats.dart';

import 'animal.dart';

class Omagotchi {
  Omagotchi({required name, required imagePath}) :
        _name = name,
        _imagePath = imagePath;

  String _name;
  final Stats _stats = Stats();
  String _imagePath;
  String _mood = 'Exuberant';

  String get mood => _mood;
  set mood(mood) => _mood = mood;

  String get name => _name;
  Stats get stats => _stats;
  String get imagePath => _imagePath;
}