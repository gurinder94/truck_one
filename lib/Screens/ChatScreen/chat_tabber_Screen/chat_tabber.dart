import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/chat_home_provider.dart';

class ChatTabber extends StatelessWidget {
  int pos = 0;
  String title;
  Function onClick;

  ChatTabber(
      {Key? key, required this.title, required this.pos, required this.onClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hitButton(pos, context);
        onClick();
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: Provider.of<ChatHomeProvider>(context, listen: true)
                          .groupTabber ==
                      pos
                  ? [
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 5,
                          offset: Offset(5, 5)),
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(-5, -5))
                    ]
                  : [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                          offset: Offset(5, 5)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 2,
                          offset: Offset(-5, -5))
                    ]),
          child: Center(
              child: Text(title,
                  style: Provider.of<ChatHomeProvider>(context, listen: true)
                              .groupTabber ==
                          pos
                      ? TextStyle(color: Color(0xFF044a87))
                      : TextStyle(color: Colors.black))),
        ),
      ),
    );
  }

  hitButton(int pos, BuildContext context) {
    Provider.of<ChatHomeProvider>(context, listen: false).setClick(pos);
  }
}
