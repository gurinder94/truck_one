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

Widget JobSListLoading() {
  return LoadingPage(
    child: ListView.builder(
      itemCount: 12,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Loader(
          height: 120.0,
          width: (MediaQuery.of(context).size.width - 40).toDouble(),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Widget serviceListListLoading() {
  return LoadingPage(
    child: ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Loader(
          height: 200.0,
          width: (MediaQuery.of(context).size.width - 40).toDouble(),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Widget dashBoardPostLoading() {
  return LoadingPage(
    child: ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Loader(
          height: 300.0,
          width: (MediaQuery.of(context).size.width - 40).toDouble(),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Widget notificationsLoading() {
  return LoadingPage(
    child: ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Loader(
          height: 75.0,
          width: (MediaQuery.of(context).size.width - 40).toDouble(),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Widget commonListLoading(double itemHeight) {
  return LoadingPage(
    child: ListView.builder(
      itemCount: 12,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Loader(
          height: itemHeight.toDouble(),
          width: (MediaQuery.of(context).size.width - 40).toDouble(),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Widget commonGridLoadind({required double height, required double width}) {
  return LoadingPage(
    child: GridView.builder(
        padding: EdgeInsets.all(10),
        controller: ScrollController(),
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
            mainAxisSpacing: 20,
            crossAxisCount: 2),
        itemBuilder: (context, i) => Loader(
              height: height.toDouble(),
              width: width.toDouble(),
              shape: BoxShape.rectangle,
            )),
  );
}
