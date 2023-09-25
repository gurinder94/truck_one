import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingPage extends StatelessWidget {
  var child;

  LoadingPage({this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey[400]!,
        enabled: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        ));
  }
}

class Loader extends StatelessWidget {
  var height, width, shape;

  Loader({this.height, this.width, this.shape});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white70,
          shape: shape),
    );
  }
}
