import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobViewList.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/UserModel.dart';

import '../../../../Model/NetworkModel/normal_response.dart';
import '../../../BottomMenu/bottom_menu.dart';

class JobApplyProvider extends ChangeNotifier {
  bool _loading = false;
  String? message = " ";
  var filePath, extension;
  var userId;
  late BuildContext context;
  late JobListDetailModel _jobModel;
  Map<String, dynamic> driverMap = {};
  Map<String, dynamic> addtionDocumentMap = {};
  Map<String, dynamic> medicalCertificateMap = {};

  JobListDetailModel get jobModel => _jobModel;
  File? files;
  TextEditingController pdfTextEditing = TextEditingController();
  TextEditingController descriptionTextEditing = TextEditingController();
  late UserModel userModel;
  bool applyLoder = false;

  get loading => _loading;
  bool check = false;
  late List<Document> documentDriverList = [];
  var uploadDocument = [];

  hitApplyJob(
    String? id,
    userId,
    String companyId,
    String title,
  ) async {
    print(id);
    applyLoder = true;
    notifyListeners();
    var userName = await getNameInfo();
    Map<String, dynamic> map = {
      'jobId': id,
      'resume': pdfTextEditing.text,
      'description': descriptionTextEditing.text,
      'userId': userId,
      "driverDocuments": uploadDocument,
      "companyId": companyId,
      "jobTitle": title,
      "applicantName": userName,
      "userName": userName,
    };
    print(map);

    try {
      ResponseModel responseModel = await hitApplyJobApi(map);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomMenu('User', 2)),
          (Route<dynamic> route) => false);
      showMessage(responseModel.message);
      uploadDocument = [];
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      print(message);
      showMessage(message.toString());
      print(e.toString());
      notifyListeners();
    }
    applyLoder = false;
  }

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );
    if (result != null) {
      files = File(result.files.single.path.toString());
      var filePath = files!.path;
      var name = result.files.single.name.toString();

      var fileExtension = files!.path.toString().split('.').last;
      // p.extension(files!.path.toString());

      final extension = files!.path.split(".").last;
      print("fileExtension---" + extension);

      if (fileExtension == "pdf" || fileExtension == "doc") {
        fileExtension = (filePath.split('/').last);

        print("File Path Select---" + files!.path);

        print("fileExtension---" + extension);
        print(files!.path.toString());
        imageUpload(files!, extension, name);
      } else {
        showMessage("File not support");
        print(" NotSupport");
      }
    } else {
      return;
    }
  }

  checkValue(bool value) {
    check = value;
    notifyListeners();
  }

  imageUpload(File file, String? type, String name) async {
    _loading = true;
    notifyListeners();
    print(file);

    print(type);
    var url = SERVER_URL + '/api/mobile/user/resume';
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.files.add(http.MultipartFile(
      'file',
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last,
      contentType: new MediaType('file', type!),
    ));
    request.fields.addAll({"type": '$type', "height": "300", "width": "300"});
    print("request: " + request.toString());
    var response = await request.send();
    print(response.request);
    print(response.statusCode);

    if (response.statusCode == 200) {
      String value = await utf8.decoder.bind(response.stream).join();
      var jsonData = json.decode(value);
      print('image $value');
      print(jsonData['data']);
      if (jsonData['data'] == null) {
      } else {
        var imageReal = jsonData['data']['fullPath'].toString();

        // setState(
        //       () =>
        // imageUrl = SERVER_URL +
        //     '/api/v1/event/uploads/profile/thumbnail/' +
        //     imageReal;
        // );
        _loading = false;
        notifyListeners();
        String imageLogo = imageReal;
        pdfTextEditing.text = imageLogo;

        print(imageLogo);
        _loading = false;
        // });

      }
    }
  }

  hitUserProfileDetails(BuildContext context) async {
    documentDriverList = [];
    var getId = await getUserId();
    {
      Map<String, dynamic> map = {
        'endUserId': getId.toString(),
      };

      print(map);
      notifyListeners();
      print(map);
      try {
        userModel = await hitUserProfileApi(map);

        documentDriverList.addAll(userModel.data!.documents!);

        notifyListeners();
      } on Exception catch (e) {
        message = e.toString().replaceAll('Exception:', '');
        showMessage(message!);

        notifyListeners();
      }
    }
  }

  void setContext(BuildContext context) {
    this.context = context;
  }
// getId() async {
//   userId = await getUserId();
// }
}
