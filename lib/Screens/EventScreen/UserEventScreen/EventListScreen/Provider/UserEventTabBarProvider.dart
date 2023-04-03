import 'package:flutter/material.dart';

class UserEventTabBarProvider extends ChangeNotifier {
  int menuClick = 0;

  String? tabName = "TOP";

  setMenuClick(int pos) {
    menuClick = pos;
    notifyListeners();
  }
}
