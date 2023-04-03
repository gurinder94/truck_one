import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/invited_connections_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class InvitedConnectionsProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false,paginationLoading=false;

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  InvitedConnectionsModel _model = InvitedConnectionsModel();
  InvitedConnectionsModel get model => _model;
  List<InvitedConnection> _list = [];

  List<InvitedConnection> get list => _list;

  getConnections(Map<String, dynamic> map, bool pagination) async {

    print(map);
    if (pagination)
      paginationLoading = true;
    else
      loading = true;
    notifyListeners();
    try {
      _model = await hitGetInvitedConnections(map);
      _list.addAll(_model.data!);
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

  void removeInvite(String inviteID, List<InvitedConnection> list, int index) {
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
                height: 120,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Are you sure you want to delete ?',
                      style: TextStyle(fontSize: 18),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () async {
                              var getid = await getUserId();

                              removeInviteMember(
                                  {"invitationId": inviteID, "ownerId": getid},
                                  list,
                                  index);
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

  Future<void> removeInviteMember(
      Map<String, dynamic> map, List<InvitedConnection> list, int index) async {
    try {
      ResponseModel _model = await hitRemoveInvited(map);
      showMessage(_model.message.toString(), context);
      list.removeAt(index);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }
  }
}
