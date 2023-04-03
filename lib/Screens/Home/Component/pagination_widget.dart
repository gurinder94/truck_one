import 'package:flutter/material.dart';


class PaginationWidget extends StatelessWidget {

  bool paginationLoading;
  PaginationWidget(this.paginationLoading);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Color(0xFFEEEEEE),
        height: paginationLoading ? 90 : 0,
        child: paginationLoading
            ? Center(child: LinearProgressIndicator())
            : SizedBox());
  }
}
