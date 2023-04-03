import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CompanyProfile.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/CountryModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/PostalCodeModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/ServiceModel.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/Provider/company_profile_view_provider.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/company_profile_view.dart';
import 'package:provider/provider.dart';

import '../../../../Model/NetworkModel/normal_response.dart';

class ProfileProvider extends ChangeNotifier {
  bool _loading = false;
  bool updateloder = false;

  get loading => _loading;
  CompanyDetail? _companyModel;
  ServiceModel? _serviceModel;
  String? message;
  var serviceArray = [];
  String? se;
  bool imageLoad = false;
  bool imageBanner = false;
  String? imageReal;
  bool ImageUploadShow = false, ImageUploadLogoshow = false;
  var imageFile;
  String? imageUrl, imagebackground, imageLogo;

  String? getName;
  int? ProgressBar;
  double? precentindicate = 0.0;
  String? getProfileImage;
  double percent = 1;
  bool checkPostalCode = false;
  final picker = ImagePicker();

  ServiceModel? get serviceModel => _serviceModel;

  CompanyDetail? get companyModel => _companyModel;

  CountryModel? _countryModel;

  CountryModel? get countryModel => _countryModel;
  PostalCodeModel postalCodeModel = PostalCodeModel();

  TextEditingController companyName = TextEditingController();
  TextEditingController directorName = TextEditingController();
  TextEditingController incorprationDate = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController country = TextEditingController();

  TextEditingController city = TextEditingController();
  TextEditingController postcode = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController aboutcompany = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController serviceName = TextEditingController();
  late DateTime startDate;
  Datum? dropdownValue;
  Map<dynamic, String> ServiceId = {};
  late List productMap = [];
  List<StateArr>? states;
  String? state = "";
  var service = "";
  var items;
  List<String>? _texts;
  var getid;
  var stateId;

  var countryId, serviced;
  String? countryName = '';
  String? imageBannerModel;
  String? imagelogo;

