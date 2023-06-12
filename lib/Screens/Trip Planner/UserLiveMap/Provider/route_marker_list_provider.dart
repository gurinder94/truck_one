import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/GetServiceMarker.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/forecast_weather_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/preciptaion_waether_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/snow_weather_model.dart';
import 'package:my_truck_dot_one/Model/WeatherModel/thunder_weather_model.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Component/weather_screen.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Provider/user_navigation_provider.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/user_map_navigation.dart';
import 'package:provider/provider.dart';

import '../../../../AppUtils/UserInfo.dart';
import '../../../commanWidget/my_marker_info_dialog.dart';
import '../../tracking_system.dart';

class RouteMarkerListProvider extends ChangeNotifier {
  RouteModel _model = RouteModel();
  var radioSelected;

  RouteModel get routeModel => _model;
  List TempeaturePoint = [];
  bool _loading = false;
  int pos = 0;
  String? roleName;

  bool get loading => _loading;

  GetServiceMarkerModel _serviceMarkerModel = GetServiceMarkerModel();
  SnowModelList? snowModelList;
  List<LatLng> snowCoordinates = [];
  List<LatLng> thunderCoordinator = [];
  ThunderModelList? thunderModelList;
  ForecastWeatherModel? forecastWeatherModel;
  PrecipitationtWeatherModel? precipitationtWeatherModel;
  List<LatLng> forecastCoords = [];
  bool weatherLoading = true;
  List<LatLng> precipitationtWeather = [];

  var forecastColor;
  var weatherColor;
  var thunderColor;
  var stroke;
  var strokeWidth;
  var withOpacity;
  var thunderstrokeWidth;

  GetServiceMarkerModel get serviceMarkerModel => _serviceMarkerModel;

  List<LatLng> _routePoints = [];

  List<LatLng> get routePoints => _routePoints;
  Map<PolylineId, Polyline> _polyline = <PolylineId, Polyline>{};
  List<LatLng> polygonCoords = [];
  List<Colors> snowColor = [];
  Map<PolygonId, Polygon> _polygon = <PolygonId, Polygon>{};

  Map<PolygonId, Polygon> get polygon => _polygon;

  Map<PolylineId, Polyline> get polyline => _polyline;
  List<LatLng> thunderCoords = [];
  Completer<GoogleMapController> _controller = Completer();
  List weatherName = [];
  var list = [];
  var ThunderRemoveList = [];
  var forecastRemoveList = [];
  var precipitationtRemoveList = [];

  Completer<GoogleMapController> get controller => _controller;

  List<LatLng> _turns = [];
  List<LatLng> weatherMarkers = [];

  List<LatLng> get turns => _turns;

  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  Map<MarkerId, Marker> get markers => _markers;

  Future<void> getMarkerRouteList(TripPlannerModel data) async {
    _loading = true;
    notifyListeners();
    var url =
        "https://api.tomtom.com/routing/1/calculateRoute/${data.source!.location!.coordinates![0]},${data.source!.location!.coordinates![1]}:${data.destination![0].location!.coordinates![0]},${data.destination![0].location!.coordinates![1]}/json?maxAlternatives=${data.alternateRoots}&instructionsType=text&language=en-US&routeRepresentation=polyline&sectionType=travelMode&key=FAwecAoL8qcVNzRyX18RPYKkcfrGTvdB&routeType=eco&traffic=true&avoid=unpavedRoads&arriveAt=${DateFormat("yyyy-MM-dd'T'hh:mm:ss.SSS'Z'").format(data.endDate!)}&travelMode=truck&vehicleEngineType=${"combustion"}&vehicleWeight=${data.grossWeight ~/ 2.2046}&vehicleWidth=${data.width ~/ 39.37}&vehicleHeight=${data.height ~/ 39.37}&vehicleCommercial=true";
    var response = await http.get(Uri.parse(url));
    var jsonRes = json.decode(response.body);
    _model = RouteModel.fromJson(jsonRes);
    _serviceMarkerModel = await hitgetStoppageApi({'tripPlannerId': data.id});
    print(url);
    notifyListeners();
    _loading = false;
  }

