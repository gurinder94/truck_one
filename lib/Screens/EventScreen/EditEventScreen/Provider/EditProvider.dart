import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/EventList.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';

import 'package:provider/provider.dart';

import '../../AddEventScreen/Provider/show_date_time_Provider.dart';

class EditEventProvider extends ChangeNotifier {
  bool? location;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController speakersController = TextEditingController();
  TextEditingController visibilityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController venueController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController broadcastController = TextEditingController();
  TextEditingController startdateController = TextEditingController();
  TextEditingController enddateController = TextEditingController();
  TextEditingController eventFeeController = TextEditingController();

  String? startTime;
  String? endTime;
  String? startDate;
  String? enddate;
  String? getid;
  bool _loading = false;
  String? message = " ";
  bool? checkbox = false;
  var getStartDate, getEndDate, getStartTime, getEndTime;
  var finalStartDate, finalEndDate;

  get loading => _loading;
  String? timeZoneId;
  var broadcast;
  double? Longitude;
  double? Latitude;
  String? visibility;
  EventListModel? eventListModel;
  EventModel eventModel = EventModel();
  bool imageLoad = false;
  var Currreny;
  bool bannerLoad = false;
  String? imageReal;
  var imageFile;

  String? type;
  String? imagebackground;
  String? imageLogo;
  String? imageUrl;
  var valueSelected;
  String? eventId;
  List<String> items2 = [
    "Unarchived",
    "Archived",
  ];

  EditEventProvider(this.eventId) {}

