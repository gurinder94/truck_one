import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/like_list_model.dart';

class LikeProvider extends ChangeNotifier
{
  bool loading= true;
  LikeListModel ?likeListModel;
  late String message;
  getLikeList(String ? postId) async {
    var  getId=await getUserId();
    Map<String, dynamic> map={
    "postId":postId,
      "userId":getId
    };
    loading = true;
    notifyListeners();
    print(map);
    try {
      likeListModel = await hitLikeList(map);

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