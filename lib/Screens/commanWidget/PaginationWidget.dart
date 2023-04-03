import 'package:flutter/material.dart';

class PaginationWidget extends StatelessWidget {

  bool paginationLoading;


  PaginationWidget(this.paginationLoading);

  @override
  Widget build(BuildContext context) {

    return paginationLoading
        ? Center(child: LinearProgressIndicator())
        : SizedBox();

  }
}
