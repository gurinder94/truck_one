import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/view_service_List.dart';

class ViewServiceProvider extends ChangeNotifier

{
  bool loading = true;
  String message='';
  ViewServiceList viewServiceList =ViewServiceList();
  hitViewService(BuildContext context, String id) async {
    var getid = await getUserId();
    Map<String, String> map = {
      "_id": id
      ,
    };

    loading = true;
    notifyListeners();
    print(map);

    try {
      viewServiceList= await hitViewServiceList(map);
      notifyListeners();


    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
}