import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';

import '../../AppUtils/constants.dart';

class CustomImageProfile extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final bool? needShadow;
  var boxFit;

  CustomImageProfile(
      {required this.image,
      required this.width,
      this.needShadow,
      required this.boxFit,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      child: image != null && image != 'null'
          ? Container(
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                image,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: (a, b, c) {
                  return Center(
                    child: Image.asset(
                      'icons/bannerProfile.png',
                      fit: boxFit,
                      width: width,
                      height: height,
                    ),
                  );
                },
              ),
              decoration: needShadow == null ? nMbox : BoxDecoration(),
            )
          : Container(),
      decoration: needShadow == null ? nMbox : BoxDecoration(),
    );
  }
}
