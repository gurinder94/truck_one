import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/ChatModel/ConversationListModel.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/chat_socket_connection.dart';
import '../../../AppUtils/constants.dart';
import '../../../Listeners/chat_listeners.dart';
import '../../../Model/ChatModel/ChatConversationModelDetail.dart';

class ChatHomeProvider extends ChangeNotifier with ChatListeners {
  int groupTabber = 0;

  bool _loading = false, paginationLoder = false;
  ConversationListModel _model = ConversationListModel();

  ConversationListModel get model => _model;
  List<ConversationModel> _list = [];
  late ChatSocketConnection _connection;
  ScrollController scrollController = ScrollController();

  List<ConversationModel> get list => _list;

  get loading => _loading;
  int page = 1;

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
    print(_list.length);
    notifyListeners();
  }

  Future<void> getConversations(val, bool pagination, int pagee) async {
    paginationLoder = pagination;
    var uId = await getUserId();
    var roleTitle = await getRoleInfo();
    if (paginationLoder == false) {
      _loading = true;
      _list = [];
      page = page;
    } else {
      paginationLoder = true;
      print(groupTabber == 0
          ? "INDIVIDUAL"
          : groupTabber == 1
              ? "GROUP"
              : "SELLER");
    }
    notifyListeners();
    try {
      _model = await hitGetConversations({
        "loggedInUser": uId,
        "roleTitle": roleTitle,
        "type": groupTabber == 0
            ? "INDIVIDUAL"
            : groupTabber == 1
                ? "GROUP"
                : "SELLER",
        "page": pagee,
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

  removeConverstionList(int index) {
    list.removeAt(index);
    notifyListeners();
  }

  resetList() {
    _list = [];
    page = 1;
    paginationLoder = false;


  }

  addScrollListener(
    BuildContext context,
    ConversationListModel model,
  ) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (list.length < _model.totalCount!) {
          page = page + 1;
          pagnationList(context, page);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  pagnationList(BuildContext context, int pagee) async {

    getConversations('', true, pagee);
  }
}
