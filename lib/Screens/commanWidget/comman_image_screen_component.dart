import 'package:flutter/material.dart';

class CommanImageComponent extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return     Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width<900?350:650,
      decoration: BoxDecoration(



        image: new DecorationImage(
          image: new AssetImage("assets/truckwinter.jpeg"),
          fit: BoxFit.cover,
        ),
      ),

      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Color(0x32EEEEEE),
                  Color(0x40EEEEEE),
                  Color(0x4BEEEEEE),
                  Color(0xFFEEEEEE),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
      ),
    );
  }
}
