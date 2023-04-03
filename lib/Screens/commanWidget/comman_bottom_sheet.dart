import 'package:flutter/material.dart';

class CommanBottomSheet {
  static Future ShowBottomSheet(BuildContext context,
      {required Widget? child}) {

    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              child: SingleChildScrollView(
                child: Container(

                    child: child,
                    decoration: BoxDecoration(
                      color:  Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    )),
              ));
        });
  }
}
