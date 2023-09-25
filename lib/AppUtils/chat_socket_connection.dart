import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Listeners/chat_listeners.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../ApiCall/api_Call.dart';
import '../Model/ChatModel/ChatConversationModelDetail.dart';
import '../Model/ChatModel/MessageModel.dart';
import '../Screens/ChatScreen/chat_screen.dart';
import '../Screens/ChatScreen/provider/chat_provider.dart';
import '../Screens/Trip Planner/UserLiveMap/Listeners/waze_remove_marker_Listeners.dart';
import 'UserInfo.dart';

class ChatSocketConnection extends ChangeNotifier {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;
  ChatListeners? _chatListeners;
  WazeMarkerRemoveListener? _wazeMarkerRemoveListener;
  late FlutterLocalNotificationsPlugin fltrNotification;
  BuildContext? context;
  String ui;

  ChatSocketConnection(
    this.context,
    this.ui,
  ) {
    createConnection();
    initNotification();
  }

  createConnection() {
    _socket = IO.io(SERVER_URL, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.connect();
    socket.on('connect', (_) {
      print('chat connect: ${socket.id}');
      joinConversation();
    });
    socket.on('disconnect', (_) {
      if (_chatListeners != null) _chatListeners!.connectivity(false);
    });
    socket.on('receive-message', (data) {
      if (!CHAT_PAGE_OPEN) {
        notificationData(data);
        print(CHAT_PAGE_OPEN);
      }
      if (_chatListeners != null) _chatListeners!.receiveMSG(data);
    });
    socket.on('join-new-conversation', (data) {
      print(data);
      if (!CHAT_PAGE_OPEN) {}
    });

    socket.on('new-conversation-started', (data) {
      if (!CHAT_PAGE_OPEN) {
        send('join-new-conversation', data);
        print(data);
      }

      if (_chatListeners != null) _chatListeners!.receiveMSG(data);
    });

    socket.on('driver-remove-marker', (data) {
      print(data);

      if (_wazeMarkerRemoveListener != null)
        _wazeMarkerRemoveListener!.receiveMSG(data);
    });
    socket.on('error-message', (data) {
      print(data);
      if (_chatListeners != null) _chatListeners!.errorMSG(data);
    });
  }

  send(event, data) {
    socket.emit(event, data);
    if (_chatListeners != null) _chatListeners!.receiveMSG(data);
    // else
    //   print("fdskljfghhjfgjhkfghkjfgdhkjfdhkgjhkfdsg");
  }

  close() {
    socket.close();
  }

  Future<void> joinConversation() async {
    var uID = await getUserId();

    if (uID == 'null') {
      send("login", ui);

      send('join-conversation', {
        "loggedInUser": uID,
      });
    } else {
      send("login", uID);

      send('join-conversation', {
        "loggedInUser": uID,
      });

      //"clinic_id": cID});
      if (_chatListeners != null) {
        _chatListeners!.connectivity(true);
      }
      if (_wazeMarkerRemoveListener != null) {
        _wazeMarkerRemoveListener!.connectivity(true);
      }
    }
  }

  void enableChatListener(ChatListeners _chatListeners) {
    this._chatListeners = _chatListeners;
  }

  void enableWazetListener(WazeMarkerRemoveListener _wazeMarkerRemoveListener) {
    this._wazeMarkerRemoveListener = _wazeMarkerRemoveListener;
    print("river-remove-marker");
  }

  void initNotification() {
    var androidInitilize = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSinitilize = DarwinInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
  }

  Future showNotification(
    MessageModel msg,
    ChatConversationModelDetail conversationModel,
  ) async {
    var androidDetails = const AndroidNotificationDetails(
        "Channel ID", "Channel name",
        importance: Importance.max, channelDescription: "Channel description");
    var iSODetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    Map<String, dynamic> map = {};
    map["name"] = conversationModel.data!.name;
    map["image"] = conversationModel.data!.image;
    map["type"] = conversationModel.data!.type;
    map["id"] = conversationModel.data!.conversationId;
    await fltrNotification.show(
        0,
        '${msg.userData!.firstName} ${msg.userData!.lastName}',
        msg.message,
        generalNotificationDetails,
        payload: jsonEncode(conversationModel.toJson()).toString());
  }

  Future<void> notificationData(value) async {
    var uId = await getUserId();
    var roleName = await getRoleInfo();
    ChatConversationModelDetail conversationModel =
        await hitGetchatCoversationDetails({
      "sender_id": value["data"]["sender_id"],
//    "clinic_id": value["data"]["clinic_id"],
      "message_id": value["data"]["message_id"],
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      "loggedInUser": uId,
      "conversation_id": value["data"]["conversation_id"],
      "conversationType": value["data"]["conversationType"],
      "convOpened": false,
      "roleTitle": roleName.toString().toUpperCase() == "USER"
          ? "ENDUSER"
          : roleName.toString().toUpperCase()
    });
    print("623558");
    if (conversationModel.code == 200 &&value["data"]["sender_id"]!=uId ) {
      MessageModel msg = conversationModel.data!.lastMessages![0];
      showNotification(msg, conversationModel);
    }
  }

  void onSelectNotification( NotificationResponse details) {
    print("notification ${details.payload}");
    var payload=details.payload;
    ChatConversationModelDetail conversationModel =
        ChatConversationModelDetail.fromJson(jsonDecode(payload!));

    notifyListeners();
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => ChatProvider(conversationModel.data!.type!,
                    conversationModel.data!.isBlocked!),
                child: ChatPage(
                  conversationId: conversationModel.data!.conversationId!,
                  image: conversationModel.data!.image == null
                      ? ""
                      : IMG_URL + conversationModel.data!.image!,
                  name: conversationModel.data!.name == null
                      ? ''
                      : conversationModel.data!.name!,
                    userId:conversationModel.data!.userId==null?"":conversationModel.data!.userId!
                ))));
  }
}
