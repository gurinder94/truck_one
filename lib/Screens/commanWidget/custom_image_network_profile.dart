import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';

import '../../AppUtils/constants.dart';

class CustomImageProfile extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  var boxFit;

  CustomImageProfile(
      {required this.image,
      required this.width,
      required this.boxFit,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          image,
          fit: boxFit,
          width: width,
          height: height,
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : SizedBox(
                    width: width,
                    height: height,
                    child: Center(
                        child: LoadingWidget(((progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!) *
                                100)
                            .toInt())),
                  );
          },
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
        decoration: nMbox,
      ),
      decoration: nMbox,
    );
  }
}
