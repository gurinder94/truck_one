
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/SignUp_otp_Screen/Signupotp.dart';
import 'package:provider/provider.dart';

import 'otp_provider.dart';

class UserProvider extends ChangeNotifier {
  bool _loading = false;
  String? message;
  bool obscureText = false;
  bool obscure = false;
  var contextt;
  var resetkey;
  var click = "User";

  get loading => _loading;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  hitUser(BuildContext context) async {
    var res;

    Map<String, dynamic> map = {
      'email': email.text,
      'password': password.text,
      'firstName': firstName.text,
      'lastName': lastName.text,
      'mobileNumber': mobilenumber.text,
      'roleTitle': "ENDUSER",
      'personName': firstName.text + " " + lastName.text
    };
    _loading = true;
    notifyListeners();

    try {
      res = await hitUserAPI(map);

      message = res['message'];
      resetkey = res['data']['resetkey'];

      showMessage(message!);
      hitchecktoken(context);

      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

  hitchecktoken(BuildContext context) async {
    var res;

    Map<String, dynamic> map = {
      'token': resetkey,
    };
    _loading = true;
    notifyListeners();

    try {
      res = await hitCheckToken(map);
      _loading = false;
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => OtpProvider(), child: SignUpOtp(resetkey!))));

      Resetmodel();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

  Resetmodel() {
    email.text = "";
    password.text = "";
    firstName.text = "";
    mobilenumber.text = "";
    confirmpassword.text = "";
    lastName.text = "";
  }

  confirmPaswordValidation(String Value) {
    if (Value.length == 0) {
      return 'Please enter Password';
    } else if (password.text != Value) {
      return 'Password Not match';
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
}

validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
