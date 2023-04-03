import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ChatModel/NewConversationList.dart';

import '../../Model/ChatModel/CreateSingleConversationModel.dart';

class NewConversationProvider extends ChangeNotifier {
  bool loading = false, PaginationLoder = false;

  NewConversationList _model = NewConversationList();
  SingleConversationChatListModel _singleConversationChatListModel =
      SingleConversationChatListModel();
  ScrollController scrollController = ScrollController();

  NewConversationList get model => _model;
  List<Datum> _list = [];
  int page = 1;

  List<Datum> get list => _list;

  NewConversationProvider() {
    getUserList("");
    addScrollListener();
  }

  Future<void> getUserList(String val) async {
    var uId = await getUserId();
    var roleTitle = await getRoleInfo();
    var companyId= await getCompanyId();

    if (!PaginationLoder) {
      _list = [];
      page = 1;
      loading = true;
    } else {
      PaginationLoder = true;
    }

    notifyListeners();
    Map<String, dynamic> map = {
      "accessLevel": roleTitle,
      "isAccepted": "accept",
      "companyId":companyId==""?uId:companyId,
      "page": page,
      "searchKey": val,
      'userId': uId,
    };
    print(map);
    try {
      _model = await hitGetSalesPersonList(map);

      _list.addAll(_model.data!);
      loading = false;
      PaginationLoder = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      loading = false;
      PaginationLoder = false;
      notifyListeners();
    }
  }

  Future<void> addChatList(Datum list) async {
    var uId = await getUserId();
    var roleName = await getRoleInfo();

    Map<String, dynamic> map = {
      "image": list.driverImage,
      "loggedInUser": uId,
      "membersArr": [list.userId],
      "name": list.personName,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      "roleTitle": roleName.toString().toUpperCase(),
      "type": "INDIVIDUAL"
    };
    print(map);
    try {
      _singleConversationChatListModel = await hitCreateConversationApi(map);
      // chatHomeProvider.addChatConversation(_SingleConversationChatListModel.data!.conversation_id.toString(), _SingleConversationChatListModel.data!.image.toString(), _SingleConversationChatListModel.data!.lastMessages==null?[]:_SingleConversationChatListModel.data!.lastMessages, _SingleConversationChatListModel.data!.name.toString(), _SingleConversationChatListModel.data!.type.toString(), _SingleConversationChatListModel.data!.unReadMsg);

      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      print(message);
      notifyListeners();
    }
  }

  addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (_model.data!.length == 0) {
        } else {
          PaginationLoder = true;
          page = page + 1;
          getUserList("");
        }
      }
      // Perform event when user reach at the end of list (e.g. do Api call)
    });
  }

  void searchText(val) {
    PaginationLoder = false;
    getUserList(val);
  }
}
