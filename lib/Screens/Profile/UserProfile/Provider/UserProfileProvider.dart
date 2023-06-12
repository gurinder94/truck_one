import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/SkillModel.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/qualificationModel.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/user_profile_view.dart';
import 'package:provider/provider.dart';
import '../../../../Model/JobModel/JobViewList.dart';
import '../../../../Model/NetworkModel/normal_response.dart';
import '../../../../Model/ProfileModel/UserModel.dart';

class UserProfileProvider extends ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController permanentsaddress = TextEditingController();
  TextEditingController crosssaddress = TextEditingController();
  TextEditingController workplace = TextEditingController();
  TextEditingController designation = TextEditingController();
  TextEditingController qualificationEditText = TextEditingController();
  TextEditingController skillText = TextEditingController();
  TextEditingController marriedStatus = TextEditingController();
  TextEditingController educationQualification = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController languages = TextEditingController();
  TextEditingController resumeDocument = TextEditingController();
  TextEditingController drivingDocument = TextEditingController();
  TextEditingController additionalEditText = TextEditingController();
  TextEditingController aboutUs = TextEditingController();
  TextEditingController medical = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  bool _loading = false, updateloder = false;
  String? getid;
  File? files;
  String? message;
  bool imageLoad = false;
  double percent = 1;
  String? roleName;
  Map<String, dynamic> resumeMap = {};
  Map<String, dynamic> driverMap = {};
  Map<String, dynamic> addtionDocumentMap = {};
  Map<String, dynamic> medicalCertificateMap = {};
  var documentArray = [];
  bool loaderDriverlicense = false,
      LoderResume = false,
      LoderMedical = false,
      loderAdditonalDocument = false;

  String data = '';
  String skill = '';

  bool get loading => _loading;
  UserModel? userModel;
  late QualificationModel qualification;
  List<Datum> listQualification = [];
  List<SkillDatum> listSkill = [];
  late SkillModel skillModel;
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  var skillarray = [];
  var qualificationarray = [];
  var languagearray = [];

  List<String> skillId = [];
  List<String> qualificationId = [];
  List<Qualifications> userList = [];
  List<Qualifications> skillData = [];
  bool ImageUploadShow = false;

  List<String> get items => _items;

  List<String> get experience => _experience;

  List<String> get monthExp => _experiencemonth;
  DateTime startDate = DateTime.now();
  String? getName, getProfileImage;
  int? ProgressBar = 0;
  double? precentindicate = 0.3;

  List<String> get maritalStatus => _maritalStatus;
  String? valueItemSelected;
  String? valueExperience;
  String? valueExpMonth;
  String? valueLanguage;
  String? valueMaritalStatus;
  String? userId;
  List<String> _items = [
    "Male",
    "Female",
    "Others",
  ];
  String? imageReal;
  var imageFile;
  ResponseModel responseModel = ResponseModel();
  var imageUrl, image, imageLogo, imagebanner, imageviewBanner;

  List<String> _experience = [
    "0 year",
    "1 year",
    "2 year",
    "3 year",
    "4 year",
    "5 year",
    "6 year",
    "7 year",
    "8 year",
    "9 year",
    "10 year",
    "11 year",
    "12 year",
    "13 year",
    "14 year",
    "15 year",
  ];

  List<String> _experiencemonth = [
    "0 months",
    "1 months",
    "2 months",
    "3 months",
    "4 months",
    "5 months",
    "6 months",
    "7 months",
    "8 months",
    "9 months",
    "10 months",
    "11 months",
    "12 months",
  ];
  List<String> _maritalStatus = ["Married", "Single"];

  Map<String, bool> mutipleLanguage = {
    'Arabic': false,
    'Bengali': false,
    'Chinese': false,
    'Danish': false,
    'Dutch': false,
    'English': false,
    'French': false,
    'German': false,
    'Gujarati': false,
    'Hindi': false,
    'Indonesian': false,
    'Italian': false,
    'Japanese': false,
    'Korean': false,
    'Kannada': false,
    'Marathi': false,
    'Punjabi': false,
    'Portuguese': false,
    'Russian': false,
    'Spanish': false,
    'Tamil': false,
    'Telugu': false,
    'Turkish': false,
    'Urdu': false,
  };

  var multiLanguageKeys = [
    'Arabic',
    'Bengali',
    'Chinese',
    'Danish',
    'Dutch',
    'English',
    'French',
    'German',
    'Gujarati',
    'Hindi',
    'Indonesian',
    'Italian',
    'Japanese',
    'Korean',
    'Kannada',
    'Marathi',
    'Punjabi',
    'Portuguese',
    'Russian',
    'Spanish',
    'Tamil',
    'Telugu',
    'Turkish',
    'Urdu'
  ];

  void setSelectedLanguage(String s) {
    valueLanguage = s;
    notifyListeners();
  }

  void setSelectedItem(String s) {
    valueItemSelected = s;
    notifyListeners();
    print(s);
  }

  void setSelectedExperience(String s) {
    valueExperience = s;
    notifyListeners();
  }

  void setMonthExperience(String s) {
    valueExpMonth = s;

    notifyListeners();
  }

  void setSelectedMaritalStatus(String s) {
    valueMaritalStatus = s;
    notifyListeners();
  }

  hitUserProfileDetails(String? getId, BuildContext context) async {
    userModel = null;
    var roleName = await getRoleInfo();
    documentArray = [];
    {
      Map<String, String> map = {
        'endUserId': getId.toString(),
      };
      listQualification.clear();
      listSkill.clear();
      userList.clear();
      skillData.clear();
      this.getid = getId;
      _loading = true;
      print(map);
      notifyListeners();
      print(map);
      try {
        userModel = await hitUserProfileApi(map);
        qualification = await hitGetQualificationApi(map);
        skillModel = await hitGetSkillApi(map);
        if (userModel!.data!.otherQualification != "") {
          userList.add(Qualifications(qualification: "Others"));
        }
        if (userModel!.data!.otherSkill != "") {
          skillData.add(Qualifications(skill: "Others"));
        }
        userList.addAll(userModel!.data!.qualification!);
        skillData.addAll(userModel!.data!.skillData!);
        listQualification.add(Datum(qualification: "Others", id: "12345"));
        listQualification.addAll(qualification.data!);
        listSkill.add(SkillDatum(skill: "Others", id: "123456"));
        listSkill.addAll(skillModel.data!);
        setValue();
        _loading = false;
        roleName.toString().toUpperCase() == "DRIVER"
            ? DriverCalculatePercentage()
            : CalculatePercentage();
        notifyListeners();
      } on Exception {
        showMessage(message!);
        notifyListeners();
      }
      _loading = false;
    }
  }

  setValue() {
    var userProfile = userModel!.data!;

    firstName.text =
        userProfile.firstName == null ? '' : userProfile.firstName.toString();
    lastName.text =
        userProfile.lastName == null ? '' : userProfile.lastName.toString();
    email.text = userProfile.email!;
    mobile.text = userProfile.mobileNumber!;
    educationQualification.text = userProfile.otherQualification.toString();
    permanentsaddress.text = userProfile.permAddress == null
        ? ''
        : userProfile.permAddress.toString();
    crosssaddress.text = userProfile.corrAddress == null
        ? ''
        : userProfile.corrAddress.toString();
    workplace.text =
        userProfile.workPlace == null ? '' : userProfile.workPlace.toString();
    designation.text = userProfile.designation == null
        ? ''
        : userProfile.designation.toString();

    String dateToString = userProfile.dateOfBirth == null
        ? ''
        : formatterDate(userProfile.dateOfBirth!);
    dateofbirth.text = dateToString;
    String? gender = userProfile.gender;
    valueItemSelected = gender == null
        ? "Male"
        : gender == ""
            ? "Male"
            : gender.toString();
    // valueExperience = userProfile.experience.toString();
    String? monthExperience = userProfile.monthsExperience.toString();
    valueExpMonth =
        monthExperience == "null" ? valueExpMonth : "${monthExperience} months";
    String? experience = userProfile.experience.toString();
    valueExperience = experience == "null"
        ? valueExperience
        : "${experience.toString()} year";
    String? maritalStatus = userProfile.maritalStatus.toString();
    marriedStatus.text = userProfile.otherSkill.toString();
    valueMaritalStatus =
        maritalStatus == "" ? "null" : maritalStatus.toString();
    getQualification();
    getLanguages();
    getSkill();
    image = userProfile.image;
    imageviewBanner = userProfile.bannerImage;

    roleName == "DRIVER" ? getdocumentView(userProfile) : '';
    aboutUs.text =
        userProfile.aboutUser == null ? '' : userProfile.aboutUser.toString();
    notifyListeners();
  }

  CalculatePercentage() {
    percent = 1.0;
    if (firstName.text.length != 0) percent += 5.8;
    if (lastName.text.length != 0) percent += 5.8;
    if (email.text.length != 0) percent += 5.8;
    if (mobile.text.length != 0) percent += 5.8;
    if (dateofbirth.text.length != 0) percent += 5.8;
    if (permanentsaddress.text.length != 0) percent += 5.8;
    if (crosssaddress.text.length != 0) percent += 5.8;
    if (designation.text.length != 0) percent += 5.8;
    if (workplace.text.length != 0) percent += 5.8;
    if (valueMaritalStatus != null) percent += 5.8;
    if (valueExperience != null) {
      percent += 5.8;
    }
    if (qualificationEditText.text.length != 0) percent += 5.8;
    if (skillText.text.length != 0) percent += 5.8;
    if (languages.text.length != 0) percent += 5.8;
    if (image != null) percent += 5.8;
    if (imageviewBanner != null) percent += 5.8;
    if (aboutUs.text.length != 0) percent += 5.8;

    print(percent);
    notifyListeners();
  }

  DriverCalculatePercentage() {
    percent = 1.0;
    if (firstName.text.length != 0) percent += 4.7;
    if (lastName.text.length != 0) percent += 4.7;
    if (email.text.length != 0) percent += 4.7;
    if (mobile.text.length != 0) percent += 4.7;
    if (dateofbirth.text.length != 0) percent += 4.7;
    if (permanentsaddress.text.length != 0) percent += 4.7;
    if (crosssaddress.text.length != 0) percent += 4.7;
    if (designation.text.length != 0) percent += 4.7;
    if (workplace.text.length != 0) percent += 4.7;
    if (valueMaritalStatus != null) percent += 4.7;
    if (valueExperience != null) {
      percent += 4.7;
    }
    if (qualificationEditText.text.length != 0) percent += 4.7;
    if (skillText.text.length != 0) percent += 4.7;
    if (languages.text.length != 0) percent += 4.7;
    if (image != null) percent += 4.7;
    if (imageviewBanner != null) percent += 4.7;
    if (aboutUs.text.length != 0) percent += 4.7;
    if (drivingDocument.text.length != 0) percent += 4.7;
    if (resumeDocument.text.length != 0) percent += 4.7;
    if (additionalEditText.text.length != 0) percent += 4.7;
    if (medical.text.length != 0) percent += 4.7;
    print(percent);
    notifyListeners();
  }

  void getQualification() {
    var q = [];
    qualificationId = [];
    for (int j = 0; j < userList.length; j++) {
      for (int i = 0; i < listQualification.length; i++) {
        if (userList[j].qualification == listQualification[i].qualification) {
          listQualification[i].isvalue = true;
          q.add(listQualification[i].qualification.toString());
          qualificationId.add(listQualification[i].id.toString());
        }
      }
    }
    qualificationEditText.text =
        q.toString().replaceAll('[', '').replaceAll(']', '');
  }

  void getLanguages() {
    languagearray = [];
    for (int i = 0; i < userModel!.data!.language!.length; i++) {
      mutipleLanguage[userModel!.data!.language![i].toString()] = true;

      if (mutipleLanguage[userModel!.data!.language![i].toString()] = true) {
        languagearray.add(userModel!.data!.language![i].toString());
      }
    }

    languages.text = userModel!.data!.language!
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '');
  }

  void getSkill() {
    var q = [];
    skillId = [];
    for (int j = 0; j < skillData.length; j++) {
      for (int i = 0; i < listSkill.length; i++) {
        {
          if (skillData[j].skill == listSkill[i].skill) {
            listSkill[i].isValue = true;
            print(listSkill[i].skill.toString());
            q.add(listSkill[i].skill.toString());
            skillId.add(listSkill[i].id.toString());
          }
        }
      }
    }
    skillText.text = q.toString().replaceAll('[', '').replaceAll(']', '');
  }

  hitUserProfileUpdate(BuildContext context) async {
    var roleName = await getRoleInfo();
    Map<String, dynamic> map = {};
    updateloder = true;
    notifyListeners();
    var profileComplete = await getProfileComplete();
    roleName.toString().toUpperCase() == "DRIVER"
        ? DriverCalculatePercentage()
        : CalculatePercentage();
    roleName.toString().toUpperCase() == "DRIVER"
        ? map = {
            'userId': getid,
            'email': email.text,
            'firstName': firstName.text,
            'lastName': lastName.text,
            'personName': firstName.text + " " + lastName.text,
            'progressBar': percent.floor(),
            'profileComplete': true,
            'mobileNumber': mobile.text,
            'gender': valueItemSelected,
            'dateOfBirth': dateofbirth.text,
            'experience': valueExperience.toString().substring(0, 1),
            'maritalStatus': valueMaritalStatus,
            'workPlace': workplace.text,
            'designation': designation.text,
            'permAddress': permanentsaddress.text,
            'corrAddress': crosssaddress.text,
            'otherQualification': otherQualification(),
            'roleTitle': roleName,
            'skills': skillId,
            "monthsExperience": valueExpMonth.toString().substring(0, 1),
            'otherSkill': otherSkill(),
            'qualification': qualificationId,
            'language': languagearray,
            "aboutUser": aboutUs.text,
            'proImage': imageLogo == null
                ? image == null
                    ? null
                    : image
                : imageLogo,
            "bannerImage": imagebanner == null ? imageviewBanner : imagebanner,
            'documentArray': documentArray.length == 0 ? [] : documentArray
          }
        : map = {
            'userId': getid,
            'email': email.text,
            'firstName': firstName.text,
            'lastName': lastName.text,
            'personName': firstName.text + " " + lastName.text,
            'progressBar': percent.floor() == 99 ? 100 : percent.floor(),
            'profileComplete': true,
            'mobileNumber': mobile.text,
            'gender': valueItemSelected,
            'dateOfBirth': dateofbirth.text,
            'experience': valueExperience.toString().substring(0, 1),
            'otherQualification': otherQualification(),
            'maritalStatus': valueMaritalStatus,
            "monthsExperience": valueExpMonth.toString().substring(0, 1),
            'workPlace': workplace.text,
            'designation': designation.text,
            'permAddress': permanentsaddress.text,
            'corrAddress': crosssaddress.text,
            'roleTitle': roleName,
            'skills': skillId,
            'qualification': qualificationId,
            'otherSkill': otherSkill(),
            'language': languagearray,
            "aboutUser": aboutUs.text,
            'proImage': imageLogo == null
                ? image == null
                    ? null
                    : image
                : imageLogo,
            "bannerImage": imagebanner == null ? imageviewBanner : imagebanner,
          };

    print(map.toString());
    try {
      responseModel = await hitUserProfileUpdateApi(map);

      if (profileComplete == false) {
        NavigationPage(roleName);
      } else
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => UserProfileViewProvider(),
                    child:
                        UserProfileView(roleName.toString().toUpperCase()))));

      setProfileComplete(true);
      setProgressBar(percent.floor() == 99 ? 100 : percent.floor());
      showMessage(responseModel.message.toString());
      updateloder = false;
      setprofileInfo(imageLogo == null ? image : imageLogo);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      notifyListeners();
    }
    updateloder = false;
  }

