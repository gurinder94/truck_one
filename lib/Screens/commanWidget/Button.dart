import 'package:flutter/material.dart';

class Button extends StatelessWidget {


  String? text;
Color ? colorcode;
Color?Textcolor ;

  Button({ this.text,this.colorcode,this.Textcolor});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin:
      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      decoration: BoxDecoration(
          color: colorcode,
          borderRadius: BorderRadius.all(Radius.circular(20)),
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
      child: Center(
          child: Text(
            text.toString(),
            style: TextStyle(
              color: Textcolor,
              fontSize: 22,
            ),
          )),
    );
  }
}
