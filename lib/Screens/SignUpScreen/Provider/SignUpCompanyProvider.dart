
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/SignUp_otp_Screen/Signupotp.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import 'otp_provider.dart';

class CompanyProvider extends ChangeNotifier {

  bool obscureText = false;
  bool obscure = false;
  var contextt;
  String? resetkey;
  String show = "false";
  var company = 0;
  bool _loading = false;
  get loading => _loading;
  String? message;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController companyName = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobilenumber = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  hitComapny(BuildContext context) async {
    var res;

    Map<String, String> map = {
      'email': email.text,
      'password': password.text,
      'companyName': companyName.text,
      'firstName': firstname.text,
      'lastName': lastName.text,
      'mobileNumber': mobilenumber.text,
      'roleTitle': "COMPANY",
      'contactPerson': firstname.text + " " + lastName.text,
    };

    _loading = true;
    notifyListeners();
    try {
      res = await hitCompanyApi(map);
      message = res['message'];
      resetkey = res['data']['resetkey'];
      showMessage(message!, );
      hitchecktoken(context);
      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      showMessage(message!,);
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
              builder: (context) =>
                  ChangeNotifierProvider(
                      create: (_) =>  OtpProvider(),
                      child: SignUpOtp(resetkey!))));
      companyName.text = "";
      password.text = "";
      firstname.text = "";
      mobilenumber.text = "";
      email.text = "";
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
    companyName.text = "";
    password.text = "";
    firstname.text = "";
    lastName.text = "";
    mobilenumber.text = "";
    email.text = "";
    confirmpassword.text = "";
  }

  validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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

  validation() {
    show = "true";
    notifyListeners();
  }

  validationn() {
    show = "false";
    notifyListeners();
  }
}
String pattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExp = new RegExp(pattern);

validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}
