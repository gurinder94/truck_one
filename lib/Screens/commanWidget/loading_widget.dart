import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  int val;

  LoadingWidget(this.val);


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            strokeWidth: 2,

            value:val/100,
          ),
        ),
        Text('$val %'),
      ],
    );
  }
}
