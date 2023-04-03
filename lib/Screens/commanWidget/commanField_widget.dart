import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  Widget child;

  InputTextField({required this.child});

  Widget build(BuildContext context) {
    // return Container(
    //
    //
    //     padding: EdgeInsets.all(1),
    //     decoration: BoxDecoration(color: Color(0xFFEEEEEE),
    //
    //         borderRadius: BorderRadius.circular(10),boxShadow: [
    //       BoxShadow(
    //         color: Color(0xFFD9D8D8),
    //         offset: Offset(5.0, 5.0),
    //         blurRadius: 7,
    //       ),
    //       BoxShadow(
    //         color: Colors.white.withOpacity(.4),
    //         offset: Offset(-5.0, -5.0),
    //         blurRadius: 10,
    //       ),
    //     ]),
    //
    //     child: Container(
    //
    //       padding: EdgeInsets.all(1),
    //       decoration: BoxDecoration(color: Color(0xFFEEEEEE),
    //           borderRadius: BorderRadius.circular(10),
    //           boxShadow: [
    //         BoxShadow(
    //           color: Color(0xFFD9D8D8),
    //           offset: Offset(-5.0, -5.0),
    //           blurRadius: 2,
    //         ),
    //         BoxShadow(
    //           color: Colors.white.withOpacity(.4),
    //           offset: Offset(5.0, 5.0),
    //           blurRadius: 10,
    //         ),
    //       ]),
    //       child: child,
    //
    //     ));
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
}