//////upload Image

  getFromGallery(String type, BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (pickedFile != null) {
      // setState(() {
      imageFile = File(pickedFile.path);
      if (type == "COMPANYBANNER") {
        cropImage(pickedFile, "COMPANYBANNER", context);
      } else {
        cropImage(pickedFile, "PROFILEIMAGE", context);
        // imageUpload(imageFile, "PROFILEIMAGE", context);
      }
    }
  }

  imageUpload(File image, String type, BuildContext context) async {
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
        print(type);

        if (type == "COMPANYBANNER") {
          imagebanner = imageReal;
          userModel!.data!.bannerImage = imagebanner;
          showMessage(jsonData['message']);
          print("hello");
          notifyListeners();
        } else {
          imageLogo = imageReal;
          userModel!.data!.image = imageLogo;
          showMessage(jsonData['message']);
          print(imageLogo);
          notifyListeners();
        }
      }
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

  getImageUploadBannerShow(bool value) {
    ImageUploadShow = value;
    notifyListeners();
  }

  ////// set date
  startDateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(Duration(seconds: 1)),
        firstDate: DateTime(1950),
        lastDate: DateTime.now().add(Duration(days: 0)),
      );

  setStartDate(BuildContext context) async {
    final startDate = await startDateTime(context);

    if (startDate == null) return;

    this.startDate = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    if (DateTime.now().difference(startDate) <= Duration(days: 5840)) {
      showMessage(
        "User must be 16 or above",
      );
      dateofbirth.text = '';
      notifyListeners();
    } else {
      dateofbirth.text = formatterDate(startDate);

      notifyListeners();
    }
  }

  getDate(var startDate) {
    this.startDate = startDate;

    notifyListeners();
  }

  getvalueSharedPreferences() async {
    getName = await getNameInfo() ?? "";
    ProgressBar = await getProgressBar() ?? 1;

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

  getId() async {
    userId = await getUserId();
  }

  getFile(String typee) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      files = File(result.files.single.path.toString());
      var filePath = files!.path;
      var filename = result.files.single.name.toString();

      var fileExtension = files!.path.toString().split('.').last;
      //p.extension(files!.path.toString());

      if (fileExtension == "pdf" || fileExtension == "doc") {
        if (typee == "Driving License") {
          loaderDriverlicense = true;
          notifyListeners();
        } else if (typee == "Resume") {
          LoderResume = true;
          notifyListeners();
        } else if (typee == "Additional document") {
          loderAdditonalDocument = true;
          notifyListeners();
        } else if (typee == "DMV Medical Certificate") {
          LoderMedical = true;
          notifyListeners();
        }
        imageDocument(files!, fileExtension, filename, typee);
      } else {
        print("NotSupport");
      }
    } else {
      print("please  select  pdf");
    }
  }

  imageDocument(File? file, String? fileExtension, String? filename,
      String? typee) async {
    var url = SERVER_URL + '/api/v1/endUser/uploadDocs/';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      file!.readAsBytes().asStream(),
      file.lengthSync(),
      filename: filename,
      contentType: new MediaType('application', fileExtension!),
    ));
    request.fields.addAll({"height": "300", "width": "300"});
    print("request: " + request.toString());
    var response = await request.send();
    print(response.statusCode);

    if (response.statusCode == 200) {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);

      print(fileExtension);

      if (jsonData['data'] == null) {
      } else {
        switch (typee) {
          case 'Driving License':
            documentArray.remove(driverMap);
            driverMap['name'] = 'Driving License';
            driverMap['fileName'] = jsonData['data'];
            drivingDocument.text = jsonData['data'];
            documentArray.add(driverMap);
            loaderDriverlicense = false;
            notifyListeners();
            break;
          case 'Additional document':
            documentArray.remove(addtionDocumentMap);
            addtionDocumentMap['name'] = 'Additional document';
            addtionDocumentMap['fileName'] = jsonData['data'];
            additionalEditText.text = jsonData['data'];

            documentArray.add(addtionDocumentMap);
            loderAdditonalDocument = false;
            notifyListeners();
            break;
          case 'Resume':
            documentArray.remove(resumeMap);
            resumeMap['name'] = 'Resume';
            resumeMap['fileName'] = jsonData['data'];
            resumeDocument.text = jsonData['data'];
            documentArray.add(resumeMap);
            LoderResume = false;
            notifyListeners();
            break;
          case 'DMV Medical Certificate':
            documentArray.remove(medicalCertificateMap);
            medicalCertificateMap['name'] = 'DMV Medical Certificate';
            medicalCertificateMap['fileName'] = jsonData['data'];
            medical.text = jsonData['data'];
            documentArray.add(medicalCertificateMap);
            LoderMedical = false;
            notifyListeners();
            break;
        }

        print(documentArray);
        notifyListeners();
      }
    } else {
      print("kkk");
    }
  }

  checkRoleName() async {
    roleName = await getRoleInfo();
  }

  getdocumentView(Data userProfile) {
    if (userProfile.documents!.length != 0) {
      for (int i = 0; i < userProfile.documents!.length; i++) {
        switch (userProfile.documents![i].name) {
          case ("Resume"):
            resumeMap["fileName"] =
                userProfile.documents![i].fileName.toString();
            resumeMap['name'] = userProfile.documents![i].name.toString();
            resumeDocument.text = userProfile.documents![i].fileName.toString();
            documentArray.add(resumeMap);
            break;
          case ("Additional document"):
            addtionDocumentMap["fileName"] =
                userProfile.documents![i].fileName.toString();
            addtionDocumentMap['name'] =
                userProfile.documents![i].name.toString();
            additionalEditText.text =
                userProfile.documents![i].fileName.toString();

            additionalEditText.text =
                userProfile.documents![i].fileName.toString();

            documentArray.add(addtionDocumentMap);
            break;

          case ("DMV Medical Certificate"):
            medicalCertificateMap['name'] =
                userProfile.documents![i].name.toString();
            medicalCertificateMap['fileName'] =
                userProfile.documents![i].fileName.toString();
            medical.text = userProfile.documents![i].fileName.toString();
            medical.text = userProfile.documents![i].fileName.toString();
            medical.text = userProfile.documents![i].fileName.toString();
            documentArray.add(medicalCertificateMap);
            break;
          case ("Driving License"):
            driverMap['name'] = userProfile.documents![i].name.toString();
            driverMap["fileName"] =
                userProfile.documents![i].fileName.toString();
            drivingDocument.text =
                userProfile.documents![i].fileName.toString();
            drivingDocument.text =
                userProfile.documents![i].fileName.toString();
            documentArray.add(driverMap);
            break;
        }
      }
    } else {
      resumeDocument.text = '';
      drivingDocument.text = '';
      additionalEditText.text = "";
      aboutUs.text = "";
      medical.text = "";
    }
    print(documentArray);
  }

  NavigationPage(roleName) {
    switch (roleName.toString().toUpperCase()) {
      case "COMPANY":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Company', 0)),
            (Route<dynamic> route) => false);

        break;

      case "ENDUSER":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('User', 0)),
            (Route<dynamic> route) => false);

        break;
      case "DISPATCHER":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => BottomMenu('Dispatcher', 0)),
            (Route<dynamic> route) => false);

        break;

      case "SELLER":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Seller', 0)),
            (Route<dynamic> route) => false);
        break;
      case "DRIVER":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Driver', 0)),
            (Route<dynamic> route) => false);
        break;
      case "HR":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => BottomMenu('Hr', 0)),
            (Route<dynamic> route) => false);
        break;
      case "SALESPERSON":
        Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => BottomMenu('Saleperson', 0)),
            (Route<dynamic> route) => false);
        break;
    }
  }

  otherQualification() {
    var qualification;
    for (int i = 0; i < qualificationId.length; i++) {
      if (qualificationId[i] == "12345") {
        return qualification = educationQualification.text;
      } else
        return qualification = "";
    }
    return qualification;
  }

  otherSkill() {
    var qualification;
    for (int i = 0; i < skillId.length; i++) {
      if (skillId[i] == "123456") {
        print(skillId[i] + "ewyt56565656757");
        return qualification = marriedStatus.text;
      } else
        return qualification = "";
    }
    return qualification;
  }
}
