import 'package:flutter/material.dart';

class InputShape extends StatelessWidget {
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,right: 10),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.white, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.black12, blurRadius: 1, offset: Offset(-5, -5)),
            ]),
        child: child);
  }

  InputShape({required this.child});
}
