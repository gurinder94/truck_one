import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';

class FavouriteListProvider extends ChangeNotifier {
  bool eventListLoad = true;
  EventListModel? eventListModel;
  String? message = " ";
  bool paginationLoading = false;

  get loading => eventListLoad;
  int page = 1;
  List<EventModel> favouriteEvent = [];

  ScrollController scrollController = new ScrollController();

  FavouriteListProvider() {
    page = 1;
    paginationLoading = false;
    hitEventsFavourite(
      "FAVOURITE",
      1,
    );
  }

  hitEventsFavourite(
    value,
    int page,
  ) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {
      'userId': getId,
      'page': page.toString(),
      'isfavourite': "true",
    };

    if (paginationLoading)
      paginationLoading = true;
    else {
      page = 1;
      favouriteEvent = [];
      eventListLoad = true;
    }

    notifyListeners();

    try {
      eventListModel = await hitEventFavouriteApi(map);
      favouriteEvent.addAll(eventListModel!.data!);

      //
      notifyListeners();
    } on Exception catch (e) {
      eventListLoad = false;
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    eventListLoad = false;
    paginationLoading = false;
  }

  void addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (paginationLoading) {
          paginationLoading = true;
          page = page + 1;
          if (eventListModel!.data!.length == 0) {
            // showMessage("No record found", context);
          } else {
            hitEventsFavourite("FAVOURITE", 1);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  void removeFavourite(
      String id,int index ) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);
    try {
      var res = await hitRemoveFavouriteApi(map);
      favouriteEvent.removeAt(index);

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      // showMessage(message, context);

      print(e.toString());
      notifyListeners();
    }
  }
}
