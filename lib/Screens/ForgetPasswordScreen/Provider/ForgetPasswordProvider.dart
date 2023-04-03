import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/ResetForgetModel.dart';
import 'package:my_truck_dot_one/Screens/ForgetPasswordScreen/Component/Forget_password_OTP.dart';

import '../../LoginScreen/LoginScreen.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  bool _loading = false;
  bool PasswordLoder = false;
  String? message;

  get loading => _loading;
  ResetModel? _showErrorMessage;

  ResetModel? get showErrorMessage => _showErrorMessage;

  ResponseModel? responseModel;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordconfirm = TextEditingController();

  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  bool obscureText = false;
  bool obscure = false;

  hitResetPassword(BuildContext context) async {
    var res;

    Map<String, String> map = {
      'email': email.text.toString(),
    };
    _loading = true;
    notifyListeners();
    try {
      _showErrorMessage = await hitforgetPasswordAPI(map);
      message = _showErrorMessage!.message;
      print(showErrorMessage!.data!.hash.toString());
      _loading = false;

      notifyListeners();
      showMessage(message!);
      email.text = "";
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForgetPasswordOtp()));
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

  void ShowVisiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  void ShowVisibleConfirmPassword() {
    obscure = !obscure;
    notifyListeners();
  }

  hitPassword(BuildContext context, String code1, String code2, String code3,
      String code4, String code5) async {
    var res;

    Map<String, String> map = {
      'userId': showErrorMessage!.data!.userId.toString(),
      'newPassword': password.text,
      'hash': showErrorMessage!.data!.hash.toString(),
      'otp': code1 + code2 + code3 + code4 + code5,
    };

    PasswordLoder = true;
    notifyListeners();
    try {
      responseModel = await hitResetotpPassword(map);
      message = responseModel!.message;

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false);
      PasswordLoder = false;
      notifyListeners();
      showMessage("Password changed successfully");
    } on Exception catch (e) {
      PasswordLoder = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    PasswordLoder = false;
    password = TextEditingController();
    passwordconfirm.text = "";
  }

  hitResetOtp(BuildContext context) async {
    var res;
    Map<String, String> map = {
      'userId': showErrorMessage!.data!.userId.toString(),
    };
    _loading = true;
    notifyListeners();
    try {
      print(
        showErrorMessage!.data!.userId.toString(),
      );
      _showErrorMessage = await hitforgetPasswordAPI(map);
      message = _showErrorMessage!.message;
      print(
        showErrorMessage!.data!.userId.toString(),
      );
      _loading = false;
      notifyListeners();
      showMessage(message!);
      email.text = "";
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ForgetPasswordOtp()));
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

  void resetData() {
    email.text = "";
    password.text = "";
    passwordconfirm.text = "";

    code1.text = "";
    code2.text = "";
    code3.text = "";
    code4.text = "";
    code5.text = "";
  }
}
