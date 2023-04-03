import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';

class EditPostProvider extends ChangeNotifier {
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
    Map<String, dynamic> map,
    UserDetailProvider userDetailProvider,
  ) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      _postModel = await hitPostUpdate(map);
      files.clear();
      textController.text = '';
      Navigator.pop(context);
      userDetailProvider.refreshList();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
}
