import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/add_seller_rating_model.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/chat_socket_connection.dart';
import '../../../AppUtils/constants.dart';
import '../../../Listeners/chat_listeners.dart';
import '../../../Model/ChatModel/ChatConversationModelDetail.dart';
import '../../../Model/ChatModel/MessageModel.dart';
import '../../../Model/ChatModel/MessagesListModel.dart';

class ChatProvider extends ChangeNotifier with ChatListeners {
  String type;
  bool blockUser;

  ChatProvider(this.type, this.blockUser);

  MessagesListModel _model = MessagesListModel();
  bool loadMessages = true, connection = true;

  MessagesListModel get model => _model;
  List<MessageModel> _msgList = [];

  List<MessageModel> get msgList => _msgList;
  File? files;
  var messageController = TextEditingController();
  late ChatSocketConnection _connection;
  var userId, conversationId;
  bool loading = false;
  var documentName = "";
  bool linkGenerateUrl = false;

  @override
  void connectivity(bool connection) {
    // TODO: implement connectivity
    this.connection = connection;
    notifyListeners();
  }

  void listenChat(BuildContext context, String conversationId) {
    print(conversationId);
    _connection = context.read<ChatSocketConnection>();
    _connection
        .send("newConversationStart", {"conversation_id": conversationId});
    _connection.enableChatListener(this);
  }

  @override
  void errorMSG(data) {
    // TODO: implement errorMSG
    print('chat error $data');
  }

  @override
  void dispose() {
    CHAT_PAGE_OPEN = false;
    // TODO: implement dispose

    super.dispose();
  }

  void setContext(BuildContext context) {
    CHAT_PAGE_OPEN = true;
  }

  receiveMSG(value) async {
    print(value);
    if (value["data"] == null) {
// UserData jj=UserData();
      //MessageModel msg = MessageModel(senderId:value["data"]["sender_id"],msgTime:DateTime.now().toUtc(),messageId:value["data"]["message_id"]
      // // ,
      // // message: "llll",
      // ,userData: );

    } else if (value["code"] == 200) {
      var roleName = await getRoleInfo();
      var id = await getUserId();
      var name = await getNameInfo();

      // TODO: implement receiveMSGhi
      // ChatConversationModelDetail conversationModel =
      // await hitGetchatCoversationDetails({
      //   //    "clinic_id": value["data"]["clinic_id"],
      //
      //   "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
      //       .format(DateTime.now().toUtc()),
      //
      //   "loggedInUser": userId,
      //
      //   "message_id": value["data"]["message_id"],
      //   "conversationType": value["data"]["conversationType"],
      //   "sender_id": value["data"]["sender_id"],
      //   "convOpened": true,
      //   "conversation_id": value["data"]["conversation_id"],
      //   "roleTitle": roleName.toString().toUpperCase() == "USER" ? "ENDUSER"
      //       : roleName.toString().toUpperCase(),
      //
      //
      // });
      //
      // ChatConversationModelDetail conversationModel= ChatConversationModelDetail ();
      //
      ChatUserData _data =
          ChatUserData(firstName: name, id: id, image: '', lastName: name);

      MessageModel msg = MessageModel(
          senderId: value["data"]["sender_id"],
          msgTime: DateTime.now().toUtc(),
          messageId: value["data"]["message_id"],
          message: value["data"]["message"],
          userData: _data,
          document: value["data"]["document"] == null
              ? []
              : [value["data"]["document"][0]]);

      _msgList.add(msg);

      // //
      // if (conversationModel.code == 200 &&
      //     value["data"]["conversation_id"] == conversationId) {
      //   MessageModel msg = conversationModel.data!.lastMessages![0];
      //   _msgList.add(msg);
      notifyListeners();
      // }
    }
  }

