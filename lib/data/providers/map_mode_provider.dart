import 'package:flutter/material.dart';

class MapModeProvider extends ChangeNotifier {
  static final List<String> mapModes = ['HOME', 'RECENT_JOURNEY_BOX', 'SEARCHED_ROUTE'];
  String _mode = 'HOME'; // TO CHANGE TO ENUMS IN THE FUTURE, MAYBE...
  String get mode => _mode;

  changeMode(String newMode) {
    _mode = newMode;
    notifyListeners();
  }
}