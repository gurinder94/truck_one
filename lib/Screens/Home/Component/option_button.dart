import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  String title;
  Function onClick;

  OptionButton({required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onClick();
        },
        child: Text(
          title,
          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}