import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invite_menber_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:provider/provider.dart';

import '../group_view/view_group.dart';
import '../Provider/group_provider.dart';

class InviteGroupMemberProv extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, paginationLoading = false,inviteSendloder=false;
  late ResponseModel _responseModel;

  setContext(BuildContext context) {
    this.context = context;
  }

  List sendTo = [];
  int count = 0;
  String message = '';
  GroupInviteMenberModel? groupInviteMenberModel;
  List<Datum> inviteMenber = [];
  late Datum data;

  getGroupInviteMenber(
      String? id, String? value, bool pagination, int pagee, ) async {
    var getid = await getUserId();
    if (pagination)
      paginationLoading = true;
    else {
      loading = true;
      notifyListeners();
    }

    notifyListeners();

    Map<String, dynamic> map = {
      'userId': getid,
      'groupId': id,
      'searchText': value,
      'page': pagee,
      "searchText":value
    };
    print(map);

    try {
      groupInviteMenberModel = await hitGetGroupInvitedConnections(map);

      inviteMenber.addAll(groupInviteMenberModel!.data!);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    paginationLoading = false;
    loading = false;
  }

  getcount(int value) {
    count = value;
    notifyListeners();
  }

  postGroupInviteMenber(String? id, BuildContext context, String ? groupName) async {
    var getid = await getUserId();
    var userName= await getNameInfo();

    Map<String, dynamic> map = {
      'sendBy': getid,
      'groupId': id,
      'sendTo': sendTo,
      "userName": userName,
       "groupName":groupName
    };
    inviteSendloder=true;
    notifyListeners();

    print(map);

    try {
      _responseModel = await hitPostGroupInvitedConnections(map);

     Navigator.pop(navigatorKey.currentState!.context);
      inviteSendloder=false;

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      inviteSendloder=false;

      notifyListeners();
    }

  }

  void reset() {
    inviteMenber = [];
  }

  void setData(Datum data) {
    this.data = data;
  }
}
