import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  int signUp = 0;

  bool _loading = true;

  get loading => _loading;

  setClick(int pos) {
    signUp= pos;
    notifyListeners();
  }



}
