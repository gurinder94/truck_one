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
import 'package:my_truck_dot_one/Model/TripPlannerModel/TruckDetailListModel.dart';
import 'package:my_truck_dot_one/Model/VINModel.dart';

class EditTruckManagerProvider extends ChangeNotifier {
  bool loading = true, loder = false, imageLoder = false;
  var message = "";
  final ImagePicker _picker = ImagePicker();
  VinModel vinModel = VinModel();
  List<Datum> brandList = [];
  BrandListModel? brandListModel;
  ResponseModel? _responseModel;
  TextEditingController name = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController width = TextEditingController();
  TextEditingController capacity = TextEditingController();
  TextEditingController vin = TextEditingController();
  TextEditingController modelNumber = TextEditingController();
  TextEditingController engineNumber = TextEditingController();
  TextEditingController numberTyres = TextEditingController();
  TextEditingController wheelbase = TextEditingController();
  TextEditingController power = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController brandNameController = TextEditingController();
  TextEditingController tyreenter = TextEditingController();
  TextEditingController length = TextEditingController();
  bool isDelete = false;
  String isDeleteName = "Unarchived";
  var trailerName;
  var image;

  Datum brandvalue = Datum();

  // var brandvalue;
  var fuelType;
  TruckDetailListModel? truckDetailModel;
  String fleetManagerId;

  var brandName;

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

  bool vinLoad = false;

  String? textType;

  EditTruckManagerProvider(this.fleetManagerId);

