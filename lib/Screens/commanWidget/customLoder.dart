
import 'package:flutter/material.dart';

class CustomLoder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 60,
      child: Center(child: CircularProgressIndicator()),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD9D8D8),
              offset: Offset(5.0, 5.0),
              blurRadius: 7,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(.4),
              offset: Offset(-5.0, -5.0),
              blurRadius: 10,


            ),
          ]),
    );
  }
}