  Future<void> applyRoute(int index) async {
    _markers.clear();
    weatherMarkers.clear();
    _routePoints = [];
    List<Point>? data = routeModel.routes![index].legs![0].points;
    for (int i = 0; i < data!.length; i++) {
      _routePoints.add(LatLng(data[i].latitude!, data[i].longitude!));
      notifyListeners();
    }

    var polyID = PolylineId('route');
    if (_polyline.length == 0) {
      _polyline[polyID] = Polyline(
        polylineId: polyID,
        visible: true,
        points: _routePoints,
        width: 5,
        color: Colors.deepPurpleAccent,
      );
    } else {
      _polyline[polyID] =
          _polyline[polyID]!.copyWith(pointsParam: _routePoints);
    }
    storeTurns(routeModel.routes![index].guidance!.instructions!);
    await setStartEndMarker(
        routePoints[0], routePoints[routePoints.length - 1]);
    moveCamera(_routePoints[0]);
    addWeatherMarker(_routePoints);
    addServiceMarkers(serviceMarkerModel.data!, index);
  }

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, tilt: 30, zoom: 7.5)));
  }

  Future<void> openNavigation(int index, BuildContext context) async {
    await applyRoute(index);
    var getrole = await getRoleInfo();

    getrole != "DRIVER"
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => UserNavigationProvider(),
                    child: TrackingSystem(
                        _polyline,
                        turns,
                        routeModel.routes![index],
                        markers,
                        weatherMarkers,
                        _routePoints[0]))))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (context) => UserNavigationProvider(),
                    child: UserMapNavigation(
                        _polyline,
                        turns,
                        routeModel.routes![index],
                        markers,
                        weatherMarkers,
                        _routePoints[0]))));
  }

  void storeTurns(List<Instruction> instructions) {
    _turns = [];
    for (int i = 0; i < instructions.length; i++) {
      turns.add(LatLng(
          instructions[i].point!.latitude!, instructions[i].point!.longitude!));
    }
  }

  Future<void> setStartEndMarker(LatLng start, LatLng end) async {
    final Uint8List startIcon =
        await getBytesFromAsset('assets/start_flag.png', 100);
    final Uint8List endIcon =
        await getBytesFromAsset('assets/end_flag.png', 100);
    markers[MarkerId('start')] = Marker(
      markerId: MarkerId('start'),
      flat: true,
      icon: BitmapDescriptor.fromBytes(startIcon),
      position: start,
      anchor: Offset(.5, .5),
      infoWindow: InfoWindow(title: 'Start'),
      onTap: () {},
    );
    markers[MarkerId('end')] = Marker(
      markerId: MarkerId('end'),
      flat: true,
      icon: BitmapDescriptor.fromBytes(endIcon),
      position: end,
      anchor: Offset(.5, .5),
      infoWindow: InfoWindow(title: 'End'),
      onTap: () {},
    );
  }

  Future<void> addWeatherMarker(List<LatLng> routePoints) async {
    var weatherplan = await getWeatherPlanData();
    final Uint8List endIcon = await getBytesFromAsset('assets/weather.png', 70);
    int val = 0;

    for (int i = 0; i < routePoints.length; i++) {
      val = routePoints.length > 900 ? val + 1000 : val + 100;
      if (routePoints[val] != null) {
        markers[MarkerId('weather$i')] = Marker(
          markerId: MarkerId('weather$i'),
          icon: BitmapDescriptor.fromBytes(endIcon),
          position: routePoints[val],
          infoWindow: InfoWindow(title: 'weather'),
          onTap: () {
            weatherplan == true
                ? weatherMarkerClick(MarkerId('weather$i'))
                : SizedBox();
          },
        );
        print(weatherMarkers);
        weatherMarkers.add(routePoints[val]);
        print(weatherMarkers);
      } else
        break;
    }
    Future.delayed(Duration(seconds: 2), () {
      notifyListeners();
    });
  }

  Future<void> addServiceMarkers(List<Datum> data, int index) async {
    for (int i = 0; i < data.length; i++) {
      print(data[i].address);
      print(data[i].rootId);
      if (data[i].rootId == 'route$index') {
        print(index);
        print(data[i].description);
        Uint8List icon =
            await getBytesFromAsset('serviceIcon/${data[i].image!}', 75);
        markers[MarkerId(data[i].id.toString())] = Marker(
          markerId: MarkerId(data[i].id.toString()),
          flat: true,
          icon: BitmapDescriptor.fromBytes(icon),
          position: LatLng(data[i].location!.coordinates![0],
              data[i].location!.coordinates![1]),
          anchor: Offset(.5, .5),
          onTap: () {
            showDialog(
                context: navigatorKey.currentState!.context,
                builder: (ctx) => MyMarkerInfoDialog(
                    data[i].image.toString(),
                    data[i].address.toString(),
                    data[i].location!.coordinates![0].toString(),
                    data[i].location!.coordinates![1].toString(),
                    data[i].description.toString(),
                    data[i].serviceName.toString()));
          },
        );
      }

      markers;
      notifyListeners();
    }
  }

  void setContext(BuildContext context) {}

  hitSnowWeather(String days) async {
    Map<String, dynamic> map = {};
    list = [];

    snowCoordinates = [];
    snowModelList = await SnowWeatherApi(map, days);
    for (int p = 0; p < snowModelList!.data!.features!.length; p++) {
      thunderColor = snowModelList!.data!.features![p].properties!.fill;

      withOpacity = snowModelList!.data!.features![p].properties!.strokeOpacity;
      stroke = snowModelList!.data!.features![p].properties!.stroke;
      var lable = snowModelList!.data!.features![p].properties!.name;
      List<List<List<double>>>? coordinates =
          snowModelList!.data!.features![p].geometry!.coordinates;
      print(snowModelList!.data!.features![p].geometry!.coordinates!.length);
      for (int i = 0; i < coordinates!.length; i++) {
        var polyID = PolygonId('$lable$i');
        snowCoordinates = [];
        for (int j = 0; j < coordinates[i].length; j++) {
          snowCoordinates
              .add(LatLng(coordinates[i][j][1], coordinates[i][j][0]));
        }
        _polygon[polyID] = Polygon(
          polygonId: polyID,
          points: snowCoordinates,
          fillColor: hexToColor("$thunderColor").withOpacity(.6),
          strokeWidth: 1,
        );

        Map<dynamic, dynamic> mapp = {};
        mapp['$lable$i'] = 'Snow';
        mapp.entries.forEach((e) => list.add((e.key)));
      }
    }
    if (snowCoordinates.length != 0) {
      weatherName.add("Snow");
    }
    resfres();
    notifyListeners();
  }

  hitThunderWeather(String days) async {
    Map<String, dynamic> map = {};
    print(map);
    ThunderRemoveList = [];
    thunderModelList = await ThunderWeatherApi(map, days);
    for (int p = 0; p < thunderModelList!.data!.features!.length; p++) {
      thunderstrokeWidth =
          thunderModelList!.data!.features![p].properties!.strokeWidth;
      thunderColor = thunderModelList!.data!.features![p].properties!.fill;
      withOpacity =
          thunderModelList!.data!.features![p].properties!.strokeOpacity;
      stroke = thunderModelList!.data!.features![p].properties!.stroke;
      var lable = thunderModelList!.data!.features![p].properties!.label;
      List<List<List<double>>>? coordinates =
          thunderModelList!.data!.features![p].geometry!.coordinates;
      for (int i = 0; i < coordinates!.length; i++) {
        var polyID = PolygonId('$lable$i');
        thunderCoordinator = [];
        for (int j = 0; j < coordinates[i].length; j++) {
          thunderCoordinator
              .add(LatLng(coordinates[i][j][1], coordinates[i][j][0]));
        }
        _polygon[polyID] = Polygon(
          polygonId: polyID,
          points: thunderCoordinator,
          fillColor: hexToColor("#1c4fad").withOpacity(.3),
          strokeWidth: 1,
        );
        Map<dynamic, dynamic> mapp = {};
        mapp['$lable$i'] = 'Thunder';
        mapp.entries.forEach((e) => ThunderRemoveList.add((e.key)));
      }
    }

    if (thunderCoordinator.length != 0) {
      weatherName.add("Thunder");
    }
    resfres();
    notifyListeners();
  }

  hitForecastWeather(String days) async {
    Map<String, dynamic> map = {};
    print(map);
    forecastCoords = [];
    forecastWeatherModel = await ForecastWeatherApi(map, days);

    for (int p = 0; p < forecastWeatherModel!.data!.features!.length; p++) {
      thunderstrokeWidth =
          forecastWeatherModel!.data!.features![p].properties!.strokeWidth;
      thunderColor = forecastWeatherModel!.data!.features![p].properties!.fill;
      withOpacity =
          forecastWeatherModel!.data!.features![p].properties!.strokeOpacity;
      stroke = forecastWeatherModel!.data!.features![p].properties!.stroke;
      var lable = forecastWeatherModel!.data!.features![p].properties!.name;
      for (int j = 0;
          j <
              forecastWeatherModel!
                  .data!.features![p].geometry!.geometries!.length;
          j++) {
        List<List<List<double>>>? coordinates = forecastWeatherModel!
            .data!.features![p].geometry!.geometries![j].coordinates;
        for (int i = 0; i < coordinates!.length; i++) {
          var polyID = PolygonId('$lable$i');
          List<LatLng> lak = [];
          for (int j = 0; j < coordinates[i].length; j++) {
            lak.add(LatLng(coordinates[i][j][1], coordinates[i][j][0]));
          }
          _polygon[polyID] = Polygon(
            polygonId: polyID,
            points: lak,
            fillColor: hexToColor("#ff6f00").withOpacity(.3),
            strokeWidth: 1,
          );

          Map<dynamic, dynamic> mapp = {};
          mapp['$lable$i'] = 'ForecastWeather';
          mapp.entries.forEach((e) => forecastRemoveList.add((e.key)));
        }
      }
    }

    if (forecastRemoveList.length != 0) {
      weatherName.add("ForecastWeather");
    }

    resfres();
    notifyListeners();
  }

  hitPrecipitationtWeather(String days) async {
    Map<String, dynamic> map = {};
    print(map);
    precipitationtRemoveList = [];
    precipitationtWeatherModel = await PrecipitationtWeatherApi(map, days);
    for (int p = 0;
        p < precipitationtWeatherModel!.data!.features!.length;
        p++) {
      thunderstrokeWidth = precipitationtWeatherModel!
          .data!.features![p].properties!.strokeWidth;
      thunderColor =
          precipitationtWeatherModel!.data!.features![p].properties!.fill;
      withOpacity = precipitationtWeatherModel!
          .data!.features![p].properties!.strokeOpacity;
      stroke =
          precipitationtWeatherModel!.data!.features![p].properties!.stroke;
      var lable =
          precipitationtWeatherModel!.data!.features![p].properties!.name;

      List<List<List<double>>>? coordinates =
          precipitationtWeatherModel!.data!.features![p].geometry!.coordinates;

      for (int i = 0; i < coordinates!.length; i++) {
        var polyID = PolygonId('$lable$i');

        List<LatLng> thunderCoord = [];
        for (int j = 0; j < coordinates[i].length; j++) {
          thunderCoord.add(LatLng(coordinates[i][j][1], coordinates[i][j][0]));
        }
        _polygon[polyID] = Polygon(
          polygonId: polyID,
          points: thunderCoord,
          fillColor: hexToColor("#a200ff").withOpacity(0.3),
          strokeWidth: 1,
        );
        Map<dynamic, dynamic> mapp = {};
        mapp['$lable$i'] = 'PrecipitationWeather';
        mapp.entries.forEach((e) => precipitationtRemoveList.add((e.key)));
      }
    }

    if (precipitationtRemoveList.length != 0) {
      weatherName.add("Precipitationt");
    }

    print(thunderCoords);
    resfres();
    notifyListeners();
  }

  resfres() {
    _polygon;
    weatherName;

    notifyListeners();
  }

  removePolyon(List<dynamic> list) {
    for (int i = 0; i < list.length; i++) {
      PolygonId _polgonId = PolygonId(list[i]);
      _polygon.remove(_polgonId);
      notifyListeners();
    }
  }

  RemovePolygonline() {
    _polygon.clear();
    weatherName = [];
    weatherMarkers.clear();
    _routePoints.clear();
    _turns.clear();
    markers.clear();
  }

  showweatherList() {
    _polygon;
    weatherName;
    notifyListeners();
  }

  allWeatherDaythreeSeven(String days) async {
    weatherLoading = true;
    hitSnowWeather(days);
    hitPrecipitationtWeather(days);
    hitThunderWeather(days);
    hitForecastWeather(days);
    weatherLoading = false;
  }

  setmenuBar(int value) {
    pos = value;
    notifyListeners();
  }

  firstList() {
    weatherName.add("All");
    notifyListeners();
  }

  getRoleName() async {
    roleName = await getRoleInfo();
    print("rolename${roleName}");
    notifyListeners();
  }

  void weatherMarkerClick(MarkerId markerId) {
    showModalBottomSheet(
        context: navigatorKey.currentState!.context,
        builder: (context) => WeatherScreen(pos: markers[markerId]!.position));
  }
}
