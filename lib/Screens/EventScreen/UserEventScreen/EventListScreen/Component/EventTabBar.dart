import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/UserEventTabBarProvider.dart';

class EventTabBar extends StatefulWidget {
  int pos;
  late String title;

  Function onTabHit;

  EventTabBar({required this.title, required this.pos, required this.onTabHit});

  @override
  _EventTabBarState createState() => _EventTabBarState(title, pos, onTabHit);
}

class _EventTabBarState extends State<EventTabBar> {
  int pos = 0;
  late String title;
  Function onTabHit;

  _EventTabBarState(this.title, this.pos, this.onTabHit);

  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          hitButton(pos, context);

          switch (pos) {
            case 0:
              setState(() {
                onTabHit('TOP');
              });
              break;
            case 1:
              setState(() {
                onTabHit('WEEKLY');
              });

              break;

            case 2:
              setState(() {
                onTabHit("WEEKLY");
              });

              break;
            case 0:
              setState(() {
                onTabHit("ALL");
              });
              break;
            case 3:
              setState(() {
                onTabHit("BOOKED");
              });
              break;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 50,
            width: 120,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow:
                    Provider.of<UserEventTabBarProvider>(context, listen: true)
                                .menuClick ==
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
            child: Center(child: Text(title,style:  Provider.of<UserEventTabBarProvider>(context, listen: true)
                .menuClick ==
                pos? TextStyle(  color: Color(0xFF044a87)):TextStyle(  color: Colors.black))),
          ),
        ));
  }

  hitButton(int pos, BuildContext context) {
    Provider.of<UserEventTabBarProvider>(context, listen: false)
        .setMenuClick(pos);
  }
}
