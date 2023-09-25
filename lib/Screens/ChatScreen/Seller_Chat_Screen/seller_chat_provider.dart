import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/chat_socket_connection.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Listeners/chat_listeners.dart';
import 'package:my_truck_dot_one/Model/ChatModel/ConversationListModel.dart';
import 'package:provider/provider.dart';

class SellerChatProvider extends ChangeNotifier with ChatListeners {
  int groupTabber = 0;
  late ChatSocketConnection _connection;
  ConversationListModel _model = ConversationListModel();
  int page = 1;

  ConversationListModel get model => _model;
  List<ConversationModel> _list = [];

  ScrollController scrollController = ScrollController();

  List<ConversationModel> get list => _list;
  bool _loading = false, paginationLoder = false;

  get loading => _loading;

  SellerChatProvider() {
    groupTabber = 0;
    getConversations("");
  }

  setClick(int pos) {
    groupTabber = pos;
    notifyListeners();
  }

  String? message;

  void listenChat(BuildContext context) {
    _connection = context.read<ChatSocketConnection>();

    _connection.enableChatListener(this);
  }

  @override
  void connectivity(bool connection) {
    // TODO: implement connectivity

    print(_connection.toString());
    debugPrint('chat server' + connection.toString());
  }

  @override
  void errorMSG(data) {
    // TODO: implement errorMSG
    debugPrint('chat error' + data.toString());
  }

  @override
  Future<void> receiveMSG(value) async {
    var roleName = await getRoleInfo();
    var uId = await getUserId();
    // TODO: implement receiveMSG
    _model = await hitGetConversations({
      "loggedInUser": uId,
      "roleTitle": roleName,
      "type": groupTabber == 0
          ? "INDIVIDUAL"
          : groupTabber == 1
              ? "GROUP"
              : "SELLER",
      "page": 1,
      "searchText": ''
    });

    _list = [];
    _list.addAll(_model.data!);
    print("41235758${_model.data}");
    notifyListeners();
  }

  reset() {
    paginationLoder = false;
    getConversations("");
  }

  Future<void> getConversations(val) async {
    var uId = await getUserId();
    var roleTitle = await getRoleInfo();
    if (paginationLoder == false) {
      _loading = true;
      _list = [];
      page = 1;
    } else {
      paginationLoder = true;
    }
    notifyListeners();
    try {
      _model = await hitGetConversations({
        "loggedInUser": uId,
        "roleTitle": "SELLER",
        "type": groupTabber == 1 ? "INDIVIDUAL" : "SELLER",
        "page": page,
        "searchText": val
      });
      _list.addAll(_model.data!);
      conversationId = _list[0].conversation_id!;
      paginationLoder = false;
      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      _loading = false;
      paginationLoder = false;

      notifyListeners();
    }
  }

  void removeConverstionList(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  addScrollListener(
    BuildContext context,
    ConversationListModel model,
  ) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginationLoder = true;
        if (list.length < _model.totalCount!) {
          if (paginationLoder) {
            page = page + 1;
            getConversations("");
          }
        }
        // Perform event when user reach at the end of list (e.g. do Api call)
      }
    });
  }

  void search(val) {
    getConversations(val);
  }
}
