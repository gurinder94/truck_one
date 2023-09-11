import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/Fleet_manager_model/fleet_manager_list_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/ResetForgetModel.dart';

class FleetManagerProvider extends ChangeNotifier {
  bool loading = false, PaginationLoader = false;
  String? message = "";
  ScrollController scrollController = new ScrollController();
  var valueItemSelected = "Active";
  var valueItemSelected2 = "Unarchived";
  bool visable = false;
  ResponseModel? _responseModel;
  int pagee = 1;
  var roleName;
  String searchText = "";
  List<String> items = [
    "Active",
    "In-Active",
  ];
  List<String> items2 = [
    "Unarchived",
    "Archived",
  ];
  FleetManagerModel? fleetManagerModel = null;
  List<Datum> FleetMangerList = [];



  var sort;

  FleetManagerProvider() {
    refresh();
    hitFLeetList(
      navigatorKey.currentState!.context,
    );
    addScrollListener();

    setlocalData();
  }

  hitFLeetList(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    var companyId = await getCompanyId();
   roleName = await getRoleInfo();

    print(PaginationLoader);
    if (PaginationLoader == true) {
      PaginationLoader = true;
    } else {
      FleetMangerList = [];
      loading = true;
      pagee = 1;
    }

    notifyListeners();
    Map<String, dynamic> map = {};
    map = {
      "companyId": companyId == '' ? getId : companyId,
      "isActive": valueItemSelected == "Active" ? "true" : "false",
      "isDeleted": valueItemSelected2 == "Archived" ? "true" : "false",
      "page": pagee,
      "roleName": roleName.toString().toUpperCase(),
      "searchText": searchText,
      "userId": getId
    };
    print(map);

    try {
      fleetManagerModel = await hitFleetManagerListApi(map);
      print("checkLength> ${fleetManagerModel!.data!.length}");
      if(pagee==1){
        FleetMangerList.clear();
      }
      FleetMangerList.addAll(fleetManagerModel!.data!);
      loading = false;
      PaginationLoader = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      PaginationLoader = false;
      loading = false;
      notifyListeners();
    }
  }

  void setSelectedItem(String s) {
    valueItemSelected = s;

    notifyListeners();
  }

  void setSelectedValue(String s) {
    valueItemSelected2 = s;
    notifyListeners();
  }

  resetValue() async {
    valueItemSelected = "Active";
    valueItemSelected2 = "Unarchived";
    FleetMangerList = [];

  }

  searchFliter(String val) {
    searchText = val;
    PaginationLoader = false;
    hitFLeetList(navigatorKey.currentState!.context);
  }

  refresh() {
    PaginationLoader = false;
    FleetMangerList = [];
    pagee = 1;

  }

  restList() {
    FleetMangerList = [];
  }

  void statusFliter(String valueItemSelected, String valueItemSelected2) {
    this.valueItemSelected = valueItemSelected;
    this.valueItemSelected2 = valueItemSelected2;
    print(valueItemSelected);
    hitFLeetList(navigatorKey.currentState!.context);
  }

  addScrollListener() {
    print("object");
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        PaginationLoader = true;
        if (PaginationLoader) {
          if (FleetMangerList.length < fleetManagerModel!.totalCount!) {
            pagee = pagee + 1;
            hitFLeetList(navigatorKey.currentState!.context);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  hitDeleteFleetManager(
      FleetManagerProvider proData, Datum fleetMangerList) async {
    Map<String, dynamic> map = {"id": fleetMangerList.id};

    try {
      _responseModel = await hitDeleteFleetManagerApi(map);

      proData.FleetMangerList.remove(fleetMangerList);
      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      notifyListeners();
    }
  }

  hitAtive(
      FleetManagerProvider proData, Datum fleetMangerList, bool active) async {
    Map<String, dynamic> map = {"id": fleetMangerList.id, "isActive": active};

    try {
      _responseModel = await hitStatusApi(map);

      proData.FleetMangerList.remove(fleetMangerList);
      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      notifyListeners();
    }
  }

  Future<void> setlocalData() async {
    var roleTitle = await getRoleInfo();
    var plan = await getGpsPlanData();
    if (roleTitle == "ENDUSER" && plan == true)
      visable = true;
    else
      visable = false;
  }
}
