import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../group_view/view_group.dart';
import 'group_provider.dart';

class GroupPostSendProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;
  var captionText = TextEditingController();
  var  userimage;
  setContext(BuildContext context) {
    this.context = context;
  }

  List<PostDatum> _list = [];

  List<PostDatum> get list => _list;
  String message = '';
  ResponseModel _responseModel = ResponseModel();

  ResponseModel get responseModel => _responseModel;
  late GroupProvider _provider;

  postInGroup(Map<String, dynamic> map, String gId) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      print(map);
      _responseModel = await hitPostInGroup(map);
      captionText.text = '';
      notifyListeners();
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ChangeNotifierProvider(
      //           create: (context) => GroupProvider(),
      //           child: ViewGroup(
      //             gId:gId,
      //           ),
      //         )));

    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }


  refresh(String gId) async {
    _provider = context.read<GroupProvider>();

    _provider.list.clear();

    _provider.getGroupDetail(gId,false,1);
  }


  getUserData()
  async {
    userimage=await  getprofileInfo()??'';
    notifyListeners();
  }
}

