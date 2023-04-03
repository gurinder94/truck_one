import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_frinds_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class MyFriendsProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, paginationLoading = false;

  setContext(BuildContext context) {
    this.context = context;
  }

  ScrollController scrollController = new ScrollController();
  String message = '';
  MyFriendsModel _model = MyFriendsModel();
  List<MyFriend> _list = [];

  MyFriendsModel get model => _model;

  List<MyFriend> get list => _list;

  getFriends(Map<String, dynamic> map, bool pagination) async {
    print(map);
    if (pagination)
      paginationLoading = true;
    else
      loading = true;
    notifyListeners();

    try {
      _model = await hitGetMyFriends(map);
      _list.addAll(_model.data!);

      print(_list.length);
      paginationLoading = false;
      loading = false;
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

  void reset() {
    _list = [];
  }

  // void removeFriend(
  //   String id,
  //   int index,
  //   List<MyFriend> list,
  // ) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => Dialog(
  //             elevation: 0,
  //             backgroundColor: Colors.transparent,
  //             child: Container(
  //               padding: EdgeInsets.all(10),
  //               decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.all(Radius.circular(10))),
  //               height: 160,
  //               width: 200,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Are you sure you want to delete ?',
  //                     style: TextStyle(fontSize: 18),
  //                   ),
  //                   Spacer(),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                           onPressed: () {
  //                             removeMyFriend(id, list, index);
  //                             Navigator.pop(context);
  //                           },
  //                           child: Text('Yes')),
  //                       TextButton(
  //                           onPressed: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Text('No'))
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ));
  // }

  Future<void> removeMyFriend(String id, List<MyFriend> list, int index) async {
    try {
      var getid = await getUserId();
      ResponseModel _model = await hitInviteDeclineApi(
          {"invitationId": id, "removeType": "REMOVEFRIEND"});
      list.removeAt(index);
      Navigator.pop(context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }
  }
}
