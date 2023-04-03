import 'package:flutter/material.dart';

class CommmanCircleDecoration extends StatelessWidget {

  Widget widgetName;
   CommmanCircleDecoration({required this.widgetName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      height: 35,
      child: widgetName,
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                offset: Offset(3, 3)),
            BoxShadow(
                color: Colors.white,
                blurRadius: 2,
                offset: Offset(-2, -2))
          ]),
    );
  }
}
