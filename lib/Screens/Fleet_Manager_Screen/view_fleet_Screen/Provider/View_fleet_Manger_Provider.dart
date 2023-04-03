import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/Fleet_manager_model/fleet_manager_detail_model.dart';


class ViewFleetManagerProvider extends ChangeNotifier
{
  late FleetManagerDetailModel fleetManagerDetailModel;
  bool fleetLoading =true;
  String ?message;
  hitFLeetDetails(BuildContext context, String id,) async {
    var getId= await getUserId();


    Map<String, dynamic> map = {
     "_id":id,
    };
    fleetLoading = true;
notifyListeners();
    print(map);
    try {
      fleetManagerDetailModel = await hitFleetManagerDetailApi(map);

      fleetLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      fleetLoading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }


}