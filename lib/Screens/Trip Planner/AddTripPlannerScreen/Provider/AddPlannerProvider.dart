import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/DriverDetailListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/DriverModelList.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/OtherDriverListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TrailerListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckDetailListModel.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckListModel.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Trip.dart';

class AddTripPlannerProvider extends ChangeNotifier {
  DriverListModel? driverListModel;
  OtherDriverListModel? otherDriverListModel;
  TruckListModel? truckListModel;
  TrailerListModel? trailerListModel;
  DriverDetailListModel? driverDetailListModel;
  DriverDetailListModel? otherDriverDetailListModel;
  TruckDetailListModel? truckDetailModel;
  TruckDetailListModel? trailerDetailModel;
  TextEditingController selecteStartTime = TextEditingController();
  TextEditingController selecteStartDate = TextEditingController();
  TextEditingController sourceAddress = TextEditingController();
  TextEditingController desinationAddress = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 2));
  DateTime startDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  double? sourceLongitude, sourceLatitude;
  double? destinationLongitude, destinationLatitude;
  var messsage;
  List<String> _items = [
    "Male",
    "Female",
    "Other",
  ];

  List<String> Alternate = ['0', '1', '2', '3', '4', '5'];

  List<String> Arrived = [
    "arriveBy",
    "departAt",
  ];

  List<String> get items => _items;
  String? ValueSelectDriver;
  String? ValueOtherSelectDriver;
  String? valueTruckName;
  String? valueTrailerName;
  int? pass;
  String? valueAlternateRoute;
  TimeOfDay selectstartTime = TimeOfDay(
    hour: 00,
    minute: 00,
  );
  bool isLoading = false, getLoading = false;
  late String _hour, _minute, time, _showperiod;
  var ValueArrive = "arriveBy";

  void setSelectedDriver(String s) {
    ValueSelectDriver = s;
    hitGetDriverDetail(ValueSelectDriver);
    hitGetOtherDriver();
    notifyListeners();
  }

  void setSelectedOtherDriver(String s) {
    ValueOtherSelectDriver = s;
    hitGetOtherDriverDetail();
    notifyListeners();
  }

  void setTruckName(String truckName) {
    valueTruckName = truckName;

    print(valueTruckName);
    hitGettruckDriverDetail();
    notifyListeners();
  }

  void setAlternateRoute(String alternate) {
    valueAlternateRoute = alternate;
    notifyListeners();
  }

  void setTrailerName(String trailerName) {
    valueTrailerName = trailerName;

    notifyListeners();
    hitGetTrailerDriverDetail();
  }

  void setArriv(String s) {
    ValueArrive = s;
    notifyListeners();
  }

  hitUserGetJobList(
    BuildContext context,
  ) async {
    var getId = await getUserId();

    Map<String, dynamic> map = {
      'userId': getId,
    };
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      driverListModel = await hitgetDriverApi(map);
      getLoading = false;
      hitGetOtherDriver();
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetOtherDriver() async {
    var getId = await getUserId();

    Map<String, dynamic> map = {
      'userId': getId,
      'selectedDriverId': ValueSelectDriver
    };
    isLoading = true;
    notifyListeners();
    print(map);
    try {
      otherDriverListModel = await hitgetOtherDriverApi(map);

      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetTruck(
    BuildContext context,
  ) async {
    Map<String, dynamic> map = {
      'isActive': "true",
      'isDeleted': "false",
      'vehicleType': "Truck"
    };
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      truckListModel = await hitGetTruckApi(map);

      print(truckListModel!.totalCount);
      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetTrailer(
    BuildContext context,
  ) async {
    Map<String, dynamic> map = {
      'isActive': "true",
      'isDeleted': "false",
      'vehicleType': "TRAILER"
    };
    getLoading = true;
    notifyListeners();
    print(map);
    try {
      trailerListModel = await hitGetTrailerApi(map);

      getLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetDriverDetail(String? valueDriver) async {
    Map<String, dynamic> map = {
      'endUserId': valueDriver,
    };
    isLoading = true;
    notifyListeners();
    print(map);
    try {
      driverDetailListModel = await hitGetDriverDeatilApi(map);

      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetOtherDriverDetail() async {
    Map<String, dynamic> map = {
      'endUserId': ValueOtherSelectDriver,
    };
    isLoading = true;
    notifyListeners();
    print(map);
    try {
      otherDriverDetailListModel = await hitGetDriverDeatilApi(map);

      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGettruckDriverDetail() async {
    Map<String, dynamic> map = {
      '_id': valueTruckName,
    };
    isLoading = true;
    notifyListeners();
    print(map);
    try {
      truckDetailModel = await hitGetTruckDeatilApi(map);

      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  hitGetTrailerDriverDetail() async {
    Map<String, dynamic> map = {
      '_id': valueTrailerName,
    };
    isLoading = true;
    notifyListeners();
    print(map);
    try {
      trailerDetailModel = await hitGetTruckDeatilApi(map);

      isLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      notifyListeners();
    }
  }

  startDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime(2100));

  setStartDate(BuildContext context) async {
    final startDate = await startDateTime(context);
    print(startDate);
    if (startDate != null && startDate != selectedDate) {
      selectedDate = startDate;
      notifyListeners();
    }
    print(selectedDate);

    this.startDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    print(startDate);
    selecteStartDate.text = dateFormat.format(startDate);
    notifyListeners();
  }

  startTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) selectstartTime = picked;
    _hour = selectstartTime.hour.toString();

    _minute = selectstartTime.minute.toString();
    _showperiod = selectstartTime.period.toString().substring(10);

    if (_minute.length == 1) {
      time = _hour + ':' + "0" + _minute;

      selecteStartTime.text = time;
      selecteStartTime.text = time;

      print(time);

      selecteStartTime.text = time;
    } else {
      time = _hour + ':' + _minute;
      selecteStartTime.text = time;
      print(time);
      selecteStartTime.text = time;
      print("hh");
    }

    return CircularProgressIndicator();
  }



  hitCreateTripPlanner(BuildContext context) async {
    print(ValueOtherSelectDriver);
    var getId = await getUserId();
    var dateValue = new DateFormat("yyyy-MM-ddTHH:mm:ssZ")
        .parseUTC("${selecteStartDate.text}T${selecteStartTime.text}:00.000Z");

    int a = int.parse(valueAlternateRoute!);

    if (ValueOtherSelectDriver == null) {
      Map<String, dynamic> map = {
        'alternateRoots': a,
        'createdById': getId,
        'date_Time': dateValue.toString(),
        'destination': {
          'location': {
            'coordinates': LatLng(destinationLatitude!.toDouble(),
                destinationLongitude!.toDouble())
          },
          "address": desinationAddress.text
        },
        'source': {
          'location': {
            'coordinates':
                LatLng(sourceLatitude!.toDouble(), sourceLongitude!.toDouble())
          },
          "address": sourceAddress.text
        },
        'truckId': valueTruckName,
        'driverId': ValueSelectDriver,
        'routeFlag': ValueArrive,
        "hoursOfServices": false,
        'trailerId': valueTrailerName,
      };
      print(map);
      isLoading = true;
      notifyListeners();
      print(map);
      try {
        var res = await hitCreateTripPlannerAPi(map);
        isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Company',4)),
                (Route<dynamic> route) => false);

        messsage = res['message'];
        showMessage(
          messsage,
        );
        notifyListeners();
      } on Exception catch (e) {
        print(e.toString());
        showMessage(
          messsage,
        );
        notifyListeners();
      }
    } else {
      Map<String, dynamic> map = {
        'alternateRoots': a,
        'createdById': getId,
        'date_Time': dateValue.toString(),
        'destination': {
          'location': {
            'coordinates': LatLng(destinationLatitude!.toDouble(),
                destinationLongitude!.toDouble())
          },
          "address": desinationAddress.text
        },
        'source': {
          'location': {
            'coordinates':
                LatLng(sourceLatitude!.toDouble(), sourceLongitude!.toDouble())
          },
          "address": sourceAddress.text
        },
        'truckId': valueTruckName,
        'driverId': ValueSelectDriver,
        'routeFlag': ValueArrive,
        "hoursOfServices": false,
        'trailerId': valueTrailerName,
        'anotherDriverId': ValueOtherSelectDriver,
      };
      print(map);
      isLoading = true;
      notifyListeners();
      print(map);
      try {
        var res = await hitCreateTripPlannerAPi(map);
        isLoading = false;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TripPlanner()));
        messsage = res['message'];
        showMessage(messsage);
        notifyListeners();
      } on Exception catch (e) {
        print(e.toString());
        showMessage(messsage);
        notifyListeners();
      }
    }
  }
}
