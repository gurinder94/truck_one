import 'package:flutter/material.dart';

import '../../AppUtils/constants.dart';

class CommanCirleWidget extends StatelessWidget {
  @override
  Widget icons;
  Function onDone;
  CommanCirleWidget( { required this.icons,required this.onDone});

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 45,
          height: 45,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(-5, -5)),
              BoxShadow(
                  color: APP_BAR_BG,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(5, 5)),
            ],
            shape: BoxShape.circle,
          ),
        child: icons
      ),
      onTap: ()
      {
        onDone();
      }
    );
  }
}
