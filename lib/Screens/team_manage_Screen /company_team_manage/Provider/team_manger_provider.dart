import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/company_mange_team_model.dart';
import 'package:my_truck_dot_one/Model/ManageTeamModel/user_left_company_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class ManagerTeamProvider extends ChangeNotifier {
  int menuClick = 0;
  late ResponseModel _responseModel;
  late UserLeftCompanyModel userLeftCompanyModel;
  int pagee = 1;
  bool paginationLoder = false;
  ScrollController scrollController = new ScrollController();
  ScrollController separationscrollController = new ScrollController();
  var valueItemSelected = "Accepted";
  var roleName;
  String inviteStatus = "Accepted";
  var valueAccessRole = "All";
  String searchText = "";
  bool loading = false;
  String? message;
  late CompanyManageTeamModel companyManageTeamModel;

  List<Datum> CompanyManageList = [];
  List<UserLeftModel> UserLeftCompanyList = [];

  ManagerTeamProvider() {
    getRole();

    resetUserLeftCompanyList();
    resetCompanyMangeTeamList();
    resetDropdownValue();
    hitCompanyManageTeam(
      navigatorKey.currentState!.context,
    );
    addScrollListener(navigatorKey.currentState!.context);
    separatedEmployeeScrollListener(navigatorKey.currentState!.context);
  }

  setMenuClick(int pos) {
    menuClick = pos;
    switch (pos) {
      case 0:
        menuClick = 0;

        break;
      case 1:
        menuClick = 1;

        break;
    }


  }

  getRole() async {
    roleName = await getRoleInfo();

    notifyListeners();
  }

  List<String> statusItems = [
    "Accepted",
    "Declined",
    "In Progress",
  ];
  List<String> items1 = [
    "All",
    "Dispatcher",
    "Driver",
    "Hr",
  ];

  hitCompanyManageTeam(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    var roleName = await getRoleInfo();
    var companyId = await getCompanyId();
    Map<String, dynamic> map = {};
    roleName.toString().toUpperCase() == "COMPANY"
        ? map = {
            "accessLevel": valueItemSelected == "All"
                ? "ALL"
                : valueItemSelected == "Dispatcher"
                    ? "DISPATCHER"
                    : valueItemSelected == "Driver"
                        ? "DRIVER"
                        : valueItemSelected == "Hr"
                            ? "HR"
                            : "ALL",
            "companyId": getId,
            "isAccepted": valueItemSelected == "Declined"
                ? 'decline'
                : valueItemSelected == 'Accepted'
                    ? 'accept'
                    : valueItemSelected == "In Progress"
                        ? "pending"
                        : '',
            "page": pagee,
            "roleName": roleName.toString().toUpperCase(),
            "searchKey": searchText,
          }
        : map = {
            "accessLevel": valueAccessRole == "All"
                ? "ALL"
                : valueAccessRole == "Dispatcher"
                    ? "DISPATCHER"
                    : valueAccessRole == "Driver"
                        ? "DRIVER"
                        : valueAccessRole == "Hr"
                            ? "HR"
                            : "ALL",
            "companyId": companyId,
            "isAccepted": valueItemSelected == "Declined"
                ? 'decline'
                : valueItemSelected == 'Accepted'
                    ? 'accept'
                    : valueItemSelected == "In Progress"
                        ? "pending"
                        : '',
            "page": pagee,
            "roleName": roleName.toString().toUpperCase(),
            "searchKey": searchText,
          };
    print(paginationLoder);
    if (paginationLoder) {
      paginationLoder = true;
    } else {
      loading = true;
      pagee = 1;
      CompanyManageList = [];
    }
    notifyListeners();
    print(map);
    try {
      companyManageTeamModel = await hitCompanyTeamApi(map);
      CompanyManageList.addAll(companyManageTeamModel.data!);

      inviteStatus = valueItemSelected;
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
    paginationLoder = false;
    loading = false;
  }

  hitDeleteCompanyManageTeam(
    String driverId,
    int index,
    ManagerTeamProvider proData,
  ) async {
    var getId = await getUserId();
    var roleName = await getRoleInfo();
    Map<String, dynamic> map = {
      "companyId": getId,
      "reason": "Remove by company",
      "userId": driverId,
      "accessLevel": roleName.toString().toUpperCase(),
      "userName": proData.CompanyManageList[index].personName!
    };

    try {
      _responseModel = await hitRemoveManageTeamApi(map);
      proData.CompanyManageList.removeAt(index);
      showMessage(_responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

  hitUserLeftCompany(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    var companyId = await getCompanyId();
    Map<String, dynamic> map = {
      "companyId":companyId==""? getId:companyId,
      "page": pagee,
      "searchText": searchText,
    };
    if (paginationLoder) {
      paginationLoder = true;
      notifyListeners();
    } else {
      pagee = 1;
      loading = true;
      UserLeftCompanyList = [];
    }
    notifyListeners();
    print(map);
    try {
      userLeftCompanyModel = await hitUserLeftCompanyApi(map);
      UserLeftCompanyList.addAll(userLeftCompanyModel.data!);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);

      notifyListeners();
    }
    paginationLoder = false;
    loading = false;
  }

  void setSelectedItem(String s) {
    print(s);
    valueItemSelected = s;
    notifyListeners();
  }

  void setAccessRole(String s) {
    valueAccessRole = s;
    notifyListeners();
  }

  resetCompanyMangeTeamList() {
    CompanyManageList = [];
    // pagee = 1;
  }

  resetUserLeftCompanyList() {
    UserLeftCompanyList = [];
    pagee = 1;
  }

  resetDropdownValue() {
    valueItemSelected = "Accepted";

    valueAccessRole = "All";
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginationLoder = true;

        if (paginationLoder) {
          print(pagee);
          if (companyManageTeamModel.data!.length <
              companyManageTeamModel.totalCount!) {
            pagee = pagee + 1;

            hitCompanyManageTeam(
              context,
            );
          }
        }
      }
      // Perform event when user reach at the end of list (e.g. do Api call)
    });
  }

  separatedEmployeeScrollListener(BuildContext context) {
    separationscrollController.addListener(() {
      if (separationscrollController.position.maxScrollExtent ==
          separationscrollController.position.pixels) {
        paginationLoder = true;

        if (paginationLoder) {
          if (UserLeftCompanyList.length < userLeftCompanyModel.totalCount!) {
            pagee = pagee + 1;

            hitUserLeftCompany(context);
          }
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  void search(val, int i) {
    searchText = val;
    i == 0
        ? hitCompanyManageTeam(
            navigatorKey.currentState!.context,
          )
        : hitUserLeftCompany(
            navigatorKey.currentState!.context,
          );
  }
}
