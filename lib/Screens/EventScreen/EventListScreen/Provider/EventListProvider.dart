
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';

class EventListProvider extends ChangeNotifier {
  bool eventListLoad = true;
  EventListModel? eventListModel;
  bool paginationLoading = true;
  String? message = " ";

  get loading => eventListLoad;

  List users = [];

  var valueSelectedarchive = "Unarchive";
  var valueSelectedActive = "Active";
  List<String> archive = ['Archive', 'Unarchive'];
  List<String> Active = ['Active', 'In-Active'];
int   totalNumberEvent=0;
  hitGetEvents(
      BuildContext context,
      value,
      userId,
      int page,
      roleName,
      String? search,
      String valueSelectedActive,
      String valueSelectedarchive) async {
    var companyId = await getCompanyId();
    var roleTitle = await getRoleInfo();
    Map<String, dynamic> map = {};

    map=roleTitle.toString().toUpperCase()=="COMPANY"?{  'userId': userId,
      "companyId": userId,
      'roleTitle': roleName,
      'searchType': value,
      'page': page.toString(),
      "searchText": search,
      "isActive": valueSelectedActive == "Active" ? "true" : "false",
      "isDeleted": valueSelectedarchive == "Unarchive" ? "false" : "true"
    }:{  'userId': userId,
      "companyId": companyId,
      'roleTitle': roleName,
      'searchType': value,
      'page': page.toString(),
      "searchText": search,
      "isActive": valueSelectedActive == "Active" ? "true" : "false",
      "isDeleted": valueSelectedarchive == "Unarchive" ? "false" : "true"
    };
    eventListLoad = true;
    notifyListeners();
    print(map);
    try {
      eventListModel = await hitEventsListAPI(map);

      eventListLoad = false;
      message = eventListModel!.message.toString();
      totalNumberEvent=eventListModel!.totalCount!;

      // var dateFormat = DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
      // var utcDate = dateFormat.format(DateTime.parse("2022-04-06T12:43:51.000Z")); // pass the UTC time here
      // var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
      // String createdDate = dateFormat.format(DateTime.parse(localDate)); //
      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitSearchEvent(
      BuildContext context, String value, String? getId, int page) async {
    Map<String, dynamic> map = {
      'searchText': value,
    };
    eventListLoad = true;
    notifyListeners();
    print(map);
    try {
      eventListModel = await hitEventsListAPI(map);

      eventListLoad = false;
      // message = _loginListModel.message.toString();
      // var id = loginListModel.data!.id;
      // saveData(id);
      // showMessage(message!, context);

      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitEventInterested(
      BuildContext context, String value, String? getId, int page) async {
    Map<String, dynamic> map = {
      'userId': getId,
      'searchText': value,
    };
    eventListLoad = true;
    notifyListeners();
    print(map);
    try {
      eventListModel = await hitEventInterestedAPI(map);

      eventListLoad = false;

      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitEventsFavoutite(BuildContext context, value, userId, int page) async {
    Map<String, dynamic> map = {
      'userId': userId,
      'searchType': value,
      'page': page.toString(),
    };
    eventListLoad = true;
    notifyListeners();
    print(map);
    try {
      eventListModel = await hitEventsListAPI(map);

      eventListLoad = false;
      // message = _loginListModel.message.toString();
      // var id = loginListModel.data!.id;
      // saveData(id);
      // showMessage(message!, context);

      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  setSelectedActive(
    value,
  ) {
    valueSelectedActive = value;

    notifyListeners();
  }

  setSelectedarchive(
    value,
  ) {
    valueSelectedarchive = value;

    notifyListeners();
  }

  resetvalueFliter() {
    valueSelectedarchive = "Unarchive";
    valueSelectedActive = "Active";
  }

  hitBookEventList(
      BuildContext context, int page, bool pagination, String taber) async {
    var companyId = await getCompanyId();
    var roleName = await getRoleInfo();
    var getId = await getUserId();
    Map<String, dynamic> map = {
      'userId': getId,
      "companyId": companyId==""?getId:companyId,
      'accessLevel': roleName.toString().toUpperCase(),
      'page': page,
    };

    print(map);
    if (pagination)
      paginationLoading = true;
    else
      eventListLoad = true;
    notifyListeners();

    try {
      eventListModel = await hitEventBookListApi(map);

      eventListLoad = false;
      paginationLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }
}
