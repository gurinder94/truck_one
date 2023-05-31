import 'dart:convert';
import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventListModel.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/EventList.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AddEventProvider extends ChangeNotifier {
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

  get loading => _loading;
  String? timeZoneId;
  var broadcast;
  double? Longitude;
  double? Latitude;
  String? visibility;
  EventListModel? eventListModel;
  EventModel eventModel = EventModel();
  bool imageLoad = false;
  bool bannerLoad = false;
  String? imageReal;
  var imageFile;

  String? type;
  String? imagebackground;
  String? imageLogo;
  String? imageUrl;
  List<AutocompletePrediction> predictions = [];

  hitAddEvent(BuildContext context, String currreny) async {
    getid = await getUserId();
    var companyId = await getCompanyId();
    var roleName = await getRoleInfo();
    print(imagebackground);

    getId();

    var dateValue = new DateFormat("yyyy-MM-ddThh:mm aa:ssZ")
        .parseUTC("${startDate}T$startTime:00.000Z");
    var endDate = new DateFormat("yyyy-MM-ddThh:mm aa:ssZ")
        .parseUTC("${enddate}T$endTime:00.000Z");

    broadcast = broadcastController.text;

    Map<String, dynamic> map = {};
    roleName.toString().toUpperCase() == "COMPANY"
        ? map = {
            'createdById': getid,
            'companyId': getid,
            'address': addressController.text,
            'bannerImage': imagebackground == null ? null : imagebackground,
            'brandLogo': imageLogo == null ? null : imageLogo,
            'speaker': speakersController.text,
            'startDate': dateValue.toString(),
            'endDate': endDate.toString(),
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
            "currency": currreny.toString(),
            "constName": "NOOFEVENTS",
            "planTitle": "EVENT",
            "roleTitle": roleName.toString().toUpperCase(),
            "userId": getid
          }
        : map = {
            'createdById': getid,
            'companyId': companyId,
            'address': addressController.text,
            'bannerImage': imagebackground == null ? null : imagebackground,
            'brandLogo': imageLogo == null ? null : imageLogo,
            'speaker': speakersController.text,
            'startDate': dateValue.toString(),
            'endDate': endDate.toString(),
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
            "currency": currreny.toString(),
            "constName": "NOOFEVENTS",
            "planTitle": "EVENT",
            "roleTitle": roleName.toString().toUpperCase(),
            "userId": getid
          };
    _loading = true;
    notifyListeners();
    print(map);

    try {
      var res = await hitAddEventApi(map);

      message = res['message'];
      showMessage(message!);
      notifyListeners();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MultiProvider(providers: [
                    ChangeNotifierProvider(
                        create: (_) => UserEventTabBarProvider()),
                  ], child: EventList())));
      ResetModel(context);
      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;

      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
    _loading = false;
    notifyListeners();
  }

  _launchURL() async {
    String url = "http://74.208.25.43:3001/pages/pricing-page";
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  getTime(var starttime, var endtime) {
    this.startTime = starttime;
    this.endTime = endtime;
    print(startTime);
    print(endTime);
    notifyListeners();
  }

  getDate(var startDate, var endDate) {
    this.startDate = startDate;
    this.enddate = endDate;

    print(startDate);
    print(endDate);
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

  getLocation(var location) {
    this.location = location;
    if (location == true) {
      addressController.text = "";
      venueController.text = "";
    } else {
      broadcastController.text = "";
    }
  }

  getAddress(var Long, var Lat) {
    this.Longitude = Long;
    this.Latitude = Lat;

    print(Long);
    print(Lat);
  }

  Future<void> getId() async {}

  getFromGallery(String type, BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // setState(() {
      imageFile = File(pickedFile.path);

      if (type == "BRANDLOGO") {
        cropImage(pickedFile, type, false, context);
        // imageUpload(imageFile, type, false, context);
      } else {
        cropImage(pickedFile, type, true, context);
        // imageUpload(imageFile, type, true, context);
      }
      notifyListeners();
      // });
    }
  }

  cropImage(PickedFile pickedFile, String type, bool value,
      BuildContext context) async {
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
        )
      ],
    );

    if (croppedFile != null) {
      File file = File(croppedFile.path);
      imageUpload(file, type, value, context);
    }
  }

  imageUpload(File image, String type, bool value, BuildContext context) async {
    imageLoad = value;

    bannerLoad = false;
    imageLoad = false;
    type == "BANNERIMAGE" ? bannerLoad = true : imageLoad = true;
    print(type == "BANNERIMAGE" ? bannerLoad = true : imageLoad = true);
    notifyListeners();
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
          imagebackground = imageReal;
          print(imagebackground);
          showMessage(jsonData['message']);
          notifyListeners();
        } else {
          imageLogo = imageReal;
          print(imageLogo);
          showMessage(
            jsonData['message'],
          );
          notifyListeners();
        }
      }
    }
    bannerLoad = false;
    imageLoad = false;
    notifyListeners();
  }

  ResetModel(BuildContext context) {
    nameController.text = " ";
    descriptionController.text = "";
    speakersController.text = "";
    visibilityController.text = "";
    addressController.text = "";
    venueController.text = "";
    locationController.text = "";
    broadcastController.text = "";
    startdateController.text = "";
    enddateController.text = "";
    eventFeeController.text = "";
    startTime = " ";
    endTime = "";
    startDate = "";
    enddate = "";
  }

  static const country = 'country';

  Future<void> autoCompleteSearch(String value) async {
    print(value);
    var googlePlace = GooglePlace("AIzaSyC0y2S4-iE2rHkYdyAsglz_qirv0UtpF1s");

    var risult = await googlePlace.autocomplete.get(value, components: [
      Component(country, 'US'),
      Component(country, 'MEX'),
      Component(country, 'CAN')
    ]);

    if (risult != null && risult.predictions != null) {
      predictions = risult.predictions!;

      notifyListeners();
    } else {
      print("kjgsdekg");
      print(predictions.length);
    }
  }

  Future handleSearch(var query) async {
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
          getAddress(Longitude, Latitude);

          notifyListeners();
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {
      addressController.text = "";
      notifyListeners();
    }
  }
}
