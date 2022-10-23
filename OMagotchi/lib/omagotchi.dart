import 'stats.dart';
class Omagotchi {
  Omagotchi({required name, required neutral, happy})
      :
        _name = name,
        _neutralImage = neutral,
        _happyImage = happy;

  Omagotchi.fromJSON(Map<String, dynamic> json) {
    _stats = Stats.fromJson(json['stats']);
    _name = json['name'];
    _neutralImage = json['neutralImage'];
    _happyImage = json['happyImage'];
    _mood = json['mood'];
  }

  late String _name;
  Stats _stats = Stats();
  late String _neutralImage;
  late String _happyImage;
  String _mood = 'Depressed';

  String get mood => _mood;

  set mood(mood) => _mood = mood;

  void setMood() {
    int happiness = _stats.happiness;
    if (happiness >= 0 && happiness < 25) {
      _mood = "Depressed";
    } else if (happiness >= 25 && happiness < 50) {
      _mood = "Neutral";
    } else if (happiness >= 50 && happiness < 75) {
      _mood = "Happy";
    } else {
      _mood = "Exuberant";
    }
  }

  String get name => _name;
  Stats get stats => _stats;
  String get image => _stats.happiness < 50 ? _neutralImage : _happyImage;

  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'neutralImage': _neutralImage,
      'happyImage': _happyImage,
      'mood': _mood,
      'stats': _stats.toJson(),
    };
  }
}