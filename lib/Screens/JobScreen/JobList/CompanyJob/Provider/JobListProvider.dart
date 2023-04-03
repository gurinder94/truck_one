import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/JobModel/Applicant.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobListModel.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel.dart';

class JobListProvider extends ChangeNotifier {
  bool jobListLoad = false;
  bool jobViewApplicants = false;
  JobListModel? jobListModel;
  Applicant? applicant;
  JobModel jobModel = JobModel();
  Datum datum = Datum();
  var valueSelected = "Archived";
  var activeType= "Active";
  String? message = " ";

  get loading => jobListLoad;
  String? getId;

  List<String> get items => _items;

  List<String> get items2 => _items2;
  TextEditingController searchEditingController = TextEditingController();
  List locationChks = [];

  hitGetJobList(
    BuildContext context,
    String? getId,
    String? roleName,
  ) async {
    String   getRoleName= await getRoleInfo();
    var companyId= await getCompanyId();
    Map<String, dynamic> map = {};
    getRoleName.toUpperCase()=="COMPANY"? map={ 'userId': getId,
      'isActive':activeType=="Active"?"true":"false",
      'isDeleted':valueSelected=="Archived"?"true":"false",
    "companyId": getId,
    }:map={
      'userId': getId,
      'isActive':activeType=="Active"?"true":"false",
      'isDeleted':valueSelected=="Archived"?"true":"false",
      "companyId": companyId,

    };

    jobListLoad = true;
    notifyListeners();
    print(map);
    try {
      jobListModel = await hitCompanyJobListApi(map);


      jobListLoad = false;

      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  List<String> _items = [
    "Active",
    "In-Active",
  ];

  void setSelectedItem(String s) {
    activeType = s;
    notifyListeners();
  }

  List<String> _items2 = [
    "UnArchived",
    "Archived",];

  void setArchivedItem(String s) {
    valueSelected = s;
    notifyListeners();
  }

  hitViewApplicants(
    BuildContext context,
    String? getId,
    String? id,
  ) async {
    Map<String, dynamic> map = {
      'userId': getId,
      'jobId': id,

    };

    jobViewApplicants = true;
    notifyListeners();
    print(map);
    try {
      applicant = await hitViewApplicantsApi(map);
      print(applicant!.totalCount.toString());

      jobViewApplicants = false;

      notifyListeners();
    } on Exception catch (e) {
      jobViewApplicants = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitSearchJob(getId, BuildContext context, String value) async {

    Map<String, dynamic> map = {
      'userId': getId,
      'searchKey': value,
      "locationChks":locationChks,
      // "educationChks":value,
      // "industryChks":value
      // 'isActive': valueItemSelected=="Is-Active"?"true":"false",
      // 'isDeleted': valueSelected=="Archived"?"true":"false",
    };

    jobListLoad = true;
    notifyListeners();
    print(map);
    try {
      jobListModel = await hitCompanyJobListApi(map);

      jobListLoad = false;
      // ChangeNotifierProvider(
      //     create: (_) => JobListProvider(),
      //     child: UserJobList());
      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }
}