  Future<void> getMessages(String conversationId) async {
    this.conversationId = conversationId;
    userId = await getUserId();
    loadMessages = true;
    notifyListeners();
    try {
      _model = await hitGetChatMessageApi({
        "conversationType": "INDIVIDUAL",
        "conversation_id": conversationId,
        "count": 50,
        "loggedInUser": userId,
        "page": 1,
        "nowTime":
            DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now())
      });
      documentName = '';
      _msgList.addAll(_model.data!.messagesData!.allMessages!);
      notifyListeners();
      loadMessages = false;
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      loadMessages = false;
      notifyListeners();
    }
  }

  void sendMessage() {
    print('$type');
    if (!connection) return;
    _connection.send('send-message', {
      "loggedInUser": userId,
      "conversation_id": conversationId,
      "type": "TEXT",
      "conversationType": type,
      "message": messageController.text.toString(),
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
      "document": documentName == "" ? [] : [documentName]
    });
    documentName = '';
    linkGenerateUrl = false;
    messageController.clear();
  }

  getChatAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'png', 'jpg', 'jpeg'],
    );
    if (result != null) {
      files = File(result.files.single.path.toString());
      var filePath = files!.path;
      var name = result.files.single.name.toString();

      var fileExtension = files!.path.toString().split('.').last;
      // p.extension(files!.path.toString());

      final extension = files!.path.split(".").last;
      print("fileExtension---" + extension);

      if (fileExtension == "pdf" ||
          fileExtension == "doc" ||
          fileExtension == "png" ||
          fileExtension == "jpg" ||
          fileExtension == "jpeg") {
        fileExtension = (filePath.split('/').last);

        print("File Path Select---" + files!.path);

        print("fileExtension---" + extension);
        print(files!.path.toString());
        getDocumentUpload(files!, extension, name);
      } else {
        print("NotSupport");
      }
    } else {
      return;
    }
  }

  getDocumentUpload(File file, String? type, String name) async {
    loading = true;
    notifyListeners();
    print(file.path);

    print(type);
    var url = SERVER_URL + '/api/v1/chat/docUpload';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
      contentType:
          new MediaType(type == "pdf" ? 'application' : "image", type!),
    ));
    request.fields.addAll({"type": '$type', "height": "300", "width": "300"});
    print("request: " + request.toString());
    var response = await request.send();

    if (response.statusCode == 200) {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);

      if (jsonData['data'] == null) {
        showMessage(jsonData['message']);
        loading = false;
        notifyListeners();
      } else {
        var imageReal = jsonData['data'];

        // setState(
        //       () =>
        // imageUrl = SERVER_URL +
        //     '/api/v1/event/uploads/profile/thumbnail/' +
        //     imageReal;
        // );
        showMessage(jsonData['message']);
        var imageLogo = imageReal;
        documentName = imageLogo;

        loading = false;
        notifyListeners();
        // });

      }
    } else {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);
      showMessage(jsonData['message']);
      loading = false;
      notifyListeners();
    }
  }

  getBlockUser(String conversationId, String blockType) async {
    var uId = await getUserId();

    Map<String, dynamic> map = {
      "action": blockType,
      "conversation_id": conversationId,
      "loggedInUser": uId,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    try {
      var responseModel = await hitUserBlockApi(map);

      blockType == "BLOCK" ? blockUser = true : blockUser = false;
      showMessage(responseModel.message.toString());

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
      notifyListeners();
    }
  }

  ///seller generate rating

  AddSellerRatingModel? addSellerRatingModel;
  TextEditingController supporEditingController = TextEditingController();

  getSellerRatingToken(String userId) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "path": "/pages/e-commerce/rating",
      "sellerId": getid,
      "userId": userId,
    };

    print(map);
    loading = true;
    notifyListeners();
    try {
      addSellerRatingModel = await SellerRatingTokenApi(map);
      messageController.text =
          SERVER_URL + addSellerRatingModel!.data!.urlPath.toString();
      linkGenerateUrl = true;
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      loading = false;
    }
  }

  var roleName;

  Future<void> role() async {
    roleName = await getRoleInfo();
    print(roleName);
  }
}