  hitCompanyProfile(getid, BuildContext context) async {
    Map<String, String> map = {
      'companyId': getid,
    };
    this.getid = getid;
    _loading = true;
    notifyListeners();
    print(map);
    try {
      dropdownValue = null;
      state = null;

      _companyModel = await hitCompanyProfileApi(map);
      _countryModel = await hitCountryApi(map);
      _serviceModel = await hitServiceListApi(map);

      setData();
      findData();
      CalculatePercentage();
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
  }

  void setData() {
    var company = _companyModel!;
    companyName.text = company.companyName.toString();
    directorName.text =
        company.directorName == null ? '' : company.directorName.toString();
    firstName.text =
        company.firstName == null ? '' : company.firstName.toString();
    lastName.text = company.lastName == null ? '' : company.lastName.toString();
    email.text = company.email.toString();
    city.text = company.city == null ? '' : company.city.toString();
    postcode.text =
        company.postalCode == null ? '' : company.postalCode.toString();
    aboutcompany.text =
        company.aboutCompany == null ? '' : company.aboutCompany.toString();
    addresss.text = company.address == null ? '' : company.address.toString();
    mobile.text = company.mobileNumber.toString();

    var formatter = new DateFormat('MMM-dd-yyyy');

    String dateToString = company.incorporationDate == null
        ? ''
        : formatter.format(company.incorporationDate!);
    incorprationDate.text = dateToString == '' ? '' : dateToString;

    getImageBanner(company.bannerImage.toString());
    imagelogo = companyModel!.companyLogo;
    checkPostalCode = true;
    getServiceData();
  }

  void findData() {
    countryName = companyModel!.countryName;

    state = companyModel!.stateName;
    for (int i = 0; i < _countryModel!.data!.length; i++) {
      if (countryName == _countryModel!.data![i].countryName) {
        dropdownValue = _countryModel!.data![i];
        states = _countryModel!.data![i].stateArr;
        countryId = _countryModel!.data![i].id;
        stateId = _countryModel!.data![i].stateArr![i].id;
        print(stateId);
        break;
      }
    }
  }

  void setCountry(Datum newValue) {
    dropdownValue = null;
    dropdownValue = newValue;
    states = dropdownValue!.stateArr;

    state = states![0].stateName.toString();
    countryId = dropdownValue!.id;
    this.stateId = states![0].id;
    notifyListeners();
  }

  void setState(String newValue, stateId) {
    final index = states!.indexWhere((element) => element.id == stateId);

    if (index <= 0) {
      print(index);
    } else {
      state = states![index].stateName;
      this.stateId = stateId;
    }

    notifyListeners();
  }

  getCompanyserviceId(List mutipleId) {
    productMap = [];
    for (int i = 0; i < mutipleId.length; i++) {
      print(mutipleId[i]);
      ServiceId['serviceId'] = mutipleId[i].toString();

      productMap.add(ServiceId);
      ServiceId = {};
    }

    print(productMap);
  }

  getCompanyServiceName(List mutiplevalue) {
    serviceName.text = "";
    for (int i = 0; i < mutiplevalue.length; i++) {
      service += (mutiplevalue[i] + ',').toString();

      serviceName.text = service.substring(0, service.length - 1);
    }
  }

  hitUpdateCompanyDetail(BuildContext context) async {
    var profileComplete = await getProfileComplete();
    String getRole = await getRoleInfo();
    CalculatePercentage();
    updateloder = true;
    notifyListeners();
    Map<String, dynamic> map = {
      'companyId': getid,
      'aboutCompany': aboutcompany.text,
      'contactPerson': firstName.text + " " + lastName.text,
      'address': addresss.text,
      'bannerImage': imagebackground,
      'city': city.text,
      'companyName': companyName.text,
      'firstName': firstName.text,
      'lastName': lastName.text,
      'country': countryId,
      'directorName': directorName.text,
      'email': email.text,
      'incorporationDate': incorprationDate.text,
      'mobileNumber': mobile.text,
      'postalCode': postcode.text,
      'state': stateId,
      'userId': getid,
      'roleTitle': "Company",
      'services': productMap,
      'profileComplete': true,
      'progressBar': percent.floor(),
      'companyLogo': imageLogo == null
          ? imagelogo == null
              ? null
              : imagelogo
          : imageLogo,
    };
    hitPostelCode(postcode.text);

    print(map);
    try {
      ResponseModel res = await hitCompanyProfileUpdateApi(map);

      setProfileComplete(true);

      setprofileInfo(imageLogo == null ? imagelogo : imageLogo);

      setProgressBar(percent.floor());
      setNameInfo(companyName.text.length == 0
          ? firstName.text + " " + lastName.text
          : companyName.text);
      updateloder = false;
      if (profileComplete != false) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => CompanyViewProvider(),
                    child: CompanyViewDetail())));
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => BottomMenu(showCapitalize(getRole), 0)),
            (Route<dynamic> route) => false);
      }
      showMessage(res.message.toString());

      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message.toString());
      print(e.toString());
      notifyListeners();
    }
    updateloder = false;
  }

  void getServiceData() {
    var q = [];
    ServiceId = {};
    productMap = [];
    for (int j = 0; j < _companyModel!.companyServices!.length; j++) {
      for (int i = 0; i < _serviceModel!.data!.length; i++) {
        {
          if (_companyModel!.companyServices![j].serviceName ==
              _serviceModel!.data![i].serviceName) {
            print(_serviceModel!.data![i].serviceName.toString());
            _serviceModel!.data![i].check = true;
            q.add(_serviceModel!.data![i].serviceName.toString());
            ServiceId['serviceId'] = _serviceModel!.data![i].id.toString();
            productMap.add(ServiceId);
          }
        }
      }
    }
    serviceName.text = q.toString().replaceAll('[', '').replaceAll(']', '');
  }

  startDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(
          1900,
        ),
        lastDate: DateTime.now().add(Duration(days: 6570)),
      );

  setStartDate(BuildContext context) async {
    final startDate = await startDateTime(context);
    if (startDate == null) return "Please enter incorporation date";

    print(startDate);

    this.startDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );

    incorprationDate.text = formatterDate(startDate);
    notifyListeners();
  }

  getDate(var startDate) {
    this.startDate = startDate;

    print(startDate);

    notifyListeners();
  }

  getvalueSharedPreferences() async {
    getName = await getNameInfo() ?? null;

    ProgressBar = await getProgressBar() ?? 0;

    if (50 < ProgressBar!) {
      precentindicate = 0.6;
    }
    if (80 < ProgressBar!) precentindicate = 0.8;
    if (95 < ProgressBar!) precentindicate = 1.0;

    notifyListeners();
  }

  getProfileImageSharedPreferences() async {
    getProfileImage = await getprofileInfo() ?? "";

    notifyListeners();
  }

  getImageUploadBannerShow(bool value) {
    ImageUploadShow = value;
    notifyListeners();
  }

  getImageUploadLogoShow(bool value) {
    ImageUploadLogoshow = value;
    notifyListeners();
  }

  getImageBanner(String imagebanner) {
    imageBannerModel = imagebanner;
    notifyListeners();
  }

  hitPostelCode(String value) async {
    try {
      Map<String, dynamic> map = {'zipcode': value};
      postalCodeModel = await hitPostcodeApi(map);
      postcode.text = value;
      city.text = postalCodeModel.data!.city!;
      checkPostalCode = true;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      checkPostalCode = false;
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  CalculatePercentage() {
    percent = 2;
    if (firstName.text != '') {
      percent += 6.6;
      print(percent);
    }
    if (lastName.text != '') {
      percent += 6.6;
    }
    if (email.text != '') {
      percent += 6.6;
    }
    if (mobile.text != '') {
      percent += 6.6;
    }
    if (incorprationDate.text != '') {
      percent += 6.6;
    }
    if (directorName.text != '') {
      percent += 6.6;
    }
    if (city.text != '') {
      percent += 6.6;
    }
    if (postcode.text != '') {
      percent += 6.6;
    }
    if (aboutcompany.text != '') {
      percent += 6.6;
    }
    if (countryName != '') {
      percent += 6.6;
    }
    if (state != '') {
      percent += 6.6;
    }
    if (imageBannerModel != "null") {
      print("kjhfjkh$percent");
      print(imageBannerModel);
      percent += 6.6;
    }

    if (addresss.text != '') {
      percent += 6.6;
      print(percent);
    }

    if (companyName.text != '') {
      percent += 6.6;
    }
    if (imagelogo != null) {
      percent += 6.6;
      print("imagelogo$percent");
    }
    print(percent.floor());
  }

  getFromGallery(String type, BuildContext context) async {
    try {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 600,
        maxHeight: 600,
      );
      if (pickedFile != null) {
        if (type == "COMPANYBANNER") {
          print(pickedFile);
          cropImage(pickedFile, type, context);
          // imageUpload(imageFile, type, context);
        } else {
          cropImage(pickedFile, type, context);
        }
      } else {
        print("hello");
      }
    } on PlatformException catch (e) {
      print("Platform");
      print('Platform exception $e');
    } catch (e) {
      print("Unknown");
      print('Unknown error: $e');
    }
  }

  //
  //
  // print(pickedFile!.path);
  // if (pickedFile != null) {
  //   // setState(() {
  //
  //
  //   imageFile = File(pickedFile.path);
  //
  //   if (type == "COMPANYBANNER") {
  //     print(pickedFile);
  //     cropImage(pickedFile,type,context);
  //     // imageUpload(imageFile, type, context);
  //   } else {
  //     cropImage(pickedFile,type,context);
  //
  //   }
  //   notifyListeners();
  //   // });
  // }

  imageUpload(File image, String type, BuildContext context) async {
    imageLoad = false;
    imageBanner = false;
    type == "COMPANYBANNER" ? imageBanner = true : imageLoad = true;

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

        // );
        if (type == "COMPANYBANNER") {
          imagebackground = imageReal;
          companyModel!.bannerImage = imagebackground;
          showMessage(jsonData['message']);
        } else {
          imageLogo = imageReal;
          companyModel!.companyLogo = imageLogo;
          showMessage(jsonData['message']);
          print(imageLogo);
        }
      }
      imageBanner = false;
      imageLoad = false;
      notifyListeners();
    }
  }

  cropImage(PickedFile pickedFile, String type, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: type == "COMPANYBANNER"
          ? CropAspectRatio(ratioX: 11.0, ratioY: 4.0)
          : CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      cropStyle:
          type == "COMPANYBANNER" ? CropStyle.rectangle : CropStyle.circle,
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
      imageUpload(file, type, context);
    }
  }
}
