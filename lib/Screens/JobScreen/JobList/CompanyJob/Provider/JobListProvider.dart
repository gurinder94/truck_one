import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/Applicant.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobListModel.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Model/isReadedModel.dart';

class JobListProvider extends ChangeNotifier {
  bool jobListLoad = false;
  bool jobViewApplicants = false;
  JobListModel? jobListModel;
  IsReaded? constantModell;
  Applicant? applicant;
  JobModel jobModel = JobModel();
  Datum datum = Datum();
  var valueSelected = "Archived";
  var activeType = "Active";
  String? message = " ";

  TextEditingController dateController = TextEditingController();

  var selectItems;
  var selectRead;

  var title = ["All", "Accepted", "Rejected", "On-Hold"];
  var read = ["All", "Read", "Un-Read"];

  get loading => jobListLoad;
  String? getId;
  var sortList = [
    "A-Z",
    "Z-A",
  ];
  var sort;

  List<String> get items => _items;

  List<String> get items2 => _items2;
  TextEditingController searchEditingController = TextEditingController();
  List locationChks = [];

  hitGetJobList(
    BuildContext context,
    String? getId,
    String? roleName,
  ) async {
    String getRoleName = await getRoleInfo();
    var companyId = await getCompanyId();
    Map<String, dynamic> map = {};
    getRoleName.toUpperCase() == "COMPANY"
        ? map = {
            'userId': getId,
            'isActive': activeType == "Active" ? "true" : "false",
            'isDeleted': valueSelected == "Archived" ? "true" : "false",
            "companyId": getId,
          }
        : map = {
            'userId': getId,
            'isActive': activeType == "Active" ? "true" : "false",
            'isDeleted': valueSelected == "Archived" ? "true" : "false",
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
    "Archived",
  ];

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
      "count": 3,
      "isRead": selectRead == null
          ? ""
          : selectRead == "Read"
              ? true
              : false,
      "isStatus": selectItems.toString().toLowerCase() == "all"
          ? ""
          : selectItems.toString().toLowerCase() == "on-hold"
              ? "onHold"
              : selectItems == null
                  ? ""
                  : selectItems.toString().toLowerCase() == "accepted"
                      ? "accept"
                      : selectItems.toString().toLowerCase() == "rejected"
                          ? "reject"
                          : selectItems.toString().toLowerCase(),
      'userId': getId,
      'jobId': id,
      "searchDate": dateController.text,
      "searchText": "",
      "page": 1
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
      "locationChks": locationChks,
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

  hitIsReaded(String id, String jobId) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {"appliedJobId": id};

    jobListLoad = true;
    notifyListeners();
    print(map);
    try {
      constantModell = await hitReadedApi(map);
      hitViewApplicants(navigatorKey.currentState!.context, getId, jobId);
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

  void resetFields() {
    dateController.clear();
    selectItems = null;
    selectRead == null;
    print(selectItems.toString() + "0000");
    notifyListeners();
  }
}
