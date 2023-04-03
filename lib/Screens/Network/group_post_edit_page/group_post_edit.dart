import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';

class GroupPostProvider extends ChangeNotifier
{
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
  Future<void> updatePost(Map<String, dynamic> map, GroupProvider listProvider, String gId, ) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      _postModel = await hitPostUpdate(map);
      files.clear();
      textController.text = '';
      Navigator.pop(context);

      listProvider.refresh();
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }




}