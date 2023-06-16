import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/GetServiceMarker.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/snow_weather_model.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Component/Delete_Marker.dart';

class RouteMarkerProvider extends ChangeNotifier {
  RouteModel _model = RouteModel();
  var no;
  var list = [];
  bool hosLoder = false, addMarkerLoder = false;

  RouteModel get routeModel => _model;
  TextEditingController speedController = TextEditingController();
  bool _loading = false;
  late BuildContext context;

  bool get loading => _loading;

  GetServiceMarkerModel _serviceMarkerModel = GetServiceMarkerModel();

  GetServiceMarkerModel get serviceMarkerModel => _serviceMarkerModel;

  List<LatLng> _routePoints = [];

  List<LatLng> get routePoints => _routePoints;
  Map<PolylineId, Polyline> _polyline = <PolylineId, Polyline>{};

  Map<PolylineId, Polyline> get polyline => _polyline;

  Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> get controller => _controller;

  List<LatLng> _turns = [];

  List<LatLng> get turns => _turns;

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  SnowModelList? snowModelList;

  Map<MarkerId, Marker> get markers => _markers;
  String? tripId;
  var calculateTime = [];
  var calculateDistance = [];
  var days = [];
  TripPlannerModel? tripPlannerData;
  RouteMarkerProvider? provider;
  TextEditingController speed = TextEditingController(text: "64");

  var calculateDistanceKm = [];

  setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> getMarkerRouteList(
      TripPlannerModel data, BuildContext context) async {
    tripId = data.id;
    _loading = true;
    tripPlannerData=data;

    notifyListeners();
    var destinationLatitude = "";

    data.destination?.forEach((element) {
      print("element>> ${element}");
      destinationLatitude +=
          "$destinationLatitude:${element.location!.coordinates![0]},${element.location!.coordinates![1]}";
    });

    var url =
        "https://api.tomtom.com/routing/1/calculateRoute/${data.source!.location!.coordinates![0]},${data.source!.location!.coordinates![1]}$destinationLatitude/json?maxAlternatives=${data.alternateRoots}&instructionsType=text&language=en-US&routeRepresentation=polyline&sectionType=travelMode&key=FAwecAoL8qcVNzRyX18RPYKkcfrGTvdB&routeType=eco&traffic=true&avoid=unpavedRoads&arriveAt=${DateFormat("yyyy-MM-dd'T'hh:mm:ss.SSS'Z'").format(data.endDate!)}&travelMode=truck&vehicleEngineType=${"combustion"}&vehicleWeight=${data.grossWeight ~/ 2.2046}&vehicleWidth=${data.width ~/ 39.37}&vehicleHeight=${data.height ~/ 39.37}&vehicleCommercial=true";
    var response = await http.get(Uri.parse(url));
    var jsonRes = json.decode(response.body);
    if (jsonRes["error"] != null) {
      print(jsonRes + "hruighfughuh");

      showMessage(jsonRes["error"]);
    } else {
      _model = RouteModel.fromJson(jsonRes);
      _serviceMarkerModel = await hitgetStoppageApi({'tripPlannerId': data.id});
      _loading = false;
      ConvertSectoDay();
      calculateDistanceKiloMeter();
      calculateDistanceLenght();
      notifyListeners();
    }
  }


  Future<void> applyRoute(
      int index, BuildContext context, RouteMarkerProvider provider) async {
    _markers.clear();
    _routePoints = [];

    routeModel.routes![0].legs?.forEach((element) {
      element.points?.forEach((melement) {
        _routePoints.add(LatLng(
          melement.latitude ?? 0.0,
          melement.longitude ?? 0.0,
        ));
      });

      var polyID = PolylineId('route');
      // if (_polyline.isEmpty) {
      _polyline[polyID] = Polyline(
        polylineId: polyID,
        visible: true,
        points: _routePoints,
        width: 5,
        color: Colors.blue,
      );
    });
    if (_polyline.length > 0) {
      storeTurns(routeModel.routes![index].guidance!.instructions!);
      await setStartEndMarker(
          routePoints[0], routePoints[routePoints.length - 1]);
      moveCamera(_routePoints[0]);
      addWeatherMarker(_routePoints);
      this.provider;
      addServiceMarkers(
        serviceMarkerModel.data!,
        index,
        provider,
      );
      no = index;
    }
    notifyListeners();
  }

