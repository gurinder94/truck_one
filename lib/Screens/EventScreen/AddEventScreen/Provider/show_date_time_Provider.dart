import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/EventModel.dart';
import 'package:my_truck_dot_one/Model/TimezoneModel.dart';

class ShowTimeProvider extends ChangeNotifier {
  bool loading = true;

  late TimezoneModel _timezone;
  String? message;
  late TimezoneModel _timeZone;
  String? selectedTimezoneId;

  TimezoneModel get timeZone => _timeZone;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List? userdata;
  Map? data;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  TextEditingController selectStartdate = TextEditingController();
  TextEditingController selectEnddate = TextEditingController();
  TextEditingController selectEndTime = TextEditingController();
  TextEditingController selecteStartTime = TextEditingController();
  late TimeOfDay picked;

  TimeOfDay selectendTime = TimeOfDay(hour: 00, minute: 00);
  Datum? valueItemSelected;
  late String _hour, _minute, time, _showperiod;
  String? selectedname;

  startTime(
    BuildContext context,
  ) async {
    DateTime time = DateTime.now();
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: time.hour, minute: time.minute));
    if (picked != null) {
      DateTime sTime =
          DateTime(time.year, time.month, time.day, picked.hour, picked.minute);

      selecteStartTime.text = DateFormat("hh:mm aa").format(sTime);

      ///


    }

    // if (_minute.length == 1) {
    //   time = _hour + ':' + "0" + _minute;
    //
    //   selecteStartTime.text = time;
    //   selecteStartTime.text = time;
    //
    //   print(time);
    //
    //   selecteStartTime.text = time;
    // } else {
    //   time = _hour + ':' + _minute;
    //   selecteStartTime.text = time;
    //   print(time);
    //   selecteStartTime.text = time;
    //   print("hh");
    // }

    return CircularProgressIndicator();
  }

  endTime(
      BuildContext context,
      ) async {
    DateTime time = DateTime.now();
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: time.hour, minute: time.minute));
    if (picked != null) {
      DateTime eTime =
      DateTime(time.year, time.month, time.day, picked.hour, picked.minute);

      selectEndTime.text = DateFormat("hh:mm aa").format(eTime);

    }

    // if (_minute.length == 1) {
    //   time = _hour + ':' + "0" + _minute;
    //
    //   selecteStartTime.text = time;
    //   selecteStartTime.text = time;
    //
    //   print(time);
    //
    //   selecteStartTime.text = time;
    // } else {
    //   time = _hour + ':' + _minute;
    //   selecteStartTime.text = time;
    //   print(time);
    //   selecteStartTime.text = time;
    //   print("hh");
    // }

    return CircularProgressIndicator();
  }
  startDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));

  EndDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime.now(),
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

    selectStartdate.text = dateFormat.format(startDate);
    notifyListeners();
  }

  setEndDate(BuildContext context) async {
    final endDate = await EndDateTime(context);

    if (endDate != null && endDate != selectedEndDate) {
      selectedEndDate = endDate;
      notifyListeners();
    }

    this.endDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    selectEnddate.text = dateFormat.format(endDate);
    notifyListeners();
  }

  ResetModel() {
    selectStartdate.text = "";
    selectEnddate.text = "";
    selectEndTime.text = "";
    selecteStartTime.text = "";
    notifyListeners();
  }

  getTimeZome() async {
    Map<String, dynamic> map = {"isActive": "true", "isDeleted": "false"};
    print(map);
    loading = true;

    notifyListeners();
    print(map);
    try {
      _timeZone = await hitTimezoneApi(map);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  void setTimeZone(Datum newValue) {
    valueItemSelected = newValue;
    selectedTimezoneId = newValue.id.toString();
    notifyListeners();
  }

  changeDateTimeZone() {
    var dateFormat = DateFormat(
        "EEEE, MMM d  yyyy hh:mm a"); // you can change the format here
    var utcDate = dateFormat
        .format(DateTime.parse(selectStartdate.text)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate)); //
    print(createdDate);
    return createdDate;
  }

  TimeZomeApi(EventModel eventModel) async {
    Map<String, dynamic> map = {"isActive": "true", "isDeleted": "false"};
    print(map);
    loading = true;

    print(map);
    try {
      _timeZone = await hitTimezoneApi(map);
      showgetvalue(_timeZone, eventModel);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  void showgetvalue(TimezoneModel timeZone, EventModel eventModel) {
    for (int i = 0; i < timeZone.data!.length; i++) {
      if (eventModel.timezoneId == timeZone.data![i].id) {
        valueItemSelected = timeZone.data![i];
      }
    }
  }
}
