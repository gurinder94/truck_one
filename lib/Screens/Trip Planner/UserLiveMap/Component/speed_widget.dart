import 'package:flutter/material.dart';

class SpeedWidget extends StatelessWidget {
  int speed = 0;
  SpeedWidget({required this.speed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$speed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          Text("mph",
              style: TextStyle(
                fontSize: 11,
              ))
        ],
      ),
    );
  }
}
