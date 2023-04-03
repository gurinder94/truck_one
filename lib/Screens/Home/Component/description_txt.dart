import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class DescriptionTxt extends StatefulWidget {
  String description;
  bool isShared;

  @override
  _DescriptionTxtState createState() =>
      _DescriptionTxtState(description, isShared);

  DescriptionTxt({required this.description, required this.isShared});
}

class _DescriptionTxtState extends State<DescriptionTxt> {
  bool collapse = false;
  String description;
  bool isShared, seeMore = false;

  _DescriptionTxtState(this.description, this.isShared);
  String ?firstHalf;
  String ?secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (description.length > 50) {
      firstHalf = description.substring(0, 50);
      secondHalf = description.substring(50, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
  }
  @override
  Widget build(BuildContext context) {
    // check(context);
      return  Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf!.length==0?
           new Text(firstHalf!)
          : new Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: <Widget>[
          new Text(flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!)),
          new InkWell(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  flag ? "show more" : "show less",
                  textAlign: TextAlign.justify,
                  style: new TextStyle(color:PrimaryColor),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                flag = !flag;
              });
            },
          ),
        ],
      ),
    );
  }

  void check(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double textSize = description.length.toDouble() ;

    print( screenSize);
    if (textSize > screenSize) {

      seeMore = true;

    } else {
      seeMore = false;

      print(seeMore);
    }
    print(seeMore);
  }
}
