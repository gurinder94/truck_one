import 'package:flutter/material.dart';

class DescriptionWhite extends StatefulWidget {
  String description;

  @override
  _DescriptionWhiteState createState() => _DescriptionWhiteState(description);

  DescriptionWhite({required this.description});
}

class _DescriptionWhiteState extends State<DescriptionWhite> {
  bool collapse = false;
  String description;
  bool seeMore = false;

  _DescriptionWhiteState(this.description);

  @override
  Widget build(BuildContext context) {
    check(context);
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            description,
            maxLines: collapse ? 100 : 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 10,
          ),
          seeMore
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
                              style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),
                            )),
                ),
        ],
      ),
    );
  }

  void check(BuildContext context) {
    double screenSize = MediaQuery.of(context).size.width;
    double textSize = description.length * 7.9;
    if (textSize > screenSize)
      seeMore = false;
    else
      seeMore = true;
  }
}
