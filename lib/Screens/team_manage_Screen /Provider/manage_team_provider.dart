import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/manage_team_model 2.dart';

class ManageTeamProvider extends ChangeNotifier {
  bool loading = true;
  String? message;
  late ManageTeam manageTeam;

  ManageTeamProvider() {
    hitManageTeam('', '');
  }

  hitManageTeam(String? type, String search) async {
    var getId = await getCompanyId();

    Map<String, dynamic> map = {
      "accessLevel": "DISPATCHER",
      "companyId": getId,
      "isAccepted": type,
      "page": 1,
      "searchKey": search,
    };

    loading = true;
    notifyListeners();
    print(map);
    try {
      manageTeam = await hitManageTeanApi(map);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }
}
