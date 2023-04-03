import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';

class ContactProvider extends ChangeNotifier {
  var value = 1;
  List<String> userPlanList = [];

  setValue(var value) {
    this.value = value;

    notifyListeners();
  }

  Map<String, bool> mutiplePlan = {
    'E-Commerce': false,
    'Event': false,
    'Job': false,
    'Services': false,
    'TripPlanner': false,
    'Weather': false
  };
  late String message;
  var PlanList = [
    'E-Commerce',
    'Event',
    'Job',
    'Services',
    'Trip Planner',
    'Weather'
  ];
  late ResponseModel _responseModel;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController plan = TextEditingController();
  TextEditingController description = TextEditingController();
bool loading =false;
  hitcontactUsForm(Map<String, dynamic> map, BuildContext context) async {

    loading=true;
    notifyListeners();
    var roleName = await getRoleInfo();
    try {
      print(map);
      _responseModel = await contactUsFormApi(map);

      showMessage(
      _responseModel.message.toString());
      NavigationToNextScreen(roleName,context);


      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
      notifyListeners();
    }
    loading=false;
    notifyListeners();
  }
  NavigationToNextScreen(roleName, BuildContext context)
  {
    switch(roleName.toString().toUpperCase())
    {
      case "COMPANY":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Company',4)));

      case "HR":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Hr',4)));


      case "DRIVER":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Driver',4)));

      case "DISPATCHER":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Dispatcher',4)));

      case "SELLER":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Seller',4)));

      case "SELLER":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Seller',4)));
      case "SALESPERSON":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('Salerperson',4)));
      case "ENDUSER":
        return   Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => BottomMenu('User',4)));

    }
  }
}
