import 'package:flutter/material.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/constants.dart';
import '../../LoginScreen/LoginScreen.dart';

class OtpProvider extends  ChangeNotifier
{

  bool _loading = false;
  get loading => _loading;

  String message="";
  hitAccountVerifyyOtp(
      BuildContext context,
      TextEditingController code1,
      TextEditingController code2,
      TextEditingController code3,
      TextEditingController code4,
      TextEditingController code5, String resetkey) async {
    var res;
    Map<String, dynamic> map = {
      'resetkey': resetkey,
      'otp': code1.text + code2.text + code3.text + code4.text + code5.text,
    };
    _loading = true;
    notifyListeners();
    print(map);
    try {
      res = await hitRegistionOtp(map);
      _loading = false;
      notifyListeners();
      message = "Account verified successfully";
      showMessage(message,);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

}