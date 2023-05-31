import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';

class BookedEventListProvider extends ChangeNotifier {
  bool eventListLoad = true;
  EventListModel? eventListModel;
  String? EventHeading = "TOP";
  String? message = " ";
  bool paginationLoading = false;
  bool locationPermission = false;
  ScrollController scrollController = new ScrollController();
  var page = 1;
  get loading => eventListLoad;
  var lat;
  var long;

  List<EventModel> bookedEvent = [];
  BookedEventListProvider()
  {
    hitBookEventList(navigatorKey.currentState!.context, 1);
  }
  hitBookEventList(BuildContext context, int page, ) async {

    var getId = await getUserId();
    Map<String, dynamic> map = {
      'userId': getId,
      'page': page,
    };

    print(map);
    if ( paginationLoading)
      paginationLoading = true;
    else
      {
        bookedEvent=[];
        eventListLoad = true;
      }
    notifyListeners();

    try {
      eventListModel = await hitEventBookNowListApi(map);
      bookedEvent.addAll(eventListModel!.data!);
      eventListLoad = false;
      paginationLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      notifyListeners();
    }
  }

  void addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginationLoading=true;
        if (paginationLoading) {
          page = page + 1;
          if (eventListModel!.data!.length == 0) {
          } else {
            hitBookEventList(context, page,);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }
}
