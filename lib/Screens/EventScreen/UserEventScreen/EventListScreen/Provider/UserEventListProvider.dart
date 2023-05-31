import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';

class UserEventListProvider extends ChangeNotifier {
  bool eventListLoad = true;
  EventListModel? eventListModel;
  String? EventHeading = "TOP";
  String? message = " ";
  bool paginationLoading = false;
  bool locationPermission = false;

  get loading => eventListLoad;
  var lat;
  var long;
  List<EventModel> Event = [];


  hitGetEventsList(
    BuildContext context,
    value,
    int page,
    pagination,
    val,
    int distance,
  ) async {
    var meter = (distance * 1609.344).floor();
    var getid = await getUserId();
    var getRoleName = await getRoleInfo();
    Map<String, dynamic> map = {};
    locationPermission == false
        ? map = {
            'searchType': value,
            'page': page.toString(),
            'visibility': "Public",
            "roleTitle": getRoleName,
            "userId": getid,
            "searchText": val == null ? '' : val
          }
        : map = {
            'searchType': value,
            'page': page.toString(),
            'visibility': "Public",
            "roleTitle": getRoleName,
            "lat": lat,
            "lng": long,
            "userId": getid,
            "distance": meter,
            "searchText": val == null ? '' : val
          };

    if (pagination)
      paginationLoading = true;
    else {
      eventListLoad = true;
      Event = [];
    }
    notifyListeners();

    try {
      eventListModel = await hitUserEventsListAPI(map);

      Event.addAll(eventListModel!.data!);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message);
    }
    eventListLoad = false;
    paginationLoading = false;
  }







  resetList() {
    Event = [];
  }

  Future<void> getLocation(
    BuildContext context,
    String taber,
    int page,
    bool pagination,
    search,
  ) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMessage('Please Enable Location');
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      resetList();
      locationPermission = false;

      hitGetEventsList(context, taber, 1, false, search, 0);
      return Future.error('Location permissions are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      locationPermission = false;
      resetList();
      hitGetEventsList(context, taber, 1, false, search, 0);
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.whileInUse) {
      print(permission);
      locationPermission = true;
      notifyListeners();
      Position position = await Geolocator.getCurrentPosition();
      resetList();
      hitGetEventsList(context, taber, 1, false, search, 0);

      long = position.longitude;
      lat = position.latitude;
      locationPermission = true;
      notifyListeners();
    }
    notifyListeners();
  }
}
