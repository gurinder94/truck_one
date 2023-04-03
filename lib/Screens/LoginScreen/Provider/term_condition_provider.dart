import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/chat_socket_connection.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/LoginListModel.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/CompanyProfile.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Userprofile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';

class TermConditionProvider extends ChangeNotifier {
  ResponseModel? _responseModel;
  bool loading = false;
  var message = "";
  String email;

  TermConditionProvider(this.email);

  hitTermCondition(BuildContext context) async {
    loading=true;
    notifyListeners();
    try {
      var getId = await getUserId();
      var roleTitle = await getRoleInfo();
      var profilecomplete=await getProfileComplete();
      var
      _responseModel =
          await hitAcceptPoliciesApi({"email": email, "userId": getId});

      loading = false;

      setPolicyStatus(true);
      nextPage(context,roleTitle,profilecomplete);
      notifyListeners();
    } on Exception catch (e) {
      loading = false;
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message);
      print(e.toString());
      notifyListeners();
    }

    loading = false;
  }

  nextPage(BuildContext context,String ? roleTitle,bool? profileComplete) {
    switch (roleTitle!.toUpperCase()) {
      case ("COMPANY"):

         if (profileComplete == false)
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => ProfileProvider(),
                      child: CompanyProfile(false))));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('Company', 0)),
              (Route<dynamic> route) => false);
        break;
      case ("ENDUSER"):

         if (profileComplete == false)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileUser(false)));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('User', 0)),
              (Route<dynamic> route) => false);
        break;
      case ("DISPATCHER"):
         if (profileComplete == false)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileUser(false)));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => BottomMenu('Dispatcher', 0)),
              (Route<dynamic> route) => false);

        break;
      case ("SELLER"):
        if (profileComplete == false)
          DialogUtils.AlertBox(
            context,
            onDoneFunction: () async {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            oncancelFunction: () => Navigator.pop(context),
            title: 'Profile Complete!',
            buttonTitle: "yes",
            alertTitle: "Kindly fill your profile before proceeding further.",
          );
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('Seller', 0)),
              (Route<dynamic> route) => false);
        break;
      case ("HR"):
        if (profileComplete == false)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileUser(false)));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('Hr', 0)),
              (Route<dynamic> route) => false);
        break;
      case ("DRIVER"):
         if (profileComplete == false)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileUser(false)));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('Driver', 0)),
              (Route<dynamic> route) => false);
        break;

      case ("SALESPERSON"):
        if (profileComplete == false)
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileUser(false)));
        else
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomMenu('Saleperson', 0)),
              (Route<dynamic> route) => false);
        break;
      default:
        print("Plz Check profile");
    }
  }
}
