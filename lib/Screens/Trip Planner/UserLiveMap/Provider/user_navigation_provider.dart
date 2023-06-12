import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/map_calulcations.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/WazeModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/get_all_waze_marker_model.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Component/weather_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../AppUtils/chat_socket_connection.dart';
import '../Listeners/waze_remove_marker_Listeners.dart';

class UserNavigationProvider extends ChangeNotifier
    with WazeMarkerRemoveListener {
  int speed = 0, turnIndex = 0, speakerControl = 0;
  double lat = 0.0, lon = 0.0;
  String instruction = '';
  String? message;
  double turnCheckValue = 0.0;
  MapType mapType = MapType.normal;
  bool routingStart = false;
  double openWeather = -200;
  WazeModel wazeModel = new WazeModel();
  ResponseModel responseModel = new ResponseModel();
  List<LatLng> finalLatLng = [];
  bool check = false;
  late BuildContext context;
  late LatLng latLng;
  Position? myTruckPosition;

  ///
  List<LatLng> turns = [];
  List<LatLng> wazePoint = [];
  late RoutePath routePath;

  ///
  final Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> get controller => _controller;

  ///
  late StreamSubscription<Position> positionStream;

  ///
  FlutterTts flutterTts = FlutterTts();

  ///
  Map<PolylineId, Polyline> polyline = {};

  ///
  Map<MarkerId, Marker> _markers = {};

  Map<MarkerId, Marker> addReportMarker = {};

  ///
  List<LatLng> weatherMarkers = [];

  ///
  Map<MarkerId, Marker> get markers => _markers;

  ///
  GetWazeMarker getWazeMarker = GetWazeMarker();
  late ChatSocketConnection _connection;
  bool connection = true;

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    // setWeatherMarkers(weatherMarkers);
    if (!serviceEnabled) {
      showMessage('Please Enable Location');
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      ),
    ).listen((Position position) {
      addMarker(position);
      lat = position.latitude.toDouble();
      lon = position.longitude.toDouble();
      notifyListeners();
    });
    routingStart = true;
    moveCamera(LatLng(lat, lon));
    notifyListeners();
  }

  Future<void> addMarker(Position position) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/arrow.png', 200);
    moveCameraWithVehicle(position);
    myTruckPosition = position;
    speed = position.speed.toInt();
    /*markers[MarkerId('me')] = Marker(
      anchor: Offset(.5, .5),
      markerId: MarkerId('me'),
      rotation: position.heading,
      flat: true,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: LatLng(position.latitude.toDouble(), position.longitude.toDouble()),
      infoWindow: InfoWindow(title: 'My Truck'),
    );*/
    getSignValue(position.latitude, position.longitude);
    showAddWazeMarker(myTruckPosition!.latitude, myTruckPosition!.longitude);
  }

  Future<void> moveCameraWithVehicle(Position pos) async {
    final GoogleMapController controller = await _controller.future;
    var zoom = await controller.getZoomLevel();
    print(zoom);
    if (zoom == 19.5) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: pos.heading,
          target: LatLng(pos.latitude, pos.longitude),
          tilt: 30,
          zoom: 19.5)));
    }
  }

  Future<void> moveCamera(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, tilt: 30, zoom: 19.5)));
  }

  Future<void> moveCameras(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: pos, tilt: 30, zoom: 7.5)));
  }

  void savePath(
      Map<PolylineId, Polyline> polyline,
      List<LatLng> turns,
      RoutePath routePath,
      Map<MarkerId, Marker> markers,
      List<LatLng> weatherMarkers,
      LatLng routePoint) {
    this.polyline = polyline;
    this.turns = turns;
    this.routePath = routePath;
    this._markers = markers;
    this.weatherMarkers = weatherMarkers;
    moveCameras(routePoint);
  }

  void setMapType(MapType type) {
    this.mapType = type;
    notifyListeners();
  }

  void setCamera() {
    moveCamera(LatLng(lat, lon));
  }

  void stopRouting() {
    routingStart = false;
    positionStream.cancel();
    markers.remove(MarkerId('me'));
    notifyListeners();
  }

  Future<void> getSignValue(double latitude, double longitude) async {
    List<double> dist = [];
    for (int i = 0; i < turns.length; i++) {
      double km = (calculateDistance(
              latitude, longitude, turns[i].latitude, turns[i].longitude)) *
          1.7;
      dist.add(km);
    }
    double small = dist.reduce(min);
    int index = dist.indexOf(small);
    String aa =
        routePath.guidance!.instructions![index].maneuver!.replaceAll('_', ' ');
    if (turnCheckValue > small) {
      speakerControl++;
      instruction = aa + "\n" + small.toStringAsFixed(2) + ' miles';
      if (small < 1 && speakerControl >= 5) {
        speakerControl = 0;
        var result = await flutterTts
            .speak('in' + ' ' + small.toStringAsFixed(2) + ' miles ' + aa);
      }
    } else {
      speakerControl = 0;
      instruction = 'N/A';
    }
    turnCheckValue = small;
  }

  Future<void> setWeatherMarkers(List<LatLng> weatherMarkers) async {
    var weatherplan = await getWeatherPlanData();
    var roletitle = await getRoleInfo();
    final Uint8List endIcon = await getBytesFromAsset('assets/weather.png', 70);
    for (int i = 0; i < weatherMarkers.length; i++) {
      markers[MarkerId('weather$i')] = Marker(
        markerId: MarkerId('weather$i'),
        icon: BitmapDescriptor.fromBytes(endIcon),
        position: weatherMarkers[i],
        infoWindow: InfoWindow(title: 'weather'),
        onTap: () {
          weatherplan == true
              ? weatherMarkerClick(MarkerId('weather$i'))
              : SizedBox();
          // DialogUtils.showMyDialog(
          //   context,
          //   onDoneFunction: () async {
          //     Navigator.pop(context);
          //
          //   },
          //   oncancelFunction: () => Navigator.pop(context),
          //   title: AppLocalizations.instance.text('Buy Plan !'),
          //   alertTitle:
          //   "Pricing Price",
          //   btnText: AppLocalizations.instance.text("Yes"),
          // );
        },
      );
    }
  }

  void weatherMarkerClick(MarkerId markerId) {
    showModalBottomSheet(
        context: context,
        builder: (context) => WeatherScreen(pos: markers[markerId]!.position));
  }

  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> setReportMarkers(
      String markerAddReportIcon, String markerId) async {
    var weightData = [];
    var pp = [];

    bool checkMarkerLocation = true;

    addReportMarker.forEach((k, v) =>
        weightData.add(addReportMarker.values.map((e) => e.position).toList()));

    // if (weightData.length != 0) {
    //   for (int i = 0; i < weightData.length; i++) {
    //     pp = weightData[i];
    //     var f = finalLatLng[0];
    //
    //     if (f == pp[i]) {}
    //   }
    // } else {
    //   setWazerMarkers(getWazeMarker.data);
    //   addMakerWazeMap(markerId);
    // }

    if (checkMarkerLocation == true) {
      setWazerMarkers(getWazeMarker.data);
      addMakerWazeMap(markerId);
    }
  }

  hitgetWazeList() async {
    var res;

    Map<String, String> map = {};

    print(map);
    try {
      wazeModel = await hitGetWazeMap(map);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
    }
  }

  addMakerWazeMap(
    String markerId,
  ) async {
    var getId = await getUserId();

    Map<String, dynamic> map = {
      'location': {
        'coordinates': [myTruckPosition!.latitude, myTruckPosition?.longitude],
      },
      'markerId': markerId,
      "createdby_id": getId,
    };

    try {
      responseModel = await hitAddMarkerWazeMap(map);
      getMarkerWazeMap();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
    }
  }

  getMarkerWazeMap() async {
    Map<String, dynamic> map = {};

    print(map);
    try {
      getWazeMarker = await hitGetAllMarkerWazeMap(map);
      // }
      setWazerMarkers(getWazeMarker.data);
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
    }
  }

  setWazerMarkers(List<WazeMarker>? data) async {
    for (int i = 0; i < data!.length; i++) {
      print("marker ${data.length}");
      final http.Response response = await http.get(Uri.parse(SERVER_URL +
          "/uploads/wazeicon/thumbnail/" +
          data[i].iconImage.toString()));
      var customIcon = await resizeMarker(response.bodyBytes);
      final Marker marker = Marker(
        markerId: MarkerId(data[i].id.toString()),
        icon: customIcon,
        position: LatLng(data[i].cordinates![0].toDouble(),
            data[i].cordinates![1].toDouble()),
        infoWindow: InfoWindow(title: data[i].iconName),
        onTap: () {},
      );

      addReportMarker[MarkerId(data[i].id.toString())] = marker;

      markers[MarkerId(data[i].id.toString())] = marker;
      notifyListeners();
    }
  }

  _showMyDialog(String markerId, String iconName, String wazeId, int i,
      GetWazeMarker getWazeMarker) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("There is  $iconName reported"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Icon(
                Icons.thumb_up,
                color: PrimaryColor,
              ),
              onPressed: () {
                getWazeMarker.data![i].enablePop = true;
                notifyListeners();
                hitWazeMarkerAction(markerId, "yes", wazeId);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Icon(Icons.thumb_down_alt_rounded, color: PrimaryColor),
              onPressed: () {
                getWazeMarker.data![i].enablePop = true;
                notifyListeners();
                hitWazeMarkerAction(markerId, "no", wazeId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  hitWazeMarkerAction(String markerId, String value, wazeId) async {
    var getId = await getUserId();

    Map<String, dynamic> map = {
      'markerId': markerId,
      'createdby_id': getId,
      'isAskFlag': value,
      "wazeId": wazeId
    };

    print(map);
    try {
      responseModel = await hitWazeMarkerActionApi(map);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
    }
  }

  double calculateDist(
    double latitude,
    double longitude,
    double latitude2,
    double longitude2,
  ) {
    // var p = 0.017453292519943295;
    // var c = cos;
    // var a = 0.5 -
    //     c((latitude2 - latitude) * p) / 2 +
    //     c(latitude * p) *
    //         c(latitude2 * p) *
    //         (1 - c((longitude2 - longitude) * p)) /
    //         2;
    // return 12742 * asin(sqrt(a));
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((latitude2 - latitude) * p) / 2 +
        c(latitude * p) *
            c(latitude2 * p) *
            (1 - c((longitude2 - longitude) * p)) /
            2;
    return 12742 * asin(sqrt(a));
  }

  showAddWazeMarker(double latitude, double longitude) {
    var point;
    for (int i = 0; i < getWazeMarker.data!.length; i++) {
      point = calculateDist(
        latitude,
        longitude,
        getWazeMarker.data![i].cordinates![0].toDouble(),
        getWazeMarker.data![i].cordinates![1].toDouble(),
      );
      if (getWazeMarker.data![i].markerCategory == "Temporary" &&
          getWazeMarker.data![i].enablePop == false &&
          point < 2 &&
          getWazeMarker.data![i].firstTime == false) {
        _showMyDialog(
            getWazeMarker.data![i].markerId.toString(),
            getWazeMarker.data![i].iconName.toString(),
            getWazeMarker.data![i].id.toString(),
            i,
            getWazeMarker);
        getWazeMarker.data![i].firstTime = true;
        notifyListeners();
        break;
      } else {}
    }
    // }
  }

  @override
  void connectivity(bool connection) {
    // TODO: implement connectivity
    this.connection = connection;

    notifyListeners();
  }

  @override
  void errorMSG(data) {
    // TODO: implement errorMSG
    print('chat error $data');
  }

  _launchURL() async {
    String url = "https://mytruck.one/home-page";
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  @override
  void receiveMSG(value) {
    if (value["markerDeleted"] == true) {
      MarkerId _markerId = MarkerId(value["_id"]);

      markers.remove(_markerId);
      getMarkerWazeMap();
      notifyListeners();
      print(markers);
    }
  }

  void listenWaze(BuildContext context) {
    _connection = context.read<ChatSocketConnection>();
    _connection.enableWazetListener(this);
  }

  Future<void> animateMaker(CameraPosition pos) async {
    if (myTruckPosition == null) return;
    LatLng myPOS = LatLng(pos.target.latitude, pos.target.longitude);
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/arrow.png', 200);
    markers[MarkerId('me')] = Marker(
      anchor: Offset(.5, .5),
      markerId: MarkerId('me'),
      rotation: myTruckPosition!.heading,
      flat: true,
      icon: BitmapDescriptor.fromBytes(markerIcon),
      position: myPOS,
      infoWindow: InfoWindow(title: 'My Truck'),
    );
    notifyListeners();
  }
}
