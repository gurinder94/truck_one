import 'package:flutter/material.dart';


class DescriptionPortion extends StatefulWidget {
  String description;


  DescriptionPortion(this.description,);

  @override
  _DescriptionPortionState createState() => _DescriptionPortionState();
}

class _DescriptionPortionState extends State<DescriptionPortion> {

  bool collapse = false;

  bool seeMore = false;


  @override
  Widget build(BuildContext context) {
    check(context);
    return Padding(
      padding: EdgeInsets.all(12),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.description,
                maxLines: collapse ? 100 : 1,

                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: collapse ? 0 : 10,
              ),
              collapse || seeMore
                  ? SizedBox()
                  : GestureDetector(
                onTap: () {
                  collapse ? collapse = false : collapse = true;
                  setState(() {});
                },
                child: Align(
                    alignment: Alignment.centerRight,
                    child: collapse
                        ? SizedBox()
                        : Text(
                      '... see more',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),

          )
      ),
    );
  }

  void check(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double textSize = widget.description.length * 7.9;
    if (textSize > screenSize)
      seeMore = false;
    else
      seeMore = true;
  }
}
