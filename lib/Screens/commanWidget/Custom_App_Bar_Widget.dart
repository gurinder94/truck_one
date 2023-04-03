import 'package:flutter/material.dart';

import '../../AppUtils/constants.dart';

class CustomAppBarWidget extends StatelessWidget {
  String title;
  Widget leading,actions,child,floatingActionWidget;
CustomAppBarWidget(

      {
    required this.leading,
    required this.title,
    required this.actions,
        required  this.child,
        required       this.floatingActionWidget,


  }

  );

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation;
    return Scaffold(
      extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset:false ,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        toolbarHeight: isPortrait == Orientation.portrait ? 55 : 75,
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        elevation: 0.0,
        title: Text(title),
        centerTitle: true,

        leading: leading,
        actions: [
          actions
        ],
      ),

      body: child,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: floatingActionWidget
    );
  }

}
