import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/error_message_Alert_box.dart';
import 'package:provider/provider.dart';

import '../../../ApiCall/api_Call.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/TripPlannerModel/RouteModel.dart';
import '../../../Model/TripPlannerModel/TruckListModel.dart';
import '../../../Model/TripPlannerModel/trip_history_model.dart';
import '../../Trip Planner/UserLiveMap/Component/weather_screen.dart';
import '../../Trip Planner/UserLiveMap/Provider/user_navigation_provider.dart';
import '../../Trip Planner/UserLiveMap/user_map_navigation.dart';

class AddTripProvider extends ChangeNotifier {
  bool getLoading = false;
  bool routeStart = false;
  var long, lat;
  TruckListModel? truckListModel;
  TextEditingController chooseSource = TextEditingController();
  var chooseDestination;

  TextEditingController choose1Destination = TextEditingController();
  TextEditingController startDate = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  TextEditingController endTime = TextEditingController(
      text:
          DateFormat('hh:mm a').format(DateTime.now().add(Duration(hours: 1))));
  TextEditingController grossWeight = TextEditingController(text: "40000");
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  ResponseModel responseModel = ResponseModel();
  RouteModel model = RouteModel();
  var truckId = "null";
  var truckName = "";
  var trailerName = "";
  var truckIndexValue = "";
  var trailerId = "null";
  var HazmatLoadValue = null;
  var HazmatIndex = "";
  var hazmatName = "";
  var truckWidth;
  var truckHeight;
  var trailerWidth;
  var trailerHeight;
  var trailerIndexValue = "";
  var routeFlag = "Arrive By";
  TimeOfDay selectstartTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 2)));
  DateTime selectedDate = DateTime.now();
  List<TruckModel> truckList = [];
  List<TruckModel> trailerList = [];
  List<TruckModel> selectTruckData = [];
  double sourceLongitude = 0.0;
  double sourceLatitude = 0.0;
  double DestinationLongitude = 0.0;
  double DestinationLatitude = 0.0;
  var tomWeight, tomWidth, tomheight;
  List<Datum> histryLocation = [];
  late TripHistoryModel historyModel;
  Map<PolylineId, Polyline> _polyline = <PolylineId, Polyline>{};

  // this will hold the generated polylines
  // Set<Polyline> _polylines = {};
// this will hold each polyline coordinate as Lat and Lng pairs
  // List<LatLng> polylineCoordinates = [];
// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  TextEditingController displayNewTextField = TextEditingController();

  Map<PolylineId, Polyline> get polyline => _polyline;
  Completer<GoogleMapController> _controller = Completer();
  List weatherName = [];

  Completer<GoogleMapController> get controller => _controller;
  List<LatLng> _turns = [];
  List<LatLng> weatherMarkers = [];

  List<LatLng> get turns => _turns;
  List<LatLng> _routePoints = [];
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};

  List<LatLng> get routePoints => _routePoints;

  Map<MarkerId, Marker> get markers => _markers;

  startDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: selectedDate,
        lastDate: DateTime(2100),
        firstDate: DateTime.now(),
      );

  setStartDate(BuildContext context) async {
    final startDate = await startDateTime(context);

    if (startDate != null && startDate != selectedDate) {
      selectedDate = startDate;
      notifyListeners();
    }

    this.startDate.text = dateFormat.format(startDate);
    notifyListeners();
  }

  startTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectstartTime,
    );
    selectstartTime = picked!;

    endTime.text = formatTimeOfDay(picked);
    notifyListeners();
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  hitGetTruck(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {"createdById": getId, "vehicleType": "TRUCK"};
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      truckList = [];
      truckListModel = await hitTruckApi(map);
      truckList.addAll(truckListModel!.data!);
      print(truckListModel!.totalCount);
      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  void setValueTruck(TruckModel truckList, int parse) {
    truckId = truckList.id!;
    truckIndexValue = parse.toString();
    truckName = truckList.name;
    truckWidth = truckList.width;
    truckHeight = truckList.height;
    notifyListeners();
  }

  hitGetTrailer(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    Map<String, dynamic> map = {"createdById": getId, "vehicleType": "TRAILER"};
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      trailerList = [];
      truckListModel = await hitTruckApi(map);
      trailerList.addAll(truckListModel!.data!);
      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  void setValueTrailer(TruckModel truckList, int parse) {
    trailerId = truckList.id.toString();

    trailerName = truckList.name.toString();
    trailerIndexValue = parse.toString();
    trailerHeight = truckList.height;
    trailerWidth = truckList.width;
    notifyListeners();
  }

  hitTripCreate() async {
    //

    //
    // var dateValue = new DateFormat("yyyy-MM-ddTHH:mm:ssZ")
    //     .parseUTC("${startDate.text}T${p}.000Z");
    getTruckDeatil();
    DateTime tempDate = new DateFormat("HH:mm").parse(endTime.text);
    var p = DateFormat.Hm().format(tempDate);
    print(p);

    var getId = await getUserId();
    Map<String, dynamic> map = {
      "constName": "NOOFTRIPS",
      "createdById": getId,
      "companyId": getId,
      "date_Time": "${startDate.text}T${p}:00.000Z",
      "destination": addAddressData,
      "grossWeight": grossWeight.text,
      "loadType": HazmatLoadValue,
      "planTitle": "GPS",
      "roleTitle": "ENDUSER",
      "routeFlag": routeFlag == "Depart at" ? "departAt" : "arriveBy",
      "source": {
        "location": {
          "coordinates": [sourceLatitude, sourceLongitude]
        },
        "address": chooseSource.text,
      },
      "trailerId": trailerId,
      "truckId": truckId,
    };

    routeStart = true;
    notifyListeners();
    print("hitTripCreate>  $map");

    try {
      responseModel = await hitTripCreateApi(map);
      getMarkerRouteList("${startDate.text}T${p}:20.000Z");
      notifyListeners();
    } on Exception catch (e) {
      showMessage(e.toString());
      print(e.toString());

      routeStart = false;

      notifyListeners();
    }
  }

  void setHazmatLoad(String loadType, String typeName, String index) {
    HazmatLoadValue = loadType;
    hazmatName = typeName;
    HazmatIndex = index;
    print(loadType);
    notifyListeners();
  }

  void setArrive(String value) {
    routeFlag = value;

    print(routeFlag);
    notifyListeners();
  }

  void setAddress(double longitude, double latitude) {
    sourceLatitude = latitude;
    sourceLongitude = longitude;
    print("826378${sourceLatitude},$sourceLongitude");
    notifyListeners();
  }

  void setDestinationAddress(longitude, latitude) {
    DestinationLatitude = latitude;
    DestinationLongitude = longitude;

    notifyListeners();
  }

  Future<void> getMarkerRouteList(String date) async {
    var datearrive =
        routeFlag == "Arrive By" ? "arriveAt=${date}" : "departAt=${date}";
    try {
      var destinationLatitude = "";

      addAddressData.forEach((element) {
        print("element>> ${element}");
        destinationLatitude +=
            "$destinationLatitude:${element['location']['coordinates'][0]},${element['location']['coordinates'][1]}";
      });
      print("destinationLatitude>> $destinationLatitude");
      model = await hitTomAPi(
          date,
          sourceLatitude,
          sourceLongitude,
          destinationLatitude,
          // DestinationLongitude,
          datearrive,
          tomWidth,
          tomWeight,
          tomheight,
          HazmatLoadValue);
      routeStart = false;

      notifyListeners();
      // getMarkerRouteList("${startDate.text}T${p}:20.000Z");
    } on Exception catch (e) {
      print(e.toString());
      if ("Exception: No Route Found" == e.toString()) {
        DialogUtilsError.ErrorMessageAlertBox(
            navigatorKey.currentState!.context,
            onDoneFunction: () {},
            oncancelFunction: () {},
            buttonTitle: "Okay",
            alertTitle: 'No Route Found ',
            title: "");
      } else {
        showMessage(e.toString());
      }

      routeStart = false;

      notifyListeners();
    }
  }

  getTruckDeatil() {
    if (truckWidth < trailerWidth!) {
      tomWidth = (trailerWidth! / 39.37).floor();
      notifyListeners();
    } else {
      tomWidth = (truckWidth! / 39.37).floor();
      notifyListeners();
    }

    if (truckHeight! < trailerHeight) {
      tomheight =
          (trailerList[int.parse(trailerIndexValue)].height! / 39.37).floor();

      notifyListeners();
    } else {
      tomheight = (trailerHeight / 39.37).floor();
      notifyListeners();
    }
    tomWeight = (int.parse(grossWeight.text) / 2.2046).floor();
    notifyListeners();
  }

  Polyline? mpolyline;

  Future<void> applyRoute() async {
    _markers.clear();
    _routePoints = [];
    weatherMarkers = [];

    final Uint8List midIcon = await getBytesFromAsset('assets/icons.png', 30);
    final Uint8List startIcon =
        await getBytesFromAsset('assets/start_flag.png', 100);
    final Uint8List endIcon =
        await getBytesFromAsset('assets/end_flag.png', 100);

    model.routes![0].legs?.forEach((element) {
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

    if (_routePoints.length > 0) {
      moveCamera(_routePoints[0]);
      var no = Random().nextInt(100);
      _markers[MarkerId('weather')] = Marker(
        markerId: MarkerId('weather$no'),
        icon: BitmapDescriptor.fromBytes(startIcon),
        position: LatLng(sourceLatitude, sourceLongitude),
        infoWindow: InfoWindow(title: 'weather'),
        onTap: () {
          // weatherplan == true
          //     ? weatherMarkerClick(MarkerId('weather$i'))
          //     : SizedBox();
        },
      );
      addAddressData.forEach((element) {
        print("element>> ${element}");
        // destinationLatitude +=
        // "$destinationLatitude:${element['location']['coordinates'][0]},${element['location']['coordinates'][1]}";
        no = Random().nextInt(100);
        _markers[MarkerId('weather$no')] = Marker(
          markerId: MarkerId('weather$no'),
          icon: BitmapDescriptor.fromBytes(midIcon),
          position: LatLng(element['location']['coordinates'][0],
              element['location']['coordinates'][1]),
          infoWindow: InfoWindow(title: 'weather'),
          onTap: () {
            // weatherplan == true
            //     ? weatherMarkerClick(MarkerId('weather$i'))
            //     : SizedBox();
          },
        );
      });

      notifyListeners();
    }
    // Future.forEach(model.routes!, (RoutePath routeData) async {

    //   //storeTurns(routeData.guidance!.instructions!);
    // }).then((x) async {
    //   // addWeatherMarker(_routePoints);
    //   //var no = Random().nextInt(100);
    //   // markers[MarkerId('start$no')] = Marker(
    //   //   markerId: MarkerId('start$no'),
    //   //   flat: true,
    //   //   icon: BitmapDescriptor.fromBytes(midIcon),
    //   //   position: LatLng(routePoints[0].latitude,
    //   //       routePoints[routePoints.length - 1].longitude),
    //   //   anchor: Offset(.5, .5),
    //   //   infoWindow: InfoWindow(title: 'Start'),
    //   //   onTap: () {},
    //   // );
    // });
    // if (_polyline.length > 1) {
    //   // setStartEndMarker(routePoints[0], routePoints[routePoints.length - 1]);
    // }
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
    final Uint8List midIcon = await getBytesFromAsset('assets/icons.png', 30);
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
    /*markers[MarkerId('mid')] = Marker(
      markerId: MarkerId('mid'),
      flat: true,
      icon: BitmapDescriptor.fromBytes(midIcon),
      position: end,
      anchor: Offset(.5, .5),
      infoWindow: InfoWindow(title: 'Mid'),
      onTap: () {},
    );*/
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

  Future<void> moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, tilt: 0, zoom: 5)));
  }

  void openNavigation(int index, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => UserNavigationProvider(),
                child: UserMapNavigation(_polyline, turns, model.routes![index],
                    markers, weatherMarkers, routePoints[0]))));
  }

  Future<void> addWeatherMarker(List<LatLng> routePoints) async {
    var weatherplan = await getWeatherPlanData();

    final Uint8List endIcon = await getBytesFromAsset('assets/weather.png', 70);
    int val = 0;

    for (int i = 0; i < routePoints.length; i++) {
      print(routePoints.length > 900 ? "helloo" : "hh");

      val = routePoints.length > 900 ? val + 1000 : val + 100;
      print(routePoints.length);
      // print("cxjkhjdsjhdsajh${routePoints}");
      // print("weather ${routePoints[val]}");
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
    notifyListeners();
  }

  void resetValue() {
    truckListModel;
    chooseSource.text = '';
    addAddressData.clear();
    startDate = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(DateTime.now()));
    endTime = TextEditingController(
        text: DateFormat('hh:mm a')
            .format(DateTime.now().add(Duration(hours: 1))));
    grossWeight = TextEditingController(text: "40000");
    truckId = "null";
    truckIndexValue = "";
    trailerId = "null";
    HazmatLoadValue = null;
    trailerIndexValue = "";
    routeFlag = "Arrive By";
    truckList = [];
    trailerList = [];
    selectTruckData = [];
    sourceLongitude = 0.0;
    sourceLatitude = 0.0;
    DestinationLongitude = 0.0;
    DestinationLatitude = 0.0;
    tomWeight;
    tomWidth;
    tomheight;
    hazmatName = "";
    polyline.clear();
    weatherName = [];
    _markers.clear();
    model.routes = null;
    truckName = "";
    trailerName = "";
    _turns = [];
    weatherMarkers = [];
    _routePoints = [];
  }

  void setvalue(String value) {
    chooseSource.text = value;
    polyline.clear();
    polyline.clear();
    weatherName = [];
    _markers.clear();
    model.routes = null;

    _turns = [];
    weatherMarkers = [];
    _routePoints = [];
    notifyListeners();
  }

  void setvalueDestinationTextEditer(String value) {
    chooseDestination.text = value;

    polyline.clear();
    polyline.clear();
    weatherName = [];
    _markers.clear();
    model.routes = null;

    _turns = [];
    weatherMarkers = [];
    _routePoints = [];
    notifyListeners();
  }

  void setvalueDestinationsTextEditer(String value) {
    choose1Destination.text = value;
    polyline.clear();
    polyline.clear();
    weatherName = [];
    _markers.clear();
    model.routes = null;

    _turns = [];
    weatherMarkers = [];
    _routePoints = [];
    notifyListeners();
  }

  setAddressChooseSource(String value) {
    chooseSource.text = value;
    notifyListeners();
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

          addTripProvider.setAddress(location.longitude, location.latitude);
          print(query);
          notifyListeners();
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      notifyListeners();
    }
  }

  void DestinationSearch(String query, BuildContext context,
      AddTripProvider addTripProvider) async {
    if (query.length > 8) {
      try {
        List locations = await locationFromAddress(query);
        locations.forEach((location) async {
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              location.latitude, location.longitude);
          /*  placeMarks.forEach((placeMark) {
              addPlace();
            });*/
          DestinationLatitude = location.latitude;
          DestinationLongitude = location.longitude;
          chooseDestination = query;
          setAddressesDestination({
            "location": {
              "coordinates": [DestinationLatitude, DestinationLongitude]
            },
            "address": query,
          });
          notifyListeners();
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      notifyListeners();
    }
  }

  void setAddressDestination(String value) {
    chooseDestination.text = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> addAddressData = [];

  void setAddressesDestination(value) {
    addAddressData.add(value);
    print(addAddressData);
    notifyListeners();
  }

  List<String> destinationAdd = [];

  setResetRoute() {
    polyline.clear();
    polyline.clear();
    weatherName = [];
    _markers.clear();
    model.routes = null;
    _turns = [];
    weatherMarkers = [];
    _routePoints = [];
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
      setDefautFeeltManager(histryLocation);
      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  setDefaultValueTruck(String id, String truckName, var width, var height) {
    truckId = id.toString();
    this.truckName = truckName;
    notifyListeners();
    truckWidth = width;
    truckHeight = height;

    // trailerIndexValue = parse.toString();
  }

  setDefaultValueTrailer(String id, String trailerName, var width, var height) {
    trailerId = id.toString();
    this.trailerName = trailerName;
    trailerWidth = width;
    trailerHeight = height;
    notifyListeners();
  }

  void weatherMarkerClick(MarkerId markerId) {
    showModalBottomSheet(
        context: navigatorKey.currentState!.context,
        builder: (context) => WeatherScreen(pos: markers[markerId]!.position));
  }

  setDefautFeeltManager(List<Datum> histryLocation) {
    if (histryLocation.length != 0) {
      setDefaultValueTruck(
          histryLocation[0].truckData!.id!,
          histryLocation[0].truckData!.name!,
          histryLocation[0].truckData!.width!,
          histryLocation[0].truckData!.height!);
      setDefaultValueTrailer(
          histryLocation[0].trailerData!.id!,
          histryLocation[0].trailerData!.name!,
          histryLocation[0].trailerData!.width!,
          histryLocation[0].truckData!.height!);
    }
    notifyListeners();
  }
}