  hitUserEventView(String eventId) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      'userId': getid,
      'eventId': this.eventId,
    };
    _loading = true;
    notifyListeners();

    try {
      print(loading);

      eventModel = await hitEventViewIdApi(map);
      setValue(eventModel);
      _loading = false;

      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);

      print(e.toString());
      notifyListeners();
    }
  }

  hitEventUpdate(BuildContext context, String? id) async {


    if (getStartDate == 0) {
      var S = '${startDate}T$startTime.000000Z';
      var E = '${enddate}T$endTime.000000Z';


      finalStartDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(S);

      finalEndDate = new DateFormat("yyyy-MM-dd'T'HH:mm:aa.SSS'Z'").parse(E);
    }
   else {
      finalStartDate = new DateFormat("yyyy-MM-ddT hh:mm aa:ssZ")
          .parseUTC("${startDate}T$startTime:00.000Z");
      finalEndDate = new DateFormat("yyyy-MM-dd T hh:mm aa:ssZ").parseUTC("${enddate}T$endTime:00.000Z");;

    }

    broadcast = broadcastController.text;
    location = checkbox;
    getid = await getUserId();
    var companyId = await getCompanyId();
    Map<String, dynamic> map = {
      '_id': getid,
      'eventId': id,
      'createdBy': getid,
      'address': addressController.text,
      'bannerImage': imagebackground,
      'brandLogo': imageLogo,
      'speaker': speakersController.text,
      'startDate': finalStartDate,
      'endDate':  finalEndDate,
      'description': descriptionController.text,
      'visibility': visibilityController.text,
      'venue': venueController.text,
      'name': nameController.text,
      'broadcast': {'link': broadcast, 'isChecked': location},
      'eventMode': location == true ? "online" : "offline",
      'timezoneId': timeZoneId.toString(),
      'eventFee': eventFeeController.text,
      'lng': Longitude.toString(),
      'lat': Latitude.toString(),
      "currency": Currreny.toString(),
      "isDeleted": valueSelected == "Unarchived" ? "false" : "true",
      "companyId":companyId==""?getid:companyId
    };
    _loading = true;
    notifyListeners();
    print(map);
    try {
      ResponseModel res = await hitEventUpdateApi(map);
      _loading = false;
      var message = res.message.toString();

      showMessage(message);
      notifyListeners();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(providers: [
                    ChangeNotifierProvider(
                        create: (_) => UserEventTabBarProvider()),
                  ], child: EventList())));
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
    _loading = false;
  }

  getTime(
    getStartTime,
    getEndTime,
  ) {
    this.startTime = getStartTime;
    this.endTime = getEndTime;
    print(startTime);
    print(endTime);
    notifyListeners();
  }

  getDate(getStartDate, getEndDate) {
    this.startDate = getStartDate;
    this.enddate = getEndDate;

    print(getStartDate);
    print(getEndDate);
    notifyListeners();
  }

  getTimeZone(var timeZomeId) {
    print(timeZomeId);
    this.timeZoneId = timeZomeId;

    print(timeZoneId);
    startdateController.text = startDate.toString() +
        ':' +
        enddate.toString() +
        ':' +
        startTime.toString() +
        ':' +
        endTime.toString();
  }

  void setArchivedItem(String s) {
    print(s);
    valueSelected = s;
    notifyListeners();
  }

  getLocation(var location) {
    this.location = location;
    print("hello");
    print(location);
  }

  getAddress(var Long, var Lat) {
    this.Longitude = Long;
    this.Latitude = Lat;

    print(Long);
    print(Lat);
  }

  Future<void> getId() async {
    getid = await getUserId();
  }

  getFromGallery(String type, BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // setState(() {
      imageFile = File(pickedFile.path);

      if (type == "BANNERIMAGE") {
        cropImage(pickedFile, type, context);
        // imageUpload(imageFile, type,context);
      } else {
        cropImage(pickedFile, type, context);
        // imageUpload(imageFile, type,context);
      }
      notifyListeners();
      // });
    }
  }

  cropImage(pickedFile, String type, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: type == "BANNERIMAGE"
          ? CropAspectRatio(ratioX: 11.0, ratioY: 4.0)
          : CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle: type == "BANNERIMAGE" ? CropStyle.rectangle : CropStyle.circle,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: PrimaryColor,
          toolbarWidgetColor: Colors.white,

          // initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile != null) {
      File file = File(croppedFile.path);
      imageUpload(file, type, context);
    }
  }

  imageUpload(File image, String type, BuildContext context) async {
    bannerLoad = false;
    imageLoad = false;
    type == "BANNERIMAGE" ? bannerLoad = true : imageLoad = true;
    var url = SERVER_URL + '/api/v1/event/uploads';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      image.readAsBytes().asStream(),
      image.lengthSync(),
      filename: image.path.split('/').last,
      contentType: new MediaType('image', 'jpeg'),
    ));
    request.fields.addAll({"type": '$type', "height": "300", "width": "300"});
    print("request: " + request.toString());
    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);
      print('image $value');

      if (jsonData['data'] == null) {
      } else {
        var imageReal = jsonData['data']['imagePath'];

        // setState(
        //       () =>
        imageUrl =
            SERVER_URL + '/api/v1/event/uploads/profile/thumbnail/' + imageReal;
        // );
        if (type == "BANNERIMAGE") {
          // setState(() {
          imagebackground = imageReal;
          showMessage(jsonData['message']);
          print(imagebackground);
          notifyListeners();
          // });
        } else {
          // setState(() {

          imageLogo = imageReal;

          print(imageLogo);
          showMessage(jsonData['message']);
          // });
          notifyListeners();
        }
      }
    }
    bannerLoad = false;
    imageLoad = false;
    notifyListeners();
  }

  setValue(EventModel eventModel) {
    var event = eventModel;

    nameController = TextEditingController(text: event.name);

    speakersController = TextEditingController(text: event.speaker);
    addressController = TextEditingController(text: event.address);
    venueController = TextEditingController(text: event.venue);
    broadcastController = TextEditingController(text: event.broadcast!.link);
    visibilityController = TextEditingController(text: event.visibility);

    startDate = DateFormat('yyyy-MM-dd').format(eventModel.startDate!);
    startTime = DateFormat('hh:mm aa').format(event.startDate!);
    enddate = DateFormat('yyyy-MM-dd').format(event.endDate!);
    endTime = DateFormat('hh:mm aa').format(event.endDate!);
    startdateController.text = startDate.toString() +
        ":" +
        " " +
        enddate.toString() +
        ":" +
        " " +
        startTime.toString() +
        ":" +
        " :" +
        endTime.toString();
    eventFeeController = TextEditingController(text: event.eventFee.toString());
    var _showTimeProvider = Provider.of<ShowTimeProvider>(
        navigatorKey.currentState!.context,
        listen: false);
    _showTimeProvider.selectStartdate.text = formatterDate(event.startDate);
    _showTimeProvider.selectEnddate.text = formatterDate(event.endDate);
    _showTimeProvider.selecteStartTime.text = formatterTime(event.startDate);
    _showTimeProvider.selectEndTime.text = formatterTime(event.endDate);
    if (eventModel.eventMode == "online") {
      checkbox = true;
    } else {
      checkbox = false;
    }
    visibility = eventModel.visibility;
    timeZoneId = eventModel.timezoneId;
    valueSelected = eventModel.isDeleted == true ? 'Archived' : "Unarchived";

    var pp = removeTag(event.description.toString());

    descriptionController = TextEditingController(text: pp.toString());
    Currreny = event.currency.toString();
  }

  void setVisibility(String value) {
    visibility = value;
    visibilityController.text = value;
    notifyListeners();
  }

  void setcheckbox(bool? value) {
    checkbox = value;
    notifyListeners();
  }
}
// find  the follwoing attached apk build  which can see you  app
