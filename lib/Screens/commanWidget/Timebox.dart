import 'package:flutter/material.dart';

class TimeBox extends StatelessWidget {

  TimeBox({required this.child});
  Widget child;
  @override
  Widget build(BuildContext context) {

    return Container(
width: 30,
        height: 25,

        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE),

            borderRadius: BorderRadius.circular(10),boxShadow: [
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

        child: Container(


          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(color: Color(0xFFEEEEEE),

              boxShadow: [
                BoxShadow(
                  color: Color(0xFFD9D8D8),
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 2,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(.4),
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10,
                ),
              ]),
          child: child,

        ));
  }
}
