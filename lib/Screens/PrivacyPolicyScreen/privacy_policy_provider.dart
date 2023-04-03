import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/privacy_policy_model.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  bool loader = false;
  String message = "";
  PrivacyPolicyModel? privacyPolicyModel;

  hitPrivacyPolicy(String type) async {
    Map<String, dynamic> map = {"type": type};

    loader = true;

    try {
      privacyPolicyModel = await hitPrivacyPolicyModelApi(map);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(e.toString());
      notifyListeners();
    }
    loader = false;
  }
}
