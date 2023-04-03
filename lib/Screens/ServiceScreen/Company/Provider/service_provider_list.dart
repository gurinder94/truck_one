import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/ServiceListModel.dart';

import '../../../../AppUtils/constants.dart';

class ServiceProvider extends ChangeNotifier {
  ServiceListModel serviceListModel = ServiceListModel();

  bool loading = false;
  String? message;
  List<Datum> serviceList = [];
  String searchText = "";

  String fliterName = "false";
  ServiceProvider()
  {
    resetList();
   hitService(navigatorKey.currentState!.context);
  }

  hitService(
    BuildContext context,
  ) async {
    var getid = await getUserId();
    Map<String, String> map = {
      "_id": getid,
      'searchText': searchText,
      "isDeleted": fliterName,
    };
    serviceList = [];
    loading = true;
    notifyListeners();
    print(map);

    try {
      serviceListModel = await hitServiceList(map);
      serviceList.addAll(serviceListModel.data!);

      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message.toString());

      print(e.toString());
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }

  searchList(String val) {
    searchText = val;

    hitService(navigatorKey.currentState!.context);
  }

  fliterList(String val) {
    fliterName = val;

    hitService(navigatorKey.currentState!.context);
  }

  resetList() {
    serviceList = [];
  }
}
