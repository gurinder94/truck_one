import 'package:flutter/material.dart';
class CommonRichText extends StatelessWidget {
final  String richText1;
final String ?richText2;
final String ?richText3;
final    style1;
final style2;
final style3;

   CommonRichText(
  {Key? key,
    required this.richText1,
    required this.style1,
    this.richText2,
    this.style2,
    this.style3,
    this.richText3, });


  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(
        text: richText1,
        style: style1,
        children: <TextSpan>[
          new TextSpan(
              text: richText2,
              style: style2),
          new TextSpan(text: richText3 ,style: style3),
        ],
      ),
    );


  }
}
