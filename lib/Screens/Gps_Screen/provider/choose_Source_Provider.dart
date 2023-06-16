import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/TripPlannerModel/trip_history_model.dart';

class ChooseSourceProvider extends ChangeNotifier {
  static const country = 'country';
  bool getLoading=false;
  List<AutocompletePrediction> predictions = [];
  List<Datum> histryLocation=[];
 late  TripHistoryModel historyModel;
  double? Longitude;
  double? Latitude;
  List<String> items = [
    "Arrive By",
    "Depart at",
  ];
  late StreamSubscription<Position> positionStream;
  var valueItemSelected = "Arrive By";
  TextEditingController addressController = TextEditingController(text: "");
  TextEditingController addressNextController = TextEditingController(text: "");

  Future<void> autoCompleteSearch(String value) async {
    if (value.length != 0) {
      print(value);
      var googlePlace = GooglePlace("AIzaSyC0y2S4-iE2rHkYdyAsglz_qirv0UtpF1s");

      var result = await googlePlace.autocomplete.get(value, components: [
        Component(country, 'US'),
        Component(country, 'MEX'),
        Component(country, 'CAN')
      ]);

      if (result != null && result.predictions != null) {
        predictions = result.predictions!;

        notifyListeners();
      } else {
        predictions = [];
        notifyListeners();
      }
    } else {
      print(value);
    }
  }

  Future handleSearch(
      var query, BuildContext context, AddTripProvider addTripProvider) async {
    if (query.length > 8) {
      try {
        List locations = await locationFromAddress(query);
        locations.forEach((location) async {
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          /*  placeMarks.forEach((placeMark) {
              addPlace();
            });*/
          predictions = [];
          Longitude = location.longitude;
          Latitude = location.latitude;
          print(query);
          notifyListeners();
          addTripProvider.setAddress(location.longitude, location.latitude);

        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      addressController.text = "";
      predictions = [];
      notifyListeners();
    }
  }

  getAddress(var Long, var Lat) {
    this.Longitude = Long;
    this.Latitude = Lat;

    print(Long);
    print(Lat);
  }

  Future DestinationSearch(
      var query, BuildContext context, AddTripProvider addTripProvider) async {
    if (query.length > 8) {
      try {
        List locations = await locationFromAddress(query);
        locations.forEach((location) async {
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          /*  placeMarks.forEach((placeMark) {
              addPlace();
            });*/
          predictions = [];
          Longitude = location.longitude;
          Latitude = location.latitude;
          print(query);
          notifyListeners();
          addTripProvider.setDestinationAddress(
              location.longitude, location.latitude);
          Navigator.pop(navigatorKey.currentState!.context);

        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      addressController.text = "";
      predictions = [];
      notifyListeners();
    }
  }

  getAddressListReset(List<AutocompletePrediction> predictions) {
    this.predictions = predictions;

    notifyListeners();
  }

  void setSelectedItem(String name) {
    valueItemSelected = name;

    notifyListeners();
  }

  hitTripHistry() async {
    var getId = await getUserId();
    Map<String, dynamic> map = {
      "count": 6,
      "createdById": getId,
    };
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      historyModel = await hitrTripHistoryApi(map);
      histryLocation.addAll(historyModel.data!);
      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }
  Future<void> getLocation(AddTripProvider addTripProvider,chooseSource) async {
    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    ).listen((Position position) {

      addTripProvider.setAddress(position.longitude, position.latitude);

    });
   addressController.text = "Your location";
   chooseSource.text = "Your location";
    Navigator.pop(navigatorKey.currentState!.context);
    notifyListeners();
  }
}
