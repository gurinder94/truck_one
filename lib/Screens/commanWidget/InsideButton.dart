import 'package:flutter/material.dart';

class InsiderButton extends StatelessWidget {

  var  Icon;

  InsiderButton({required this.Icon});
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 40,
        height: 35,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            shape: BoxShape.circle,
            boxShadow:
              [
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 5,
                    offset: Offset(0, 5)),
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(-3, -3))
              ]
            ),
        child: Icon);
  }
}
