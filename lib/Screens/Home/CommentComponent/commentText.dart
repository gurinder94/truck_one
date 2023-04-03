import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';

class DescriptionTextWidget extends StatefulWidget {
  final List<CommentItemModel> list;
  int index;

  DescriptionTextWidget( this.list, this. index  );

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState(list ,index);
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String? firstHalf;
  String? secondHalf;

  bool flag = true;
  final List<CommentItemModel> list;
int  index;

  _DescriptionTextWidgetState(this.list, this.index );

  @override



  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf!.isEmpty
          ? new Text(firstHalf!)
          : new Column(
              children: <Widget>[
                new Text(
                    flag ? (firstHalf! + "...") : (firstHalf! + secondHalf!)),
                new InkWell(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(
                        flag ? "show more" : "show less",
                        style: new TextStyle(color: PrimaryColor),
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
}
