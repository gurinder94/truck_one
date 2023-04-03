import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';


class CustomAppBar extends StatelessWidget {
  Widget child;
  String title;
  bool visual = false;
  final Widget? showModalWidget;
   Widget? searchButton;
  final bool? backvisual;




  CustomAppBar({
    required this.child,
    required this.title,
    required this.visual,
    this.showModalWidget,
    this.backvisual,
    this.searchButton,

  });

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation;
    print(
      isPortrait == Orientation.portrait ? 80 : 500,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        toolbarHeight: isPortrait == Orientation.portrait ? 50 : 80,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(title),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: APP_BAR_BG,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        ),
        leading: backvisual == false
            ? SizedBox()
            : IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
        actions: [
          visual == false
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: GestureDetector(
                      child: Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.white,
                      ),
                      onTap: () {
                        _showmanageButtonPressed(context);
                      },
                    ),
                  ),
                ),

        ],
      ),
      body: child,
    );
  }

  _showmanageButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              child: SingleChildScrollView(
                child: Container(
                    child: showModalWidget,
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    )),
              ));
        });
  }
}
