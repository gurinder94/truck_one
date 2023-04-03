import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';

class HosMapProvider extends ChangeNotifier {
  int menuClick = 0;
 RouteModel routeModel= RouteModel();
  setMenuClick(int pos) {
    menuClick = pos;

    notifyListeners();
  }
  var days=[];
  TextEditingController speed = TextEditingController();
  hitHos(String value, int index) {

    print(value);
    days = [];
    if (value != '') {
      print(value);

      var totalDistance =
          ((routeModel.routes![index].summary!.lengthInMeters! / 10) / 100) *
              0.621371;
      var totalTime =
          (routeModel.routes![index].summary!.travelTimeInSeconds)!.floor() /
              3600;
      //
      print(totalTime);
      var totalTravelDistance = 10.5 * int.parse(value);
      var noOfDays = totalDistance / totalTravelDistance;
      for (var i = 0; i < noOfDays; i++) {
        if (i == 0) {
        } else {
          days.add(i);
        }
      }
      print(days);
      notifyListeners();
    } else {
      print(value);
      days = [];

    }
    notifyListeners();
  }
}
