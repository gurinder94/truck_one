import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/NetworkModel/normal_response.dart';
import '../../LoginScreen/LoginScreen.dart';

class DeactivateProvider extends  ChangeNotifier
{

  bool loading =false;
 late  ResponseModel _responseModel;

  hitcDeactivateAccount( ) async {
    var userId=await getUserId();
    Map<String, dynamic> map=
    {
    "id": userId
    };
    loading=true;
    notifyListeners();

    try {
      print(map);
      _responseModel = await hitDeactivateAccountApi( map);

      showMessage('Account Delete Sucessfully');


      Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
      final pref = await SharedPreferences.getInstance();
      await pref.clear();

      loading =false;


      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message,);
      loading =false;
      notifyListeners();
    }
    loading=false;
    notifyListeners();
  }

}