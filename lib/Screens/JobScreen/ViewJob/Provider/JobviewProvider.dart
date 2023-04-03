import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobViewList.dart';


class JobViewProvider extends ChangeNotifier {
  int signUp = 0;

  bool _loading = true;
  String? message = " ";
  var roleName;
  late JobListDetailModel _jobModel;

  JobListDetailModel get jobModel => _jobModel;
  File? files;

  get loading => _loading;
var qualificationList=[];
  setClick(int pos) {
    signUp = pos;
    notifyListeners();
  }

  hitCompanyDetail(BuildContext context, String? id) async {

    qualificationList=[];
    var  getId= await getUserId();
    roleName = await getRoleInfo();
    print(loading);
    Map<String, dynamic> map = {
      '_id': id,
      'userId': getId,
    };

    _loading = true;
    notifyListeners();
    print(map);
    try {
      print(loading);

      _jobModel = await hitJobCompanyDetailApi(map);
      for(var qualification in
          _jobModel.data![0].qualificationData!)
      qualificationList.add(qualification.qualification );
      notifyListeners();


    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
    _loading = false;
  }
restmodel()
{
  _jobModel.data!.clear();
  notifyListeners();
}
  getRoleName() async {
    roleName = await getRoleInfo();
    notifyListeners();
  }
}
