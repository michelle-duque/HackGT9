abstract class AnimalType {
  AnimalType({name, skills = const []}) :
    _name = name,
    _skills = skills;

  String _name;
  List<String> _skills;
}