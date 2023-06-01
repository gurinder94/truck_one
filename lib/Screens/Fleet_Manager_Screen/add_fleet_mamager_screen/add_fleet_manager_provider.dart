import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/BrandListModel.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/VINModel.dart';

class AddFleetManagerProvider extends ChangeNotifier {
  bool loading = false, loder = false, imageloder = false, vinLoad = false;
  var message = "";
  final ImagePicker _picker = ImagePicker();
  List<Datum> brandList = [];
  BrandListModel? brandListModel;
  ResponseModel? _responseModel;
  VinModel? vinModel;
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController vin = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController modelNumber = TextEditingController();
  TextEditingController engineNumber = TextEditingController();
  TextEditingController numberTyres = TextEditingController();
  TextEditingController wheelbase = TextEditingController();
  TextEditingController tyreenter = TextEditingController();
  TextEditingController power = TextEditingController();
  var trailerName;
  var image;
  Datum? brandvalue;
  var fuelType;
  var tyre;
  var totalTyres = [
    "4",
    "6",
    "8",
    "10",
    "12",
    "14",
    "16",
    "18",
    "20",
    "22",
    "24",
    "26",
    "28",
    "30",
    "Other"
  ];
  String? brandName;

  String? textType;

  getBrandList() async {
    brandList = [];
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "isActive": "true",
      "isDeleted": "false",
      "isAdminApprove": "APPROVED",
      "count": 100
    };
    loading = true;
    notifyListeners();
    print(map);
    try {
      brandListModel = await hitBrandListApi(map);
      brandList.add(Datum(brand: "Others", id: "12345"));
      brandList.addAll(brandListModel!.data!);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
    }
  }

  setTrailerValue(String name) {
    trailerName = name;
    notifyListeners();
  }

  ///set value Brand
  setBrandValue(Datum value) {
    brandvalue = value;
    brandName = value.brand;
    notifyListeners();
  }

  ///set value fuelType
  setFuelValue(String name) {
    fuelType = name;
    notifyListeners();
  }

  setTyreValue(name) {
    tyre = name;
    notifyListeners();
  }

  Future<void> hitAddFleetManager(String type) async {
    print(type);
    loder = true;
    notifyListeners();
    var userId = await getUserId();

    var companyId = await getCompanyId();
    print(companyId);
    var roleTitle = await getRoleInfo();
    Map<String, dynamic> map = type == "trailer"
        ? {
            "companyId": companyId == "" ? userId : companyId,
            "constName": "NOOFTRUCKANDTRAILERS",
            "createdById": companyId == "" ? userId : companyId,
            "height": height.text,
            "loadCapacity": capacity.text,
            "name": name.text,
            "planTitle": "TRIPPLAN",
            "roleTitle": roleTitle,
            "trailerType": trailerName,
            "vehicleType": "TRAILER",
            "weight": weight.text,
            "width": width.text,
            "image": image == null
                ? null
                : image.toString().replaceAll(Base_Url_Fleet_trailer, ''),
          }
        : {
            "brand": brandvalue == null ? null : brandvalue!.id,
            "companyId": companyId == "" ? userId : companyId,
            "constName": "NOOFTRUCKANDTRAILERS",
            "createdById": companyId == "" ? userId : companyId,
            "engine": engineNumber.text,
            "fuelCapacity": capacity.text,
            "fuelType": fuelType.toString().toLowerCase(),
            "height": height.text,
            "modelNumber": modelNumber.text,
            "name": name.text,
            "numOfTyres": tyre,
            "number": vin.text,
            "planTitle": "TRIPPLAN",
            'power': power.text,
            'roleTitle': roleTitle,
            "vehicleType": "TRUCK",
            "weight": weight.text,
            "wheelbase": wheelbase.text,
            "width": width.text,
            "image": image == null
                ? null
                : image.toString().replaceAll(Base_Url_Fleet_truck, ''),
            "otherbrand": brandvalue == null
                ? null
                : brandvalue!.id == "12345"
                    ? brand.text
                    : "",
            "OtherTyre": tyreenter.text
          };
    print(map);

    try {
      _responseModel = await hitAddFleetManagerApi(map);
      Navigator.pop(navigatorKey.currentState!.context);
      showMessage(_responseModel!.message.toString());
      loder = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      loder = false;
      notifyListeners();
    }
  }

  Future<void> hitVehicleData() async {
    vinLoad = true;
    notifyListeners();
    Map<String, dynamic> map = {};
    print(map);
    try {
      vinModel = await hitAddVehiclesApi(map, vin.text);
      showData();
      vinLoad = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      vinLoad = false;
      notifyListeners();
    }
  }

  getFromGallery(BuildContext context, String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (File(image!.path) != null) {
      cropImage(File(image.path), type);
      notifyListeners();
    }
  }

  imageUpload(File image, String type) async {
    imageloder = true;
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

      if (jsonData['data'] == null || jsonData['code'] != 200) {
      } else {
        var imageReal = jsonData['data']['imagePath'];
        print(type);
        this.image = type == "TRAILERIMAGE"
            ? Base_Url_Fleet_trailer + imageReal
            : Base_Url_Fleet_truck + imageReal;

        notifyListeners();
      }
    }

    imageloder = false;
    notifyListeners();
  }

  cropImage(File image, String type) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 11.0, ratioY: 4.0),
      cropStyle: CropStyle.rectangle,
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
      print(file.path);

      imageUpload(
        File(croppedFile.path),
        type,
      );
      notifyListeners();

      print(image);
    }
  }

  void showData() {
    textType = vinModel!.results![0]["EngineManufacturer"];
    print("gygtuyguj$textType");
    brand.text = vinModel!.results![0]["EngineManufacturer"].toString();
    fuelType = vinModel!.results![0]["FuelTypePrimary"] == "Gasoline"
        ? "Gas"
        : vinModel!.results![0]["FuelTypePrimary"] == ""
            ? "Gas"
            : vinModel!.results![0]["FuelTypePrimary"] == "Not Applicable"
                ? "Gas"
                : vinModel!.results![0]["FuelTypePrimary"];
    weight.text = vinModel!.results![0]["TrackWidth"].toString();
    /*tyre = vinModel!.results![0]["Wheels"] == ""
        ? "4"
        : vinModel!.results![0]["Wheels"];*/
    power.text = vinModel!.results![0]["EngineHP"].toString();
    modelNumber.text = vinModel!.results![0]['Model'].toString();
  }
}
