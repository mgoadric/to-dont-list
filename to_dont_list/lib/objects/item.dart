// Data class to keep the string and have an abbreviation function


class Item {
  Item({required this.name});

  final String name;

  double timeRemaining = 10.0;
  

  String abbrev() {
    return name.substring(0, 1);
  }
}
