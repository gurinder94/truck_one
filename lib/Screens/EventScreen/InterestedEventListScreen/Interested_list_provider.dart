import 'package:flutter/cupertino.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';

class InterestedListProvider extends ChangeNotifier {
  bool eventListLoad = true;
  EventListModel? eventListModel;
  String? message = " ";
  bool paginationLoading = false;

  get loading => eventListLoad;
  var lat;
  var long;

  int page = 1;
  List<EventModel> interestedEvent = [];
  ScrollController scrollController = new ScrollController();

  InterestedListProvider() {
    interestedEvent = [];
    page = 1;
    addScrollListener(navigatorKey.currentState!.context);
    hitEventInterested(
      navigatorKey.currentState!.context,
      "INTERESTED",
      1,
    );
  }

  hitEventInterested(BuildContext context, String value, int page) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {
      'userId': getId,
      'page': page.toString(),
      'isInterested': 'true'
    };
    if (paginationLoading)
      paginationLoading = true;
    else {
      interestedEvent = [];
      page = 1;
      eventListLoad = true;
    }
    notifyListeners();
    print(map);
    try {
      eventListModel = await hitEventInterestedAPI(map);

      interestedEvent.addAll(eventListModel!.data!);

      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
    eventListLoad = false;
    paginationLoading = false;
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginationLoading = true;
        if (paginationLoading) {
          page = page + 1;
          if (eventListModel!.data!.length == 0) {
          } else {
            hitEventInterested(
              context,
              "INTERESTED",
              page,
            );
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  void removeInterested(String id, int index) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);
    try {
      var res = await hitRemoveInterestedApi(map);
      interestedEvent.removeAt(index);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      print(e.toString());
      notifyListeners();
    }
  }
}
