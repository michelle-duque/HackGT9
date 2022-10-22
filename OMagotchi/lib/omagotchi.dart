import 'stats.dart';

import 'animal.dart';

class Omagotchi {
  Omagotchi({required name, required imagePath}) :
        _name = name,
        _imagePath = imagePath;

  String _name;
  final Stats _stats = Stats();
  String _imagePath;
}