import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddTripPlannerScreen/Provider/TripTabBarProvider.dart';

import 'package:provider/provider.dart';
class TripTabBar extends StatelessWidget {
 int pos;
  late String title;

 TripTabBar({required this.title,required this.pos});


  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => hitButton(pos, context),
        child: Provider.of<TripTabBarProvider>(context, listen: true).menuClick ==
            pos
            ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
          height: 50,
          width: 120,

          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD9D8D8),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 7,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.4),
                    offset: Offset(-5.0, -5.0),
                    blurRadius: 10,
                  ),
                ]),
          child: Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20),boxShadow: [
                    BoxShadow(
                      color: Color(0xFFD9D8D8),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.white.withOpacity(.4),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10,
                    ),
                  ]),
              child: Center(child: Text(title,style: TextStyle(color: Color(0xFF044a87)),)),
          ),
        ),
            )
            : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
          height: 50,
          width: 120,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xF8C6C4C4),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10,
                      spreadRadius: -4),
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    offset: Offset(-3.0, -3.0),
                    blurRadius: 7,
                  ),
                ]),
          child: Center(child: Text(title)),
        ),
            )
    );


  }
  hitButton(int pos, BuildContext context) {
    Provider.of<TripTabBarProvider>(context, listen: false).setMenuClick(pos);
  }
}
