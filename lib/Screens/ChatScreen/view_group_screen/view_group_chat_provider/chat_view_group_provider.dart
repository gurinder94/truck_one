import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:http/http.dart' as http;
import '../../../../Model/ChatModel/ChatGroupViewModel.dart';
import '../view_group_page.dart';

class ChatViewGroupProvider extends ChangeNotifier {
  bool loder = false;
  bool? adminMessage;

  bool? editGroup;
  var imageFile;
  String imagePicker = "null";
  bool? member;
  late ChatViewGroupProvider proData;
  ChatGroupViewModel? chatGroupViewModel;
  late ResponseModel responseModel;
  late String conversationId;
  List<MembersDatum> memberDatumList = [];
  int totalMember = 0;
  late String UserId;
  TextEditingController groupName = TextEditingController();
  ScrollController scrollController = new ScrollController();
  setConversation(conversationId) {
    this.conversationId = conversationId;
  }
  double backgroundvisible=0.0;

  getGroupViewDeatil() async {

    UserId = await getUserId();
    loder = true;
    notifyListeners();
    Map<String, dynamic> map = {
      "conversation_id": conversationId,
      "loggedInUser": UserId,
    };
    try {
      chatGroupViewModel = await hitGetGroupDetailWithMembers(map);
      // adminMessage = chatGroupViewModel!.data!.onlyAdminCanMessage;
      //
      // groupName.text = chatGroupViewModel!.data!.name.toString();
      // editGroup = chatGroupViewModel!.data!.onlyAdminUpdateInfo;
      //
      // member = chatGroupViewModel!.data!.onlyAdminCanAddOrRemove;
      // memberDatumList.addAll(chatGroupViewModel!.data!.membersData!);
      // totalMember = chatGroupViewModel!.data!.membersData!.length;
      setGroupDetail(chatGroupViewModel!.data!);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      loder = false;
      notifyListeners();
    }
    loder = false;
  }

  setGroupDetail(Data data) {
    memberDatumList = [];
    adminMessage = data.onlyAdminCanMessage;

    groupName.text = data.name.toString();
    editGroup = data.onlyAdminUpdateInfo;

    member = data.onlyAdminCanAddOrRemove;
    memberDatumList.addAll(data.membersData!);
    totalMember = data.membersData!.length;
    notifyListeners();
  }

  AdminMessage(bool value, int i) async {
    var getId = await getUserId();

    notifyListeners();
    Map<String, dynamic> map = {};
    switch (i) {
      case 1:
        map = {
          "conversation_id": conversationId,
          "loggedInUser": getId,
          "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(DateTime.now().toUtc()),
          "onlyAdminCanMessage": value == true ? false : true,
        };
        break;
      case 2:
        map = {
          "conversation_id": conversationId,
          "loggedInUser": getId,
          "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(DateTime.now().toUtc()),
          "onlyAdminUpdateInfo": value == true ? false : true,
        };
        break;
      case 3:
        map = {
          "conversation_id": conversationId,
          "loggedInUser": getId,
          "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
              .format(DateTime.now().toUtc()),
          "onlyAdminCanAddOrRemove": value == true ? false : true,
        };
    }

    print(map);
    try {
      responseModel = await hitAdminSettingMessage(map);

      showMessage(responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      notifyListeners();
    }
  }

  TotalMember(int value) {
    totalMember = totalMember - 1;
    print(totalMember);
    notifyListeners();
  }

  groupViewUpdate(String image, BuildContext context) async {
    var getId = await getUserId();

    notifyListeners();
    Map<String, dynamic> map = {};

    map = {
      "conversation_id": conversationId,
      "image": image == "null" ? null : image,
      "loggedInUser": getId,
      "name": groupName.text,
      "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc()),
    };

    print(map);
    try {
      responseModel = await hitGroupViewUpdate(map);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ViewGroupPage(conversationId)));
      showMessage(responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      notifyListeners();
    }
  }

  removeList(int index) {
    proData.memberDatumList.removeAt(index);

    notifyListeners();
  }

  setAdminMessage(bool value) {
    adminMessage = value;
    AdminMessage(value, 1);
    notifyListeners();
  }

  setEditGroup(bool value) {
    editGroup = value;
    AdminMessage(value, 2);
    notifyListeners();
  }

  setMember(bool value) {
    member = value;
    AdminMessage(value, 3);
    notifyListeners();
  }

  setList(ChatViewGroupProvider proData) {
    this.proData = proData;
  }

  getFromGallery(
      String type, BuildContext context, ChatViewGroupProvider proData) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 600,
      maxHeight: 600,
    );
    if (pickedFile != null) {
      // setState(() {
      imageFile = File(pickedFile.path);

      if (type == "BRANDLOGO") {
        cropImage(pickedFile, type, false, context, proData);
        // imageUpload(imageFile, type, false, context);
      }
      notifyListeners();
      // });
    }
  }

  cropImage(PickedFile pickedFile, String type, bool value,
      BuildContext context, ChatViewGroupProvider proData) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: PrimaryColor,
          toolbarWidgetColor: Colors.white,

          // initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    if (croppedFile != null) {
      File file = File(croppedFile.path);

      imageUpload(file, type, value, context);
    }
  }

  imageUpload(File image, String type, bool value, BuildContext context) async {
    notifyListeners();
    var url = SERVER_URL + '/api/v1/event/uploads';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: image.path.split('/').last,
      contentType: new MediaType('image', 'jpeg'),
    ));
    request.fields.addAll({"type": '$type', "height": "300", "width": "300"});
    print("request: " + request.toString());
    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);
      print('image $value');

      if (jsonData['data'] == null) {
      } else {
        var imageReal = jsonData['data']['imagePath'];

        // setState(
        //       () =>
        imagePicker = imageReal;
        proData.chatGroupViewModel!.data!.image = imagePicker;
        print(proData.chatGroupViewModel!.data!.image.toString());
        notifyListeners();
      }
    }
  }
  void scrollListener() {
    scrollController.addListener(() {

      backgroundvisible = scrollController.offset;

     notifyListeners();
    });
  }

}
