
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/Sign_up_provider.dart';

class SignUpTaber extends StatelessWidget {
  int pos=0;
  String title;


  SignUpTaber(this.pos, this.title);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        onTap: () => hitButton(pos, context),
    child:  Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 50,
      width: 120,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow:
          Provider.of<SignUpProvider>(context, listen: true)
              .signUp ==
              pos
              ? [
            BoxShadow(
                color: Colors.white,
                blurRadius: 5,
                offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(-5, -5))
          ]
              : [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 5,
                offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.white,
                blurRadius: 2,
                offset: Offset(-5, -5))
          ]),
      child: Center(child: Text(title,style:  Provider.of<SignUpProvider>(context, listen: true)
          .signUp ==
          pos? TextStyle(  color: Color(0xFF044a87)):TextStyle(  color: Colors.black))),
    ),
    ),);
  }

  hitButton(int pos, BuildContext context) {
    Provider.of<SignUpProvider>(context, listen: false).setClick(pos);
  }

}