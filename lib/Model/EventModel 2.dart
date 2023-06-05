import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'EventListModel.dart';
import 'NetworkModel/normal_response.dart';

class EventModel extends ChangeNotifier {
  String? id;
  String? name;
  String? venue;
  String? speaker;
  DateTime? endDate;
  String? address;
  String? eventMode;
  Broadcast? broadcast;
  String? visibility;
  String? timezoneId;
  String? description;
  String? bannerImage;
  String? createdById;
  bool? isActive;
  bool? isDeleted;
  bool? isfavourite;
  bool? isInterested;
  int? noOfAttendee = 0;
  DateTime? startDate;
  String? eventTime = "timer";
  String? brandLogo;
  var page;
  var eventFee;
  var days, seconds, hour, min;
  bool eventListLoad = false;
  bool? isBooked;

  bool InterestedLoading = true;
  String? createdBy;
  EventListModel? eventListModel;
  String? startTime;
  String? currency;
  String? eventId;

  EventModel({
    this.id,
    this.name,
    this.venue,
    this.speaker,
    this.endDate,
    this.address,
    this.eventMode,
    this.broadcast,
    this.visibility,
    this.timezoneId,
    this.description,
    this.bannerImage,
    this.createdById,
    this.isActive,
    this.isDeleted,
    this.isfavourite,
    this.isInterested,
    this.noOfAttendee,
    this.brandLogo,
    this.startDate,
    this.eventFee,
    this.page,
    this.isBooked,
    this.createdBy,
    this.currency,
    this.eventId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
      id: json["_id"],
      name: json["name"],
      venue: json["venue"],
      speaker: json["speaker"],
      endDate: DateTime.parse(json["endDate"]),
      address: json["address"],
      eventMode: json["eventMode"],
      broadcast: json["broadcast"] == null
          ? null
          : Broadcast.fromJson(json["broadcast"]),
      visibility: json["visibility"],
      timezoneId: json["timezoneId"],
      description: json["description"],
      bannerImage: json["bannerImage"],
      createdById: json["createdById"],
      isActive: json["isActive"],
      isDeleted: json["isDeleted"],
      isfavourite: json["isfavourite"],
      isInterested: json["isInterested"],
      noOfAttendee: json["noOfAttendee"],
      startDate: DateTime.parse(json["startDate"]),
      brandLogo: json["brandLogo"],
      eventFee: json["eventFee"],
      page: json["page"],
      isBooked: json["isBooked"],
      createdBy: json["createdBy"],
      currency: json["currency"],
      eventId: json["eventId"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "venue": venue,
        "speaker": speaker,
        "endDate": endDate!.toIso8601String(),
        "address": address,
        "eventMode": eventMode,
        "broadcast": broadcast!.toJson(),
        "visibility": visibility,
        "timezoneId": timezoneId,
        "description": description,
        "bannerImage": bannerImage,
        "createdById": createdById,
        "isActive": isActive,
        "isDeleted": isDeleted,
        "isfavourite": isfavourite,
        "isInterested": isInterested,
        "noOfAttendee": noOfAttendee,
        "startDate": startDate!.toIso8601String(),
        "brandLogo": brandLogo,
        "eventFee": eventFee,
        "page": Page,
        "isBooked": isBooked,
        "createdBy": createdBy,
        "currency": currency,
        "eventId": eventId
      };

  getTime() {
    DateTime now = DateTime.now();
    if (startDate!.compareTo(now) > 0)
      eventTime = getTimeDifference(startDate!, now);
    else if (endDate!.compareTo(now) > 0)
      eventTime = 'On-going';
    else if (endDate!.compareTo(now) < 0) eventTime = 'EXPIRED';
    Timer _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      notifyListeners();
    });
  }

