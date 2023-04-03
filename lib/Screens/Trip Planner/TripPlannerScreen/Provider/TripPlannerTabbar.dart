import 'package:flutter/material.dart';


class TripPlannerTabProvider  extends ChangeNotifier {
  int menuClick = 0;

  String ? tabName="Trip Detail";

  setMenuClick(int pos, BuildContext context) {
    menuClick = pos;
    switch(pos)
    {
      case 0:
        tabName="Trip Details";
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => TripDetails()));
        break;
      case 1:
        tabName='Driver Information';
        break;
      case 2:
        tabName='Truck Information';
        break;
      case 3:
        tabName="Trailer Information";
        break;
      case 4:
        tabName="Team Information";
        break;
    }

    notifyListeners();
  }
}
