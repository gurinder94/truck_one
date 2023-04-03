import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/ActivityLogModel.dart';


class ActivityLogProvider extends ChangeNotifier {
  bool loading = false;
  String message = '';
  var name;
  var profileImg;
  late ActivityLog activityLog;
  List<Datum> listDate = [];
  List<ListElement> listAct = [];

  hitActivityLog(BuildContext context, int page ) async {
    var getId = await getUserId();
    name = await getNameInfo();
    profileImg = await getprofileInfo();
    Map<String, dynamic> map = {'userId': getId, "page": page};

    loading = true;
    notifyListeners();

    try {
      activityLog = await hitActivityLogApi(map);
      listDate.addAll(activityLog.data!);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  restList() {
    listDate = [];
    listAct = [];
  }
}
