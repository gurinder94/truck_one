import 'package:flutter/material.dart';

class MyCustomNotifier extends ValueNotifier<bool> {
  MyCustomNotifier( bool value) :super(value );
bool? check;
   toggle(value) {
    // Add your super logic here!
    check = value;
    notifyListeners();
  }
}