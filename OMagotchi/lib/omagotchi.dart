import 'stats.dart';

import 'animal.dart';

class Omagotchi {
  Omagotchi({required name, required imagePath}) :
        _name = name,
        _imagePath = imagePath;

  String _name;
  final Stats _stats = Stats();
  String _imagePath;
  //String _happyImagePath;
  String _mood = 'Depressed';

  String get mood => _mood;
  set mood(mood) => _mood = mood;
  void setMood() {
    int happiness = _stats.happiness;
    if (happiness >= 0 && happiness < 25) {
      _mood = "Depressed";
    } else if (happiness >= 25 && happiness < 50) {
      _mood = "Neutral";
      _imagePath = 'assets/images/dragon-neutral.png';
    } else if (happiness >= 50 && happiness < 75) {
      _mood = "Happy";
      _imagePath = 'assets/images/dragon-happy.png';
    } else {
      _stats.happiness = happiness >= 100 ? 100 : happiness;
      _mood = "Exuberant";
    }
  }


  String get name => _name;
  Stats get stats => _stats;
  String get imagePath => _imagePath;
}