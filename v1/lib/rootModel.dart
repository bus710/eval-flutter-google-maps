/* This is the provider's model. */

import 'dart:async';
import 'package:flutter/material.dart';
import 'utils/enums.dart';

class RootModel with ChangeNotifier {
  AppStatus _appState;
  String _appStateString;

  Timer _timer;

  RootModel() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), _timerHandler);
    _appState = AppStatus.main;
    _appStateString = "main";
  }

  // Getters and setters
  AppStatus getAppStatus() => _appState;
  String getAppStatusString() => _appStateString;
  void setSideBarStatus() {
    notifyListeners();
  }

  // Timer
  void cancelTimer() => _timer.cancel(); // Just for the warning message
  void _timerHandler(Timer timer) async {
    // Spare
  }

  // To control the page request during some intense displaying
  void appStatusRequestHandler(AppStatus request) {
    debugPrint("[rootModel/transition] " +
        _appState.toString() +
        "/" +
        request.toString());

    switch (request) {
      case AppStatus.map:
        _appState = AppStatus.map;
        _appStateString = "Map";
        break;
      default:
        _appState = AppStatus.main;
        _appStateString = "Main";
        break;
    }
    notifyListeners();
  }
}
