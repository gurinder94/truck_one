import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripViewDetails.dart';

class TripPlannerListProvider extends ChangeNotifier {
  bool tripPlannerListLoad = false;

  get loading => tripPlannerListLoad;
  TripPlannerList? tripPlannerList;
  TripViewDetails? tripViewDetails;
  String message = "";
  final String apiKey = "AbwrUXyOT7W8six04ILAJ7ojpUDYQVgs";
  List<LatLng> points = [];
  RouteModel? _routeModel;
  final List<LatLng> markerPositions = [];
  String checkValue = "UPCOMING";

  hitGetDriverList(BuildContext context, String type, String search) async {
    var getid = await getUserId();
    var companyId = await getCompanyId();
    Map<String, dynamic> map = {
      'driverId': getid,
      'createdById': companyId,
      "page": 1,
      "runningStatus": type,
      "searchText": search
    };

    tripPlannerListLoad = true;
    notifyListeners();
    print(map);
    try {
      tripPlannerList = await hitTripPlannerListApi(map);
      print(tripPlannerList!.message.toString());
      tripPlannerListLoad = false;

      notifyListeners();
      message = tripPlannerList!.message.toString();
    } on Exception catch (e) {
      tripPlannerListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      // showMessage(message!, context);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitGetTripPannerList(BuildContext context) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {'createdById': getid};

    tripPlannerListLoad = true;
    notifyListeners();
    print(map);
    try {
      tripPlannerList = await hitTripPlannerListApi(map);
      print(tripPlannerList!.message.toString());
      tripPlannerListLoad = false;

      notifyListeners();
      message = tripPlannerList!.message.toString();
    } on Exception catch (e) {
      tripPlannerListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      // showMessage(message!, context);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitViewTripPlannerView(String tripId, BuildContext context) async {
    Map<String, dynamic> map = {'_id': tripId};
    print("mapmapmap$map ");
    tripPlannerListLoad = true;
    notifyListeners();
    print(map);
    try {
      tripViewDetails = await hitTripPlannerDetailApi(map);
      tripPlannerListLoad = false;
      notifyListeners();
      message = tripViewDetails!.message.toString();
    } on Exception catch (e) {
      tripPlannerListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      // showMessage(message!, context);
      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  setValuefliter(String value) {
    checkValue = value;
    notifyListeners();
  }
}
