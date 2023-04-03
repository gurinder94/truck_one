import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

import 'comments_provider.dart';

class CommentEditProvider extends ChangeNotifier {
  bool updateloading = true;
  String? message;

  hitupdateCommnet(
    Map<String, dynamic> map,
    CommentsProvider provider,
    int index,
    String text,
    String commentId,
  ) async {
    var getId = await getUserId();
    var name = await getNameInfo();
    var image = await getprofileInfo();
    updateloading = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await commentEditApi(map);
      provider.list.removeAt(index);
      provider.list.insert(
          index,
          CommentItemModel(
              userId: getId,
              comment: text,
              personName: capitalize(
                name,
              ),
              designation: '',
              id: commentId,
              image: image,
              role: '',
              totalReComment: 0,
              isMyComment: true,
              isEdited: true));

      Navigator.pop(navigatorKey.currentState!.context);
      provider.refreshList();
      updateloading = false;
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }
}
