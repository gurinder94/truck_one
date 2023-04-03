import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';

import 'home_page_list_provider.dart';

class PostEditProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;
  var textController = TextEditingController();
  List<Media> files = [];

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  ResponseModel _postModel = ResponseModel();

  ResponseModel get model => _postModel;

  Future<void> updatePost(
      Map<String, dynamic> map, HomePageListProvider listProvider) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      _postModel = await hitPostUpdate(map);
      files.clear();
      textController.text = '';
      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  void showMessage(String msg, context) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> refreshPage(HomePageListProvider listProvider) async {
    var getid = await getUserId();
    listProvider.resetBookings();
    listProvider.getPosts({
      "userId": getid,
      "count": 10,
      "page": 1,
      //"type": "Connections"
    }, false);
    Navigator.pop(context);
  }
}
