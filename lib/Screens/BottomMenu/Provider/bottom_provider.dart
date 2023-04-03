import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/chat_socket_connection.dart';
import '../../../AppUtils/constants.dart';
import '../../LoginScreen/LoginScreen.dart';

class BottomProvider extends ChangeNotifier {
  int menuClick = 0;
  String message = '';
  String language = "english";
  bool loading = false;

  setMenuClick(int pos) {
    menuClick = pos;
    notifyListeners();
  }

  getChatSocket(BuildContext context) async {
    var getId = await getUserId();
  }

  getlocalLanguage() async {
    language = await getLanguage();
  }

  hitlogOut(BuildContext context) async {

    loading = true;
    notifyListeners();
    var date = new DateTime.now();
    var getid = await getUserId();
    var token=await getFireBaseToken();
    Map<String, dynamic> map = {
      "ipAddress": "",
      "logoutDate": date.toString(),
      "source": deviceName + ' ' + 'and' + ' ' + deviceVersion,
      "userId": getid,
      "DeviceId": token,
    };
    print(map);
    try {
      ResponseModel model = await hitLogoutApi(map);
      removeData();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
}
