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

class AddFleetManagerProvider extends ChangeNotifier {
  bool loading = false, loder = false,imageloder=false;
  var message = "";
  final ImagePicker _picker = ImagePicker();
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
  var trailerName;
  var image;
  Datum? brandvalue;
  var fuelType;

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
      brandList.addAll(brandListModel!.data!);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      print("hh");
      message = e.toString().replaceAll('Exception:', '');
      //
      // print(e.toString());
      // notifyListeners();
    }
  }

  setTrailerValue(String name) {
    trailerName = name;
    notifyListeners();
  }

  ///set value Brand
  setBrandValue(Datum value) {
    brandvalue = value;
    notifyListeners();
  }

  ///set value fuelType
  setFuelValue(String name) {
    fuelType = name;
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
                : image.toString().replaceAll(Base_Url_Fleet_trailer, '')
          }
        : {
            "brand": brandvalue!.id,
            "companyId": companyId == "" ? userId : companyId,
            "constName": "NOOFTRUCKANDTRAILERS",
            "createdById": companyId == "" ? userId : companyId,
            "engine": engineNumber.text,
            "fuelCapacity": capacity.text,
            "fuelType": fuelType.toString().toLowerCase(),
            "height": height.text,
            "modelNumber": modelNumber.text,
            "name": name.text,
            "numOfTyres": numberTyres.text,
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
                : image.toString().replaceAll(Base_Url_Fleet_truck, '')
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
      showMessage(  message );
      print(e.toString());
      loder = false;
      notifyListeners();
    }
  }

  getFromGallery(BuildContext context, String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (File(image!.path) != null) {
      // setState(() {

      cropImage(File(image.path), type);
      notifyListeners();
    }
  }

  imageUpload(
    File image,
    String type,
  ) async {
    imageloder=true;
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

      if (jsonData['data'] == null || jsonData['code']!=200) {
      } else {
        var imageReal = jsonData['data']['imagePath'];
        print(type);
        this.image = type == "TRAILERIMAGE"
            ? Base_Url_Fleet_trailer + imageReal
            : Base_Url_Fleet_truck + imageReal;

        notifyListeners();
        // if (type == "COMPANYBANNER") {
        //   imagebanner = imageReal;
        //   userModel!.data!.bannerImage = imagebanner;
        //   showMessage(jsonData['message']);
        //   print("hello");
        //   notifyListeners();
        // } else {
        //   imageLogo = imageReal;
        //   userModel!.data!.image = imageLogo;
        //   showMessage(jsonData['message']);
        //   print(imageLogo);
        //   notifyListeners();
        // }
      }
    }

    imageloder=false;
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
}
