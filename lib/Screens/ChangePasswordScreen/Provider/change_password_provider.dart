import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/DeactivateAccountScreen/Provider/Deactivate_provider.dart';
import 'package:provider/provider.dart';

import '../../MenuScreen/company_setting_screen.dart';

class ChangePasswordProvider extends ChangeNotifier {
  bool obscureText1 = false;
  bool obscureText2 = false;
  bool obscureText3 = false;
  bool loading = false;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  String message = '';
  ResponseModel _responseModel = new ResponseModel();

  void ShowVisibleOldPassword() {
    obscureText1 = !obscureText1;
    notifyListeners();
  }

  void ShowVisiblePassword() {
    obscureText2 = !obscureText2;
    notifyListeners();
  }

  void ShowVisibleConfirmPassword() {
    obscureText3 = !obscureText3;
    notifyListeners();
  }

  changePassword(BuildContext context) async {
    var getId = await getUserId();
    var language=await getLanguage();
    var  roleName=await getRoleInfo();

    Map<String, String> map = {
      'oldPassword': oldPassword.text,
      'newPassword': newPassword.text,
      'confirmPassword': confirmPassword.text,
      'id': getId,
    };

    loading = true;
    notifyListeners();
    print(map);

    try {
      _responseModel = await hitChangePassword(map);

      showMessage(_responseModel.message.toString());

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(create: (_) => DeactivateProvider(),child: CompanySettingPage(language))));
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message.toString());

      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
}
