import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class AddReportMaker extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: APP_BAR_BG,
      title: Text('Add a Report'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(1),
        ),
      ),
      actions: [

      ],
    ),
      body: Container(

        child: Column(
          children: [


          ],
        ),
      ),
    );
  }
}
