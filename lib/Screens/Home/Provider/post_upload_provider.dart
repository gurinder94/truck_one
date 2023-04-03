
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_upload_model.dart';

import 'package:provider/provider.dart';

import 'home_page_list_provider.dart';

class PostUploadProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;
  var textController = TextEditingController();
  List files = [];

  String? image;
  String ? Name;

  setContext(BuildContext context) {
    this.context = context;

  }

  String message = '';
  PostUploadModel _postModel = PostUploadModel();

  PostUploadModel get model => _postModel;

  postUpload(Map<String, dynamic> map) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      _postModel = await hitUploadPost(map);
      files.clear();
      textController.text = '';
      refreshPage();
      Navigator.pop(context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }

  void showMessage(String msg, context) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> refreshPage() async {
    var getid = await getUserId();
    var pro = context.read<HomePageListProvider>();
    pro.resetBookings();
    pro.getPosts({
      "userId": getid,
      "count": 10,
      "page": 1,
      //"type": "Connections"
    }, false);
  }

  setPostImage() async {
    image = await getprofileInfo();
    Name=await getNameInfo();

    notifyListeners();
  }
}
