import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';

import 'package:provider/provider.dart';

import '../network_page/network_page.dart';
import '../network_page/network_provider.dart';

class UserDetailProvider extends ChangeNotifier {
  late BuildContext context;
  bool check = false;
  bool loading = false;
  bool connectLoading = false;
  var friendId;
  int pagee = 1;
  List<PostDatum> userPostList = [];
  ResponseModel responseModel = ResponseModel();
  bool paginationLoder = false;

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  UserDetailModel _model = UserDetailModel();
  List<UserDetail> listUserDetail = [];
  var listPostData = [];

  UserDetailModel get model => _model;

  getUserDetail(Map<String, dynamic> map, bool pagination) async {
    if (pagination == true)
      paginationLoder = true;
    else
      loading = true;
    print(map);
    try {
      _model = await hitGetUserDetail(map);
      userPostList.addAll(_model.data!.postData!);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    paginationLoder = false;
  }

  getfriendId(String value) {
    friendId = value;
  }

  void refresh() {
    listUserDetail;
    notifyListeners();
  }

  refreshList() async {
    listUserDetail = [];
    userPostList = [];
    pagee = 1;

    notifyListeners();
    var getid = await getUserId();
    getUserDetail({"userId": getid, "friendId": friendId}, false);
  }

  connectUser(Map<String, dynamic> map, BuildContext context) async {
    print(map);
    connectLoading = true;
    notifyListeners();
    try {
      var getid = await getUserId();
      ResponseModel model = await hitConnectPeople(map);
      showMessage(model.message.toString());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => NetworkProvider(), child: NetworkPage(0))));

      // provider.getRecommendations({
      //   "userId": getid,
      //   "page": 1,
      //   "count": 8,
      //   "type": "SUGGESTION"
      // });
      connectLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      loading = false;
      notifyListeners();
    }
  }

  getAccept(
    Map<String, dynamic> map,
  ) async {
    loading = true;
    notifyListeners();

    print(map);
    try {
      var responseModel = await hitInviteAcceptApi(map);
      showMessage(responseModel!.message.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => NetworkProvider(), child: NetworkPage(0))));
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  getInviteDecline(
    Map<String, dynamic> map,
  ) async {
    loading = true;
    notifyListeners();

    print(map);
    try {
      var responseModel = await hitInviteDeclineApi(map);
      showMessage(responseModel!.message.toString());
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => NetworkProvider(), child: NetworkPage(0))));
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  postDelete(
    Map<String, dynamic> map,
    pos,
  ) async {
    print(map);
    try {
      responseModel = await hitDeletePost(map);

      refreshList();

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }
  }

  postReport(
    Map<String, dynamic> map,

    int position,
    UserDetailProvider userDetailProvider,
  ) async {
    print(map);
    try {
      ResponseModel res = await hitPostReport(map);
      userDetailProvider.userPostList.removeAt(position);

      showMessage(
        res.message.toString(),
      );
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }
  }
}