  getBrandList() async {
    brandList = [];

    var getid = await getUserId();
    Map<String, dynamic> map = {
      "isActive": "true",
      "isDeleted": "false",
      "isAdminApprove": "APPROVED",
      "count": 100
    };

    notifyListeners();
    print(map);
    try {
      brandListModel = await hitBrandListApi(map);
      brandList.add(Datum(brand: "Others", id: "12345"));
      brandList.addAll(brandListModel!.data!);
      await hitGetTruckDetails("truck");
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      loading = false;

      notifyListeners();
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

  getFromGallery(BuildContext context, String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (File(image!.path) != null) {
      // setState(() {
      cropImage(File(image.path), type);
      notifyListeners();
    }
  }

  imageUpload(File image, String type) async {
    imageLoder = true;
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

      if (jsonData['data'] == null && jsonData["code"] != 200) {
        showMessage(jsonData['message']);
      } else {
        var imageReal = jsonData['data']['imagePath'];
        print(imageReal);
        this.image = type == "TRAILERIMAGE"
            ? Base_Url_Fleet_trailer + imageReal
            : Base_Url_Fleet_truck + imageReal;

        notifyListeners();
      }
    }
    imageLoder = false;
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

  hitGetTruckDetails(String type) async {
    Map<String, dynamic> map = {
      '_id': fleetManagerId,
    };

    try {
      truckDetailModel = await hitGetTruckDeatilApi(map);
      type == "trailer"
          ? setData(truckDetailModel!)
          : setTruckData(truckDetailModel!);
      type == "trailer" ? loading = false : SizedBox();
      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      loading = false;
      type == "trailer" ? loading = false : SizedBox();
      notifyListeners();
    }
  }

  setData(TruckDetailListModel? truckDetailModel) {
    final truckDetail = truckDetailModel!.data!;
    name.text = truckDetail.name!;
    weight.text = truckDetail.weight!.toInt().toString();
    height.text = truckDetail.height!.toInt().toString();
    width.text = truckDetail.width!.toInt().toString();
    trailerName = truckDetail.trailerType.toString();
    vin.text = truckDetail.trailerVinNumber.toString();
    length.text = truckDetail.length.toString();
    capacity.text = truckDetail.loadCapacity.toString();
    image = truckDetail.image;
    image = image == null ? "" : Base_Url_Fleet_trailer + image;
    isDeleteName = truckDetail.isDeleted == true ? "Archived" : "Unarchived";
    isDelete = truckDetail.isDeleted!;
  }

  void setTruckData(TruckDetailListModel truckDetailModel) {
    final truckDetail = truckDetailModel.data!;
    name.text = truckDetail.name!;
    weight.text = truckDetail.weight!.toInt().toString();
    height.text = truckDetail.height!.toInt().toString();
    width.text = truckDetail.width!.toInt().toString();
    trailerName = truckDetail.trailerType.toString();
    capacity.text = truckDetail.fuelCapacity.toString();
    modelNumber.text = truckDetail.modelNumber ?? "";
    engineNumber.text = truckDetail.engine ?? "";
    wheelbase.text = truckDetail.wheelbase.toString();

    tyre = truckDetail.numOfTyres.toString() == "0"
        ? "Other"
        : truckDetail.numOfTyres.toString();
    tyreenter.text = truckDetail.OtherTyre.toString();
    power.text = truckDetail.power.toString();
    fuelType = truckDetail.fuelType == null
        ? null
        : truckDetail.fuelType == "petrol"
            ? "Petrol"
            : "Diesel";
    image = truckDetail.image;
    int index = brandList.indexWhere((item) {
      return item.id ==
          (truckDetail.brand!.id == null &&
                  truckDetail.otherbrand.toString() == "null"
              ? brandList[1].id
              : truckDetail.brand!.id == null
                  ? "12345"
                  : truckDetail.brand!.id);
    });
    vin.text = truckDetail.number.toString();
    if (index >= 0) {
      setBrandValue(brandList[index]);
    }
    brand.text = truckDetail.otherbrand.toString() == "null"
        ? ""
        : truckDetail.otherbrand.toString();

    textType = truckDetail.brandName.toString() == "null"
        ? ""
        : truckDetail.brandName.toString();
    brandNameController.text = truckDetail.brandName.toString() == "null"
        ? ""
        : truckDetail.brandName.toString();
    image = image == null ? "" : Base_Url_Fleet_truck + truckDetail.image!;
    isDeleteName = truckDetail.isDeleted == true ? "Archived" : "Unarchived";
    isDelete = truckDetail.isDeleted!;
  }

  Future<void> hitVehicleData(var data) async {
    vinLoad = true;
    notifyListeners();
    Map<String, dynamic> map = {};
    print(map);
    try {
      vinModel = await hitAddVehiclesApi(map, vin.text);
      data == "truck" ? showData() : showTrailerData();
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

  void showData() {
    textType = vinModel.results![0]["EngineManufacturer"];
    brandNameController.text =
        vinModel.results![0]["EngineManufacturer"].toString();
    fuelType = vinModel.results![0]["FuelTypePrimary"] == "Gasoline"
        ? "Gas"
        : vinModel.results![0]["FuelTypePrimary"] == ""
            ? "Gas"
            : vinModel.results![0]["FuelTypePrimary"];
    weight.text = vinModel.results![0]["TrackWidth"].toString();
    power.text = vinModel.results![0]["EngineHP"].toString();
    modelNumber.text = vinModel.results![0]['Model'].toString();
  }

  hitUpdateVehicelType(String id, String type) async {
    loder = true;
    notifyListeners();
    var getId = await getUserId();
    Map<String, dynamic> map = type == "truck"
        ? {
            "brand": brandvalue.id,
            "otherbrand": brandvalue.id != "12345" ? "" : brand.text.toString(),
            "brandName": brandNameController.text.toString() == "null"
                ? ""
                : brandNameController.text.toString(),
            "createdById": getId,
            "engine": engineNumber.text,
            "fuelCapacity": capacity.text,
            "fuelType": fuelType,
            "height": height.text,
            "image": image == null
                ? null
                : image.toString().replaceAll(Base_Url_Fleet_truck, ''),
            "isDeleted": isDelete,
            "loadCapacity": "0",
            "modelNumber": modelNumber.text,
            "name": name.text,
            "numOfTyres": tyre,
            "number": vin.text,
            "power": power.text,
            "vehicleType": "TRUCK",
            "weight": weight.text,
            "wheelbase": wheelbase.text,
            "width": width.text,
            "_id": id,
            "OtherTyre": tyre == "Other" ? tyreenter.text : ""
          }
        : {
            "createdById": getId,
            "height": height.text,
            "image": image == null
                ? null
                : image.toString().replaceAll(Base_Url_Fleet_trailer, ''),
            "isDeleted": isDelete,
            "trailerVinNumber": vin.text,
            "length": length.text,
            "loadCapacity": capacity.text,
            "name": name.text,
            "trailerType": trailerName,
            "vehicleType": "TRAILER",
            "weight": weight.text,
            "width": width.text,
            "_id": id,
          };
    try {
      _responseModel = await hitUpdateFleetManagerApi(map);
      Navigator.pop(navigatorKey.currentState!.context);
      showMessage(_responseModel!.message!);
      loder = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message.toString());
      print(e.toString());
      loder = false;
      notifyListeners();
    }
  }

  void setDelete(String newValue) {
    isDelete = newValue == "Archived" ? true : false;
    isDeleteName = newValue;
    notifyListeners();
  }

  void showTrailerData() {
    weight.text = vinModel.results![0]["TrackWidth"].toString();
    length.text = vinModel.results![0]["TrailerLength"] == null
        ? ""
        : vinModel.results![0]["TrailerLength"].toString();
  }
}
