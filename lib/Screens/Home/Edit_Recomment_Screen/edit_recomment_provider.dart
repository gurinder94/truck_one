import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recomments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';

class EditRecommentProvider extends ChangeNotifier
{
  bool updateloading = true;
  String? message;

  hitupdateCommnet(
      Map<String, dynamic> map, List<RecommentModel> list, int index, ReCommentsProvider provider, String text, String ?id,

      ) async {
    var getId = await getUserId();
    var name = await getNameInfo();
    var image = await getprofileInfo();
    updateloading = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await commentEditApi(map);
      provider.setRemoveList(index);
      provider.updateRecommentList(index,getId,text, capitalize(name,),image,id!);
      // provider.list.insert(
      //     index,
      //     CommentItemModel(
      //         userId: getId,
      //         comment: text,
      //         personName: capitalize(
      //           name,
      //         ),
      //         designation: '',
      //         id: commentId,
      //         image: image,
      //         role: '',
      //         totalReComment: 0,
      //         isMyComment: true,
      //         isEdited: true));
      // provider.refreshList();

Navigator.pop(navigatorKey.currentState!.context);
      updateloading = false;
notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

}