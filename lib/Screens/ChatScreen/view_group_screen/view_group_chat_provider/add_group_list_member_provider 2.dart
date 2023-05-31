import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import '../../../../ApiCall/api_Call.dart';
import '../../../../AppUtils/UserInfo.dart';
import '../../../../AppUtils/constants.dart';
import '../../../../Model/ChatModel/GroupViewAddMemberList.dart';

class AddGroupListMemberProvider extends ChangeNotifier

{
  bool loder=false;
  bool groupMenber=false;
 late  GroupViewAddMemberList groupViewAddMemberList;
 List<Datum>AddMemberList=[];
 String conversationId;
 late ResponseModel responseModel;
  AddGroupListMemberProvider(this.conversationId);
  groupAddMember( BuildContext context)
  async {
    var getId = await getUserId();
    loder=true;
    notifyListeners();
    Map<String, dynamic> map = {};

    map = {
      "conversation_id": conversationId,
      "loggedInUser": getId,

    };

    print(map);
    try {
      groupViewAddMemberList = await  hitAddGroupListMember(map);
      AddMemberList.addAll(groupViewAddMemberList.data!);
      loder=false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      loder=false;
      notifyListeners();
    }
  }
  addMember( BuildContext context, String userId, AddGroupListMemberProvider addGroupListMemberProvider, int index)
  async {
    var getId = await getUserId();
    groupMenber=true;
    notifyListeners();
    Map<String, dynamic> map = {};

    map = {
      "conversation_id": conversationId,
      "loggedInUser": getId,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      "user_id": userId,

    };

    print(map);
    try {
      responseModel = await  hitAddMenber(map);
      addGroupListMemberProvider.AddMemberList[index].alreadyExist=true;
      groupMenber=false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      groupMenber=false;
      notifyListeners();
    }
  }




}