import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../../Model/MyPlanModel.dart';

class MyPlanProvider extends ChangeNotifier {
  bool loading = false, loderCancel = false;
  List<Group> groupList = [];
  MyPlanModel? myPlanModel;
  DateFormat format = new DateFormat("MMM-dd-yyyy");
  var inputFormat = DateFormat('MMM-dd-yyyy');

  //difference between start Date and end Date
  int differnceDays = 0;
  var refundPrice = 0.0;
  var planPrice = 0.0;
  int refundDay = 0;

  // per Day price plan
  var planPerDayPrice = 0.0;
  Map<dynamic, dynamic> planData = {};
  Map<dynamic, String> dataObject = {};
  List productMap = [];

  hitMyPlan() async {
    var userId = await getUserId();
    planData = {};
    dataObject = {};
    productMap = [];
    loading = true;
    notifyListeners();
    Map<String, dynamic> map = {
      "userId": userId,
      "deviceType": Platform.isIOS == true ? "IOS" : "ANDROID"
    };

    print(map);
    try {
      myPlanModel = await hitMyPlanApi(map);
      setActive(myPlanModel!);
      notifyListeners();
      loading = false;
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      loading = false;
      print(e.toString());
      notifyListeners();
    }
  }

  hitMyPlanCancel() async {
    var userId = await getUserId();
    loderCancel = true;
    notifyListeners();
    Map<String, dynamic> map = {
      "userId": userId,
      "planData": productMap,
    };

    print(map);
    try {
      ResponseModel responseModel = await hitMyPlanCancelApi(map);
      showMessage(responseModel.message.toString());
      hitMyPlan();
      loderCancel = false;
      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();

    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      loderCancel = false;
      Navigator.pop(navigatorKey.currentState!.context);

      notifyListeners();
    }
  }

  PlanRefundPrice(Group group) {
    refundPrice = 0.0;

    var startDate = format.parse(group.startDate.toString());
    var endDate = format.parse(group.endDate.toString());
    print("lakshit${planPrice}");
    if (startDate.compareTo(endDate) > 0) {
      differnceDays = startDate.difference(endDate).inDays;
      planPerDayPrice = planPrice / differnceDays;
      refundPrice = setRefundMoney(startDate, planPerDayPrice, endDate);
      print("refuncPrice${refundPrice}");
    } else {
      differnceDays = endDate.difference(startDate).inDays;
      planPerDayPrice = planPrice / differnceDays;
      refundPrice = setRefundMoney(startDate, planPerDayPrice, endDate);
      print("refuncPrice${refundPrice}");
      notifyListeners();
    }
  }

  setRefundMoney(DateTime startDate, double planPerDayPrice, DateTime endDate) {
    refundDay = DateTime.now().difference(startDate).inDays;
    if (refundDay < 7) {
      refundPrice = planPrice;
      notifyListeners();

      print(endDate);
    } else {
      refundPrice = planPerDayPrice * refundDay;
      print(refundDay);
      print("object${refundPrice}");
      notifyListeners();
    }
    return refundPrice;
  }

  void setActive(MyPlanModel myPlanModel) {
    for (int i = 1; i < myPlanModel.group!.length; i++) {
      print(i);
      if (myPlanModel.group![0].chargeId == myPlanModel.group![i].chargeId) {
        myPlanModel.group![0].isActive = false;
        myPlanModel.group![i].isActive = false;
        notifyListeners();
      } else {
        myPlanModel.group![0].isActive = true;
        myPlanModel.group![i].isActive = true;
        notifyListeners();
      }
    }
  }

  void setPlanDataValue(Group group) {
    planData = {};
    dataObject = {};

    planData['chargeId'] = group.chargeId.toString();
    planData['startDate'] = group.startDate.toString();
    planData['endDate'] = group.endDate.toString();
    planData['title'] = group.data!.title.toString();
    dataObject['_id'] = group.data!.id.toString();
    planData['data'] = dataObject;
    planData['finalPrice'] = group.data!.finalPrice!;
    planData['validity'] = group.data!.validity.toString();
    planPrice += group.data!.finalPrice;

    addListItem(planData);

    PlanRefundPrice(group);
  }

  void addListItem(Map<dynamic, dynamic> planData) {
    productMap.add(planData);
    print(productMap);
    notifyListeners();
  }

  void setPlanRemoveValue() {
    productMap = [];
    planData = {};
    dataObject = {};
    planPrice = 0.0;
    for (int i = 0; i < myPlanModel!.group!.length; i++) {
      if (myPlanModel!.group![i].isChecked == true) {
        planData['chargeId'] = myPlanModel!.group![i].chargeId.toString();
        planData['startDate'] = myPlanModel!.group![i].startDate.toString();
        planData['endDate'] = myPlanModel!.group![i].endDate.toString();
        planData['title'] = myPlanModel!.group![i].data!.title.toString();
        dataObject['_id'] = myPlanModel!.group![i].data!.id.toString();
        planData['data'] = dataObject;
        planData['finalPrice'] = myPlanModel!.group![i].data!.finalPrice!;
        planData['validity'] = myPlanModel!.group![i].data!.validity!;
        planPrice += myPlanModel!.group![i].data!.finalPrice;
        productMap.add(planData);

        notifyListeners();
        PlanRefundPrice(myPlanModel!.group![i]);
      } else {
        PlanRefundPrice(myPlanModel!.group![i]);
      }
    }
  }

  void SetSinglePricePlan(Group group) {
    planPrice = 0.0;

    planPrice = group.data!.finalPrice.floorToDouble();

    notifyListeners();
    PlanRefundPrice(group);
  }

  reset() {
    productMap = [];
    notifyListeners();
  }
}