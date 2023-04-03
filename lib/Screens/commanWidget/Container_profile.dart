import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {

  Widget child;

  ProfileImage(
      {required this.child,});
  @override
  Widget build(BuildContext context) {
    return       Container(
      padding: EdgeInsets.all(3),
      clipBehavior: Clip.antiAlias,
      child: Container(

        clipBehavior: Clip.antiAlias,
        child: child,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFEEEEEE),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFD9D8D8),
              offset: Offset(5.0, 5.0),
              blurRadius: 3,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(.5),
              offset: Offset(-5.0, -5.0),
              blurRadius: 4,
            ),
          ]),
    );
  }
}
