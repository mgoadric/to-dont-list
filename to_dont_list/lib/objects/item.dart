// Data class to keep the string and have an abbreviation function

import 'dart:async';

class Item {
  Item({required this.name});

  final String name;
  Timer? _timer = null;
  double _timeRemaining = 10.0;

  Timer? get timer => _timer;
  double get timeRemaining => _timeRemaining;

  String abbrev() {
    return name.substring(0, 1);
  }

  

    void startTimer() {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds:100), (timer) {
        if (_timeRemaining > 0) {
            _timeRemaining -= 0.1;
          } else {
            _timer?.cancel();
          }
      });
    }
}
