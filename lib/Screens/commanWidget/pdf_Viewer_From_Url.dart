import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class PDFViewerFromUrl extends StatelessWidget {
  String ?name;
  String ?document;
  PDFViewerFromUrl(this.name, this.document);






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:  Text(name.toString()),
      ),
      body: PDF().fromUrl(
        SERVER_URL+"/uploads/docs/$document",
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
   // return CustomAppBarWidget(leading: leading, title: title, actions: actions, child: child, floatingActionWidget: floatingActionWidget)
  }
}