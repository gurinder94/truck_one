import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import 'package:my_truck_dot_one/Model/ProfileModel/UserModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/company_leave_model.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileViewProvider extends ChangeNotifier {
  bool _loading = false;
  String ? checkRole;

  get loading => _loading;
  UserModel ?userModel;
  List<String> qualificationList = [];
  List<String> languageList = [];
  List<String> skillList = [];
  String? drivingLicense;
  String? drivingName;
  String? resumeName;
  String? resume;
  String? additionalDocument;
  String? additionalDocumentName;
  String? certificate;
  String ?message;

  String? certificateName;
  String? drivingId;
  String? resumeId;
  String? additionalDocumentId;
  String? certificateId;
  late ReasonLeaveListModel companyLeaveModel;
  List <Document>documentDriverList = [];
  bool companyLeft = false;

  var valueItemSelected;
  late ResponseModel responseModel;

  hitUserProfileDetails(BuildContext context) async {
    documentDriverList = [];
    var getId = await getUserId();
    {
      Map<String, dynamic> map = {
        'endUserId': getId.toString(),
      };
      qualificationList = [];
      languageList = [];
      skillList = [];
      _loading = true;
      print(map);
      notifyListeners();

      try {
        userModel = await hitUserProfileApi(map);
        setprofileInfo(
            userModel!.data!.proImage == null ? '' : userModel!.data!.proImage);
        setDataProfile(userModel!.data);


        _loading = false;

        notifyListeners();
      } on Exception catch (e) {
        message = e.toString().replaceAll('Exception:', '');
        showMessage(message!);

        notifyListeners();
      }
      _loading = false;
    }
  }

  void setSelectedItem([String ?reasonTitle]) {
    valueItemSelected = reasonTitle;

    print(reasonTitle);
    notifyListeners();
  }

  hitRemoveDocument(String documentId, String fileId,
      UserProfileViewProvider proData, int index) async {
    var getId = await getUserId();
    Map<String, String> map = {
      'documentId': documentId,
      'userId': getId,
      'file': fileId,
    };
    proData.documentDriverList.removeAt(index);
    print(map);
    _loading = true;
    try {
      responseModel = await hitRemoveDocumentApi(map);

      _loading = false;

      notifyListeners();
    } on Exception {
      _loading = false;

      notifyListeners();
    }
  }

  hitCompanyList() async {
    var getId = await getUserId();
    Map<String, String> map = {
      "isActive": "true",
      "isDeleted": "false",
      "reasonType": "leaveReason"
    };

    print(map);

    try {
      companyLeaveModel = await hitCompanyLeaveListApi(map);

      notifyListeners();
    } on Exception {
      notifyListeners();
    }
  }

  hitCompanyLeave(BuildContext context) async {
    companyLeft = true;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    var getId = await getUserId();
    var userName = await getNameInfo();
    var accessLevel = await getRoleInfo();
    Map<String, String> map = {

      "companyId": userModel!.data!.createdById.toString(),
      "reason": valueItemSelected,
      "userId": getId,
      "userName": userName,
      "accessLevel": accessLevel.toString().toUpperCase(),
    };

    print(map);

    try {
      responseModel = await hitCompanyLeaveApi(map);

      await pref.clear();

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false);
      companyLeft = false;

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message.toString());

      print(e.toString());
      notifyListeners();
      companyLeft = false;
      notifyListeners();
    }
  }

  getroleName() async {
    checkRole = await getRoleInfo();

    print(checkRole);
  }

  void setDataProfile(Data ?data) {
    for (int i = 0; i < data!.qualification!.length; i++) {
      qualificationList
          .add(data.qualification![i].qualification.toString());
    }
    for (int i = 0; i < data.language!.length; i++) {
      languageList.add(data.language![i]);
    }
    for (int i = 0; i < data.skillData!.length; i++) {
      skillList.add(data.skillData![i].skill.toString());
    }
    documentDriverList.addAll(data.documents!);
  }
}
