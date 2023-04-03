import 'package:flutter/material.dart';

import 'customLoder.dart';

class CommanButtonWidget extends StatelessWidget {
String  title;
Color titleColor;
Color buttonColor;
Function onDoneFuction;
bool loder=false;

CommanButtonWidget({required this.title,required this.titleColor,required this.buttonColor,required this.onDoneFuction,required this.loder} );
  Widget build(BuildContext context) {
    return loder==true?Center(child: CustomLoder()): GestureDetector(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(10),
        child: Center(
            child: Text(
              title,
              style: TextStyle(color: titleColor, fontSize: 15),
            )),
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white,
                  blurRadius: 3,
                  offset: Offset(-5, -5))
            ]),
      ),
      onTap: (){
        onDoneFuction();
      }
    );
  }
}
