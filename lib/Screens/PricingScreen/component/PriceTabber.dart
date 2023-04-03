import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/Pricing_provider.dart';

class PriceTabber extends StatelessWidget {
  String title;
  int pos;
  Function onTabHit;
  PriceTabber({required this.title, required this.pos,required this.onTabHit});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

    onTap: ()
      {
        onTabHit(pos);
        Provider.of<PriceProvider>(context, listen: false).setMenuClick(pos, context);
      },
      child: Container(
        width: 90,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow:
                Provider.of<PriceProvider>(context, listen: true).menuClick == pos
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
        child: Center(
            child: Text(title,
                style:
                    Provider.of<PriceProvider>(context, listen: true).menuClick ==
                            pos
                        ? TextStyle(color: Color(0xFF044a87))
                        : TextStyle(color: Colors.black))),
      ),
    );
  }
}
