import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/company_leave_model.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';

class DispatcherProvider extends ChangeNotifier {
  bool tripPlannerListLoad = false;
  String? reasonType;
  DateTime? startDateTime;
  var selectValue;
  String name = '';
  String checkValue = "UPCOMING";
  String? id;
  bool reasonLeaveLoad = false, reasonLeaveButton = false;
  ScrollController scrollController = ScrollController();
  TripPlannerList? tripPlannerList;
  late ReasonLeaveListModel reasonLeaveListModel;
  late String message;
  var startDate = TextEditingController();
  var roleName;
  List<TripPlannerModel> tripList = [];

  var page = 1;

  var pagination = false;
  var sortList=["A-Z","Z-A"];
  var sort;

  void addScrollListener(BuildContext context, String type, String search) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!pagination) {
          if (tripList.length < tripPlannerList!.totalCount!) {
            pagination = true;
            page = page + 1;
            hitTripList(type, search);
          }
        }else{
          pagination = false;
        }
      }
    });
  }

  hitTripList(
    String type,
    String search,
  ) async {
    var getid = await getUserId();
    var roleName = await getRoleInfo();
    var companyId = await getCompanyId();
    var startDate = startDateTime == null
        ? null
        : DateTime(startDateTime!.year, startDateTime!.month,
            startDateTime!.day, 23, 59, 59, 000);
    if (pagination == false) {
      page = 1;
      tripPlannerListLoad = true;
      pagination = false;
      tripList = [];
      tripList.clear();
    } else {
      pagination = true;
    }
    notifyListeners();
    Map<String, dynamic> map = {
      "createdById": getid,
      "page": page,
      "runningStatus": type,
      "searchText": search,
      "roleTitle": roleName.toString().toUpperCase(),
      "routeFlag": selectValue == null ? "" : selectValue,
      "filterDate": startDateTime == null
          ? ""
          : DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(startDateTime!.toUtc())
    };

    notifyListeners();
    log("$map");
    try {
      tripPlannerList = await hitTripPlannerListApi(map);

      tripList.addAll(tripPlannerList!.data!);

      tripPlannerListLoad = false;
      notifyListeners();
      message = tripPlannerList!.message.toString();
    } on Exception catch (e) {
      tripPlannerListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      // showMessage(message!, context);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitReasonList() async {
    Map<String, dynamic> map = {"reasonType": "cancelReason"};

    reasonLeaveLoad = true;
    notifyListeners();
    print(map);
    try {
      reasonLeaveListModel = await hitReasonListApi(map);
      reasonLeaveLoad = false;

      notifyListeners();
      message = tripPlannerList!.message.toString();
    } on Exception catch (e) {
      reasonLeaveLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      // showMessage(message!, context);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitReasonCancel(DispatcherProvider listProvider, String driverId,
      String tripid, String typeReason) async {
    var getId = await getUserId();
    var userName = await getNameInfo();
    var roleName = await getRoleInfo();
    print(id);
    Map<String, dynamic> map = {
      "cancelledById": getId,
      "reasonType": reasonType,
      "runningStatus": typeReason,
      "_id": tripid,
      "userName": userName,
      "driverId": driverId,
      "userId": getId,
      "accessLevel": roleName.toString().toUpperCase(),
      "roleTitle":
          roleName.toString().toUpperCase() == "COMPANY" ? "COMPANY" : "ENDUSER"
    };

    reasonLeaveButton = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel responseModel = await hitReasonCancelApi(map);

      Navigator.pop(navigatorKey.currentState!.context, "yes");
      reasonLeaveButton = false;
      notifyListeners();
      message = tripPlannerList!.message.toString();
    } on Exception catch (e) {
      reasonLeaveButton = false;
      message = e.toString().replaceAll('Exception:', '');

      print(e.toString());
      notifyListeners();
    }
  }

  getrole() async {
    this.roleName = await getRoleInfo();
  }

  void setSelectedItem(String newValue, id) {
    print(newValue);
    reasonType = newValue;

    this.id = id;

    // print(reasonTitle);
    // notifyListeners();
  }

  void restDrop() {
    reasonType = null;
    notifyListeners();
  }

  setValuefliter(String value) {
    checkValue = value;
    notifyListeners();
  }

  removeList(int index) {
    tripList.removeAt(index);
    notifyListeners();
  }

  resetList() {
    tripList = [];
    notifyListeners();
  }

  Future<void> getDate(
    BuildContext context,
  ) async {
    DateTime? _dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_dateTime != null) {
      startDate.text = DateFormat("MMM dd, yyyy").format(_dateTime);
      startDateTime = _dateTime;
      notifyListeners();

      // } else {
      //   endDate.text = DateFormat("MMM dd, yyyy").format(_dateTime);
      //   _provider!.endDateTime = _dateTime;
      // }
    }
  }

  void setSelectedDate(String newValue) {
    selectValue = newValue;

    notifyListeners();
    startDateTime = null;
    startDate.text = "";
  }

  resetFliter() {
    startDate.text = "";
    selectValue = null;
  }

  void hitFilter(type) {
    tripList = [];
    hitTripList(type, "");

    Navigator.pop(navigatorKey.currentState!.context);
  }

  resetDate(String type) {
    tripList = [];
    startDateTime = null;
    startDate.text = "";
    hitTripList(type, "");
    Navigator.pop(navigatorKey.currentState!.context);
    notifyListeners();
  }
}
