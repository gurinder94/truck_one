import 'package:flutter/material.dart';

class TripTabBarProvider  extends ChangeNotifier {
  int menuClick = 0;

  String ? tabName;

  setMenuClick(int pos) {
    menuClick = pos;


    notifyListeners();
  }
}
