import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

class PopMenuBar extends StatelessWidget {
  final Function? onDoneFunction;
  List<List<dynamic>> userMenuItems;
  int containerDecoration;
  var val;
  var iconsName;


  PopMenuBar({
    required this.onDoneFunction,
    required this.userMenuItems,
    required this.containerDecoration,
    required this.val,
  required this.iconsName
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        elevation: 20,
        enabled: true,
        child: Icon(
          iconsName,
          color: Colors.black,
          size: 22,
        ),
        onSelected: (value) {
          val = value;
          onDoneFunction!(value);
        },
        itemBuilder: (context) => [
              for (var list in userMenuItems)
                PopupMenuItem(
                  child: Text(
                    list[0],
                    style: TextStyle(
                        color: list[1] == val ? PrimaryColor : Colors.black),
                  ),
                  value: list[1],
                ),
            ]);
  }
}