  getTimeDifference(DateTime startDate, DateTime now) {
    days = startDate.difference(now).inDays;
    var mill = startDate.difference(now).inMilliseconds;

    seconds = (mill / 1000 % 60).floor();
    hour = ((((mill / 1000) / 60) / 60) % 24).floor();
    min = ((mill % (1000 * 60 * 60)) / (1000 * 60)).floor();

    return 'Days' +
        '  ' +
        days.toString() +
        ' ' +
        ':' +
        hour.toString() +
        ' ' +
        ':' +
        min.toString() +
        ' ' +
        ':' +
        ' ' +
        seconds.toString() +
        ' ' +
        ' ';
  }

  void removeFavourite(
      String id, bool value, String userid, BuildContext context) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);
    try {
      var res = await hitRemoveFavouriteApi(map);
      showMessage(
        res,
      );
      isfavourite = value;

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      // showMessage(message, context);

      print(e.toString());
      notifyListeners();
    }
  }

  void addFavourite(
      String id, bool value, String userid, BuildContext context) async {
    var getid = await getUserId();
    print(false);
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);
    try {
      var res = await addFavouriteApi(map);
      showMessage(
        res,
      );
      isfavourite = value;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );

      print(e.toString());
      notifyListeners();
    }
  }

  void addInterested(
      String id, bool value, String userid, BuildContext context) async {
    var getid = await getUserId();
    InterestedLoading = true;
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);

    try {
      ResponseModel _res = await hitAddInterestedApi(map);
      isInterested = value;
      InterestedLoading = false;
      _res.message == "This event is already in your Interest list"
          ? SizedBox()
          : noOfAttendee = (noOfAttendee! + 1);
      showMessage(
        _res.message,
      );
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );

      print(e.toString());
      notifyListeners();
    }
  }

  void removeInterested(
      String id, bool value, String userid, BuildContext context) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "eventId": id,
      'userId': getid,
    };
    print(map);
    InterestedLoading = true;
    try {
      var res = await hitRemoveInterestedApi(map);
      isInterested = value;
      print(noOfAttendee);

      showMessage(res);
      if (noOfAttendee == 0)
        noOfAttendee = 0;
      else
        noOfAttendee = (noOfAttendee! - 1);
      InterestedLoading = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      print(e.toString());
      notifyListeners();
    }
  }

  void addBookEvent(String? id, String? getid, BuildContext context) async {
    var getid = await getUserId();
    var userName = await getNameInfo();
    var userImage = await getprofileInfo();
    Map<String, dynamic> map = {
      'userId': getid,
      'eventId': id,
      'userName': userName,
      'userImage': userImage,
    };
    try {
      var res = await hitAddEventBookNowApi(map);
      isBooked = true;
      showMessage(
        res,
      );
      notifyListeners();
      print(map);
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(message);

      print(e.toString());
      notifyListeners();
    }
  }

  changeDateTimeZone(String date) {
    var dateFormat =
        DateFormat("EEEE, MMM d  yyyy"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(date)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate)); //

    return createdDate;
  }

  changeTimeZone(String date) {
    var dateFormat = DateFormat("hh:mm aa"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(date)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate)); //

    return createdDate;
  }

// hitEventsFavoutite(BuildContext context, value, userId, int page) async      {
//   Map<String, dynamic> map = {
//     'userId': userId,
//     'page': page.toString(),
//     'isFavourite':"true",
//   };
//   print(map);
//   eventListLoad = true;
//   notifyListeners();
//   print(map);
//   try {
//     eventListModel = await hitEventFavouriteApi(map);
//
//     eventListLoad = false;
//     var message = eventListModel!.message.toString();
//     showMessage(message, context);
//
//     notifyListeners();
//   } on Exception catch (e) {
//     eventListLoad = false;
//     var message = e.toString().replaceAll('Exception:', '');
//
//     showMessage(message, context);
//
//     print(e.toString());
//     notifyListeners();
//   }
// }
}

class Broadcast {
  Broadcast({
    this.link,
    this.isChecked,
  });

  String? link;
  bool? isChecked;

  static Broadcast fromJson(Map<String, dynamic> json) => Broadcast(
        link: json["link"],
        isChecked: json["isChecked"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "isChecked": isChecked,
      };
}
