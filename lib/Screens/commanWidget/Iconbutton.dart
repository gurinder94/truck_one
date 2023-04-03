import 'package:flutter/material.dart';

class ImageIconButton extends StatelessWidget {

  double  hight;
  double wight;
  String  images;
  ImageIconButton({required this.hight,required this.wight,required this.images});

  Widget build(BuildContext context) {
    return   Container(
      width: hight,
      height: wight,

      child: Image.asset(
        images,
        scale: 3,
      ),
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
