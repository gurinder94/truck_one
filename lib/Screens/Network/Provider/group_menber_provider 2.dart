import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/GroupMenberListModel.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:provider/provider.dart';

import '../My_Group_List/groups_list_page.dart';
import 'my_groups_provider.dart';

class GroupMenberProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, paginationLoading = false;
  String? message;
  GroupMemberListModel? groupMemberListModel;

  List<Datum> MemberList = [];
  ResponseModel? responseModel;

  setContext(BuildContext context) {
    this.context = context;
  }

  getGroupMemberList(
      String? gId, String? value, bool pagination, int page) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {
      "groupId": gId,
      "userId": getId,
      "searchText": value,
      'page': page
    };
    if (pagination)
      paginationLoading = true;
    else
      loading = true;

    notifyListeners();
    print(map);
    try {
      groupMemberListModel = await hitGroupMemberList(map);

      if (value!.length > 0) {
        MemberList = [];
      }
      MemberList.addAll(groupMemberListModel!.data!);

      print(MemberList.length);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    paginationLoading = false;
  }

  getGroupRemoveMember(
    String? gId,
    String? value,
    String? s,
    String? inId,
    String? invitationId,
  ) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "groupId": gId,
      "userId": value,
      'invitationId': invitationId,
      'actionType': s,
      'assignAdmin': inId,
      'loggedInUserId': getid
    };
    loading = true;
    notifyListeners();

    print(map);
    try {
      ResponseModel responseModel = await hitGroupRemoveMember(map);
      Navigator.pop(navigatorKey.currentState!.context);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

  getGroupRemoveAdmin(
    String? gId,
    String? value,
    String? s,
    String? inId,
  ) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {
      "groupId": gId,
      "userId": getId,
      'invitationId': value,
      'actionType': "ADMINLEAVE",
      'assignAdmin': inId
    };
    loading = true;
    notifyListeners();

    print(map);
    try {
      responseModel = await hitGetRemoveInvitedConnections(map);
      showMessage(responseModel!.message.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    create: (context) => MyGroupsProvider(),
                    child: GroupsListPage(),
                  )));
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

  void resetList() {
    MemberList = [];
  }
}
