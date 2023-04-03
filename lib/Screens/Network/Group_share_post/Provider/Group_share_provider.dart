import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import '../../../../ApiCall/api_Call.dart';
import '../../../../AppUtils/constants.dart';

class GroupShareProvider extends ChangeNotifier

{
 bool  shareGroupPostLoder=false;
 String message = '';
 late ResponseModel _responseModel;
  hitshareGroupPost(String  caption, String groupId)
  async {

     var getId = await getUserId();
    Map<String, dynamic> map = {
      "caption": caption,
      "groupId":groupId,
      "postedById":getId,

      "type":"JOIN_GROUP"
    };
    shareGroupPostLoder=true;

    notifyListeners();
    print(map);
    try {
      _responseModel = await sharPostGroupApi(map);

      showMessage(
        _responseModel.message.toString(),
      );
      Navigator.pop(navigatorKey.currentState!.context);
      shareGroupPostLoder=false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      shareGroupPostLoder=false;
      notifyListeners();
    }
  }
}