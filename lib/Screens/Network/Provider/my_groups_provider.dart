import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_groups_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';


class MyGroupsProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false, paginationLoading = false;

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  MyGroupsModel _model = MyGroupsModel();

  MyGroupsModel get model => _model;
  List<MyGroup> _list = [];

  List<MyGroup> get list => _list;

  getMyGroups(Map<String, dynamic> map, bool pagination) async {

    if (pagination)
      paginationLoading = true;
    else
      loading = true;
    print(map);
    notifyListeners();
    try {
      _model = await hitGetMyGroups(map);
      _list.addAll(_model.data!);
      loading = false;
      paginationLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }



  void reset() {
    _list = [];
  }

  void removeGroup(String gID, String? invitationId, String s, int index) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 140,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Are you sure you want to leave?',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              print(index);
                              list.removeAt(index);
                              notifyListeners();


                              Navigator.pop(context);
                            },
                            child: Text('Yes')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No'))
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Future<void> removeMyGroup(
      String gID, String? invitationId, int index) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "groupId": gID,
      "userId": getid,
      'invitationId': invitationId,
      'actionType': "MEMBERLEAVE",
      'assignAdmin': ""
    };
    print(map);
    try {
      ResponseModel _model = await hitRemoveGroup(map);
      list.removeAt(index);
      showMessage(_model.message);
      Navigator.pop(navigatorKey.currentState!.context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }
}