  resetRoute() {
    markers.clear();
    polyline.clear();
  }

  void ConvertSectoDay() {
    calculateTime.clear();
    for (int i = 0; i < routeModel.routes!.length; i++) {
      getDuration(Duration(
          seconds: routeModel.routes![i].summary!.travelTimeInSeconds!));

      print("calculateTime $calculateTime");
      notifyListeners();
    }
  }

  getDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    var calculate =
        "${twoDigits(duration.inHours)} h $twoDigitMinutes m $twoDigitSeconds s";
    calculateTime.add(calculate);
    return calculateTime;
  }

  void calculateDistanceKiloMeter() {
    calculateDistanceKm.clear();
    for (int i = 0; i < routeModel.routes!.length; i++) {
      int? n = routeModel.routes![i].summary!.lengthInMeters;
      var km = (n! / 1000).floor();
      calculateDistanceKm.add(km);
      notifyListeners();
    }
  }

  void storeTurns(List<Instruction> instructions) {
    _turns = [];
    for (int i = 0; i < instructions.length; i++) {
      turns.add(LatLng(
          instructions[i].point!.latitude!, instructions[i].point!.longitude!));
    }
  }

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, tilt: 0, zoom: 5)));
  }

  Future<void> setStartEndMarker(LatLng start, LatLng end) async {
    final Uint8List startIcon =
        await getBytesFromAsset('assets/start_flag.png', 100);
    final Uint8List endIcon =
        await getBytesFromAsset('assets/end_flag.png', 100);
    final Uint8List midIcon = await getBytesFromAsset('assets/icons.png', 30);

    List<Placemark>? placemarks;
    var startAddress = "";
    try {
      placemarks =
      await placemarkFromCoordinates(start.latitude, start.longitude);
      if (placemarks != null &&
          placemarks.first != null &&
          placemarks.length > 0)
        startAddress = placemarks.first.locality ?? "start";
    } on Exception catch (e) {
      startAddress = "start";
    }
    _markers[MarkerId('start')] = Marker(
      markerId: MarkerId('start'),
      flat: true,
      icon: BitmapDescriptor.fromBytes(startIcon),
      position: start,
      anchor: Offset(.5, .5),
      infoWindow: InfoWindow(title: startAddress),
      onTap: () {},
    );



    int count=0;

    tripPlannerData?.destination?.forEach((melement) {
      count++;
      print(
          "tripPlannerData>> ${melement.location?.coordinates} ${melement.address}");
      // destinationLatitude +=
      // "$destinationLatitude:${element['location']['coordinates'][0]},${element['location']['coordinates'][1]}";
      var no = Random().nextInt(100);
      _markers[MarkerId('weather$no')] = Marker(
        markerId: MarkerId('weather$no'),
        icon: BitmapDescriptor.fromBytes(count==tripPlannerData?.destination?.length?endIcon:midIcon),
        position: LatLng(melement.location?.coordinates![0] ?? 0.0,
            melement.location!.coordinates![1]),
        infoWindow: InfoWindow(title: '${melement.address}'),
        onTap: () {
          // weatherplan == true
          //     ? weatherMarkerClick(MarkerId('weather$i'))
          //     : SizedBox();
        },
      );
    });
  }


  Future<void> addWeatherMarker(List<LatLng> routePoints) async {
    final Uint8List endIcon = await getBytesFromAsset('assets/sun.png', 90);
    int val = 0;
    for (int i = 0; i < routePoints.length; i++) {
      val = val + 1000;
      print('dd');
      markers[MarkerId('weather$i')] = Marker(
        markerId: MarkerId('weather$i'),
        icon: BitmapDescriptor.fromBytes(endIcon),
        position: routePoints[val] == null
            ? routePoints[routePoints.length - 1]
            : routePoints[val],
        infoWindow: InfoWindow(title: 'weather'),
        onTap: () {},
      );
      Future.delayed(Duration(seconds: 2), () {
        notifyListeners();
      });
    }
  }

  Future<void> addServiceMarkers(
      List<Datum> data, int index, RouteMarkerProvider provider) async {
    for (int i = 0; i < data.length; i++) {
      print(data.length);
      if (data[i].rootId == 'route$index') {
        Uint8List icon =
            await getBytesFromAsset('${'serviceIcon/' + data[i].image!}', 100);

        markers[MarkerId(data[i].id.toString())] = Marker(
          markerId: MarkerId(data[i].id.toString()),
          flat: true,
          icon: BitmapDescriptor.fromBytes(icon),
          position: LatLng(data[i].location!.coordinates![0],
              data[i].location!.coordinates![1]),
          anchor: Offset(.5, .5),
          infoWindow: InfoWindow(title: data[i].serviceName),
          onTap: () {
            print(data[i].id);
            showDialog(
              context: context,
              builder: (context) =>
                  DeleteMarker(data, index, provider, data[i].id),
            );
          },
        );
        addMarkerLoder = false;
        notifyListeners();
      }
    }
  }

  Future<void> companyAddMarker(
      latLng,
      String markerList,
      String markerName,
      String tripId,
      String? serviceList,
      BuildContext context,
      RouteMarkerProvider routeMarkerProvider,
      TextEditingController addMarkerDescription) async {
    addMarkerLoder = true;
    notifyListeners();
    Map<String, dynamic> map = {
      'location': {'coordinates': latLng},
      'image': markerList.substring(
        12,
      ),
      "_id": tripId,
      'rootId': "route$no",
      'type': serviceList,
      'description': addMarkerDescription.text,
      'serviceName': markerName,
    };
    print(map);

    try {
      var res = await hitAddStoppage(map);
      _serviceMarkerModel = await hitgetStoppageApi({'tripPlannerId': tripId});

      var index = _serviceMarkerModel.data!.length;
      print(index);

      addServiceMarkers(
        serviceMarkerModel.data!,
        no,
        routeMarkerProvider,
      );

      var parseData = json.decode(res.body);
      showMessage(parseData['message']);
      addMarkerLoder = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }

    notifyListeners();
  }

  RemoveMarker(
    List<Datum> data,
    RouteMarkerProvider routeMarkerProvider,
    String? markerId,
  ) async {
    routeMarkerProvider._markers.remove(MarkerId(markerId.toString()));
    Map<String, dynamic> map = {"trip_id": tripId, "markerId": markerId};
    var res = await hitgetRemoveMarkerApi(map);
    var parseData = json.decode(res.body);

    showMessage(parseData["message"]);
    _serviceMarkerModel = await hitgetStoppageApi({'tripPlannerId': tripId});
    notifyListeners();
  }

  void calculateDistanceLenght() {
    calculateDistance.clear();
    for (int i = 0; i < routeModel.routes!.length; i++) {
      int? n = routeModel.routes![i].summary!.lengthInMeters;
      var mile = (n! / 1609.344).floor();
      calculateDistance.add(mile);
      notifyListeners();
    }
  }

  hitHos(String value, int index) {
    hosLoder = true;
    notifyListeners();
    days = [];
    if (value != '') {
      print(value);

      var totalDistance =
          ((routeModel.routes![index].summary!.lengthInMeters! / 10) / 100) *
              0.621371;

      print(totalDistance);
      var totalTime =
          (routeModel.routes![index].summary!.travelTimeInSeconds)!.floor() /
              3600;

      var totalTravelDistance = 11 * int.parse(value);
      var noOfDays = totalDistance / totalTravelDistance;
      for (var i = 1; i < noOfDays; i++) {
        if (i == 0) {
          days = [];

          notifyListeners();
        } else {
          print(i);
          days.add(i);
          notifyListeners();
        }
      }

      notifyListeners();
    } else {
      print(value);
      days = [];
      notifyListeners();
    }
    hosLoder = false;
    notifyListeners();
  }
}
