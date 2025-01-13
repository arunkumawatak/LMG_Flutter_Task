import 'dart:convert';

void main() {
  String jsonInput = '''
  {
    "animals": [
      { "animal": "dog,cat,dog,cow" },
      { "animal": "cow,cat,cat" },
      { "animal": null },
      { "animal": "" }
    ]
  }
  ''';

// json to dart
  Map<String, dynamic> data = json.decode(jsonInput);
  List animalsList = data['animals'];

  for (var entry in animalsList) {
    String? animalString = entry['animal'];
    if (animalString == null || animalString.isEmpty) continue;
    List<String> animals = animalString.split(',');
    Map<String, int> countMap = {};
    for (var animal in animals) {
      countMap[animal] = (countMap[animal] ?? 0) + 1;
    }
    List<String> result = [];
    countMap.forEach((animal, count) {
      if (count > 1) {
        result.add('$animal($count)');
      } else {
        result.add(animal);
      }
    });
    print(result.join(', '));
  }
}
