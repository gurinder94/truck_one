import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';

class UserEventViewProvider extends ChangeNotifier {
  int menuClick = 0;
  bool _loading = false;
  String? message = " ";
  var roleTile = "";

  get loading => _loading;
  EventModel? _eventModel;

  EventModel? get eventModel => _eventModel;
  final value = new NumberFormat("#,##0.00", "en_US");
  setMenuClick(int pos) {
    menuClick = pos;
    notifyListeners();
  }

  UserEventViewProvider() {
    getRole();
  }

  getRole() async {
    roleTile = await getRoleInfo();
    print(roleTile);
  }

  hitUserEventView(BuildContext context, String eventId, String? getId) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      'userId': getid,
      'eventId': eventId,
    };
    _loading = true;
    notifyListeners();

    try {
      _eventModel = await hitEventViewIdApi(map);

      notifyListeners();
      _loading = false;
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      notifyListeners();
    }
  }

  hitDeleteEvent(BuildContext context) async {
    Map<String, dynamic> map = {
      'id': _eventModel!.id,
    };
    _loading = true;
    notifyListeners();
    print(map);
    try {
      var res = await hitDeleteEventIdApi(map);
      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }
}
