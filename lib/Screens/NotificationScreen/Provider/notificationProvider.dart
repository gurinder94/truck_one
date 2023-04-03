import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NotificationModel/NotificationModel.dart';
import 'package:provider/provider.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../Model/NetworkModel/normal_response.dart';
import '../../Home/Provider/home_page_list_provider.dart';

class NotificationProvider extends ChangeNotifier {
  bool Loading = true;
  bool pagenationLoder = false;
  late NotificationModel notificationModel;
  String? message;
  int page = 1;
  List<Datum> notficationList = [];
  int totalCount = 0;
  ScrollController scrollController = new ScrollController();

  hitNotificationApi(
    BuildContext context,
    bool pagination,
  ) async {
    var getId = await getUserId();
    var roleName = await getRoleInfo();
    totalCount = 0;
    if (pagination == true)
      pagenationLoder = true;
    else {
      page = 1;
      Loading = true;
    }
    notifyListeners();

    Map<String, dynamic> map = {
      "isReaded": true,
      "receiver": getId,
      "role": roleName.toString().toUpperCase() == "COMPANY"
          ? roleName.toString().toUpperCase()
          : roleName.toString().toUpperCase() == "ENDUSER"
              ? roleName.toString().toUpperCase()
              : roleName.toString().toUpperCase() == "SELLER"
                  ? "ECOMMERCE"
                  : roleName.toString().toUpperCase(),
      "accessLevel": roleName.toString().toUpperCase(),
      "page": page,
    };

    try {
      notificationModel = await NotificationModelApi(map);

      notficationList.addAll(notificationModel.data!);
      Loading = false;
      pagenationLoder = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(e.toString());
      notifyListeners();
    }
    Loading = false;
    pagenationLoder = false;
  }


  Future<void> hitReadallNotification() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "reader_id": getid,
    };
    try {
      ResponseModel res = await readAllNotification(map);
      var homeprovider =
          navigatorKey.currentState!.context.read<HomePageListProvider>();

      homeprovider.getAccountDetail();

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(e.toString());
      notifyListeners();
    }
  }

  hitNotificationCount(BuildContext context) async {
    var getId = await getUserId();
    var roleName = await getRoleInfo();

    Map<String, dynamic> map = {
      "isReaded": false,
      "receiver": getId,
      "role": roleName.toString().toUpperCase() == "COMPANY"
          ? roleName.toString().toUpperCase()
          : "ENDUSER",
      "accessLevel": roleName.toString().toUpperCase(),
    };

    print(map);
    try {
      notificationModel = await NotificationModelApi(map);

      totalCount = notificationModel.totalCount!.toInt();

      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  void setCount(int totalcount) {
    this.totalCount = totalcount;
    notifyListeners();
  }

  void addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (notficationList.length < notificationModel.totalCount!) {
          page = page + 1;
          hitNotificationApi(context, true);
        }
      }
    });
  }
}
