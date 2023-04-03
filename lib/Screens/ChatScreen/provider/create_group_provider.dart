import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/ChatModel/group_friend_List.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/chat_home_Page.dart';
import 'package:provider/provider.dart';
import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/ChatModel/CreateSingleConversationModel.dart';
import '../../../Model/NetworkModel/my_frinds_model.dart';
import 'chat_home_provider.dart';

class CreateGroupProvider extends ChangeNotifier {
  bool load = false,
      createLoder = false,
      paginationLoder = false;
  var imageUrl;
  int page = 1;
  GroupFriendList _model = GroupFriendList();
  List<Datum> _list = [];
  String serachText = "";
  ScrollController scrollController = new ScrollController();

  List<Datum> get list => _list;
  final ImagePicker _picker = ImagePicker();
  TextEditingController groupName = TextEditingController();
  late SingleConversationChatListModel _singleConversationChatListModel;
  var qualificationarray = [];
  List<Datum> selectMemberList = [];

  getFromGallery(String type, BuildContext context) async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 600,
        imageQuality: 100);

    //cropImage(pickedFile, type, false, context);
    imageUpload(File(image!.path), type, context);

    notifyListeners();
    // });
  }

  imageUpload(File image, String type, BuildContext context) async {
    var url = SERVER_URL + '/api/v1/event/uploads';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: image.path
          .split('/')
          .last,
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
        showMessage(jsonData['message']);
      } else {
        var imageReal = jsonData['data']['imagePath'];

        imageUrl = imageReal;
        showMessage(jsonData['message']);
        notifyListeners();
      }
    } else {
      print("network  issue");
    }

    notifyListeners();
  }

  getMemberList() async {
    var uId = await getUserId();
    var getRole = await getRoleInfo();
    var companyId = await getCompanyId();
    if (!paginationLoder) {
      load = true;
      page = 1;
      _list = [];
    } else {
      paginationLoder = true;
    }

    notifyListeners();
    Map<String, dynamic> map = {
      "userId": uId,
      "page": page,
      "accessLevel": getRole,
      "isAccepted": "accept",
      "searchText": serachText,
      "companyId"
          :companyId==""?uId:companyId

    };

    try {
      _model = await hitGetGroupFriend(map);

      _list.addAll(_model.data!);

      selectMemberList.length == 0 ? "" : setMemeberData();
      load = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      load = false;
      notifyListeners();
    }
  }

  void changeValuecheckBox(CreateGroupProvider proData, int index, bool? val) {
    qualificationarray = [];
    selectMemberList = [];
    proData.list[index].isChecked = val!;

    List.generate(
        list.length,
            (index) =>
        {
          if (list[index].isChecked == true)
            {
              qualificationarray.add(list[index].userId.toString()),
              selectMemberList.add(list[index]),
              notifyListeners()
            }
          else
            {
              qualificationarray.remove(list[index].userId.toString()),
              selectMemberList.remove(list[index]),
              notifyListeners(),
            }
        });
  }

  Future<void> createGroup(BuildContext context) async {
    var uId = await getUserId();
    var roleName = await getRoleInfo();

    createLoder = true;
    notifyListeners();

    Map<String, dynamic> map = {
    "image": imageUrl == null ? null : imageUrl,
    "loggedInUser": uId,
    "membersArr": qualificationarray,
    "name": groupName.text,
    "nowTime": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .format(DateTime.now().toUtc()),
    "roleTitle": roleName,
    "type": "GROUP",
   };
    print(map);
    try {
    _singleConversationChatListModel = await hitCreateConversationApi(map);
    Navigator.pop(context, "Successfully");
    createLoder = false;
    notifyListeners();
    } on Exception catch (e) {
    var message = e.toString().replaceAll('Exception:', '');
    createLoder = false;
    }
  }

  void searchFliter(val) {
    serachText = val;
    getMemberList();
  }

  void setData(value) {
    selectMemberList = value["selectList"];
    qualificationarray = value["SelectListId"];
    notifyListeners();
  }

  void setMemeberList(List<Datum> selectMemberList) {
    this.selectMemberList = selectMemberList;
  }

  setMemeberData() {
    for (int i = 0; i < _model.data!.length; i++) {
      for (int j = 0; j < selectMemberList.length; j++) {
        if (_model.data![i].id == selectMemberList[j].id) {
          _model.data![i].isChecked = true;
        }
      }
    }
  }

  void addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (_list.length < _model.data!.length) {
          page = page + 1;
          paginationLoder = true;
          if (paginationLoder) {
            getMemberList();
          }
        }
      }
    });
  }
}
