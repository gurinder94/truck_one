import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/TripPlannerScreen/Provider/TripPlannerTabbar.dart';
import 'package:provider/provider.dart';


class TripPlannerTabBar extends StatelessWidget {
  int pos;
  late String title;

  TripPlannerTabBar({required this.title,required this.pos});


  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => hitButton(pos, context),
        child:Container(
          height: 50,
          width: 120,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow:
              Provider.of<TripPlannerTabProvider>(context, listen: true).menuClick ==

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
          child: Center(child: Text(title,style:  Provider.of<TripPlannerTabProvider>(context, listen: true)
              .menuClick ==
              pos? TextStyle(  color: Color(0xFF044a87)):TextStyle(  color: Colors.black))),
        ),

    );


  }
  hitButton(int pos, BuildContext context) {
    Provider.of<TripPlannerTabProvider>(context, listen: false).
    setMenuClick(pos,context);
  }
}
