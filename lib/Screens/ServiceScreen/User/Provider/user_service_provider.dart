import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/ServiceListModel.dart';

import '../../../../AppUtils/constants.dart';

class UserServiceProvider extends ChangeNotifier {
  ServiceListModel serviceListModel = ServiceListModel();
  List<Datum> serviceList = [];
  ScrollController scrollController = new ScrollController();
  bool loading = false;
  bool PaginationLoader = false;
  String? message;
  var locationPermission = false;
  var lat, long;
  int pagee = 1;
  String searchText = "";
  int distance = 0;
  Map<String, dynamic> map = {};

  var meter;

  UserServiceProvider() {
    PaginationLoader = false;

    getLocation(navigatorKey.currentState!.context);
    addScrollListener();
  }

  hitGetServiceList(
    BuildContext context,
  ) async {
    meter = (distance * 1609.344).floor();

    if (PaginationLoader == false) {
      serviceList = [];
      pagee = 1;
      distance = 0;
      loading = true;
    } else {
      PaginationLoader = true;
    }
    notifyListeners();
    if (locationPermission == true && distance != 0) {
      map = {
        'searchText': searchText,
        'page': pagee.toString(),
        "isActive": "true",
        "lat": lat,
        "lng": long,
        "distance": meter,
      };
    } else {
      map = {
        'searchText': searchText,
        'page': pagee.toString(),
        "isActive": "true",
      };
    }
    print(map);
    try {
      serviceListModel = await hitUserServiceList(map);
      serviceList.addAll(serviceListModel.data!);
      loading = false;
      PaginationLoader = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      loading = false;
      PaginationLoader = false;
      notifyListeners();
    }
  }

  ResetList() {
    serviceList = [];
    notifyListeners();
    PaginationLoader = false;
  }

  Future<void> getLocation(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showMessage('Please Enable Location');
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      serviceList = [];
      locationPermission = false;
      hitGetServiceList(
        context,
      );
      return Future.error('Location permissions are denied');
    }

    if (permission == LocationPermission.whileInUse) {
      print(permission);
      serviceList = [];
      locationPermission = true;
      notifyListeners();
      Position position = await Geolocator.getCurrentPosition();

      hitGetServiceList(
        context,
      );
      long = position.longitude;
      lat = position.latitude;
      locationPermission = true;
      notifyListeners();
    }
    notifyListeners();
  }

  addScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        PaginationLoader = true;
        if (PaginationLoader) {
          if (serviceList.length < serviceListModel.totalCount!) {
            pagee = pagee + 1;
            hitGetServiceList(navigatorKey.currentState!.context);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  void serviceListSearch(String val) {
    searchText = val;
    PaginationLoader = false;
    hitGetServiceList(
      navigatorKey.currentState!.context,
    );
  }

  void distanceSearch(int distance) {
    this.distance = distance;
    PaginationLoader = false;
    hitGetServiceList(
      navigatorKey.currentState!.context,
    );
  }
}
