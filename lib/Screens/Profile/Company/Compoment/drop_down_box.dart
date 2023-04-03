import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class DropDownBox extends StatelessWidget {
  Widget child;

  DropDownBox({required this.child});

  @override
  Widget build(BuildContext context) {
    return InputTextField(

      child: child,

    );
  }
}
