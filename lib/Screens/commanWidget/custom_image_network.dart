import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';

class CustomImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final needShadow;

  var boxFit;

  CustomImage(
      {required this.image,
      this.needShadow,
      required this.width,
      required this.boxFit,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: boxFit,
      width: width,
      height: height,
      loadingBuilder: (context, child, progress) {
        return progress == null && progress?.expectedTotalBytes == null
            ? child
            : Center(
                child: LoadingWidget(((progress!.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!) *
                        100)
                    .toInt()));
      },
      errorBuilder: (a, b, c) => Center(
          child: Image.asset(
        'assets/default.png',
        fit: boxFit,
        width: width,
        height: height,
      )),
    );
  }
}
