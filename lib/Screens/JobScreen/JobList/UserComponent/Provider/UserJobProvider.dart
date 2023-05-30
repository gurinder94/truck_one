import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/JobModel/Industry_list_model.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobListModel.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/qualificationModel.dart';

class UserJobProvider extends ChangeNotifier {
  bool jobListLoad = true;
  bool jobViewApplicants = false;
  JobListModel? jobListModel;
  QualificationModel? qualificationModel;
  List qualificationList = [];
  List industryList = [];
  IndustryList? industryListModel;
  TextEditingController searchEditingController = TextEditingController();
  bool paginationLoading = false;
  JobModel jobModel = JobModel();
  List<JobModel> jobList = [];
  List<JobModel> SaveJoblist = [];
  List<JobModel> jobAppliedList = [];
  String? message = " ";
  File? files;
  int menuClick = 0;
  List<AutocompletePrediction> predictions = [];
  TextEditingController addressController = TextEditingController();
  double? Longitude;
  double? Latitude;

  setMenuClick(int pos) {
    menuClick = pos;
    print(pos);
    notifyListeners();
  }

  hitUserGetJobList(
    BuildContext context,
    String Search,
    bool pagination,
    int pagee,
  ) async {

    var getId=await getUserId();
    Map<String, dynamic> map = {
      'isActive': "true",
      "educationChks": qualificationList,
      "industryChks": industryList,
      "searchKey":  Search,
      'page': pagee,
      "fullAddress":addressController.text,
      "lat": Latitude,
      'userId': getId,
      "lng": Longitude,
    };
    if (pagination)
      paginationLoading = true;
    else
      jobListLoad = true;


    notifyListeners();

    try {
      print(map);
      jobListModel = await hitCompanyJobListApi(map);
      jobList.addAll(jobListModel!.data!);
      print(jobList.length);


      jobListLoad = false;
      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
    paginationLoading = false;
  }

  hitSaveJobList(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    jobListModel = null;
    Map<String, dynamic> map = {
      'userId': getId,
      'isActive': "true",
    };

    jobListLoad = true;
    notifyListeners();
    print(map);
    try {
      jobListModel = await hitJobSaveListApi(map);
      jobListLoad = false;
      SaveJoblist.addAll(jobListModel!.data!);
      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  hitAppliedJobList(
    BuildContext context,
  ) async {
    var getId = await getUserId();
    jobListModel = null;
    Map<String, dynamic> map = {
      'userId': getId,
    };

    jobListLoad = true;
    notifyListeners();
    print(map);
    try {
      jobListModel = await hitJobAppliedJobsListApi(map);
      jobAppliedList.addAll(jobListModel!.data!);
      jobListLoad = false;
      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  resetJobList()
  {
    jobList=[];
    notifyListeners();

  }

  resetvalue() {
    qualificationList = [];
    industryList = [];
    for (int i = 0; i < qualificationModel!.data!.length; i++) {
      if (qualificationModel!.data![i].isvalue == true) {
        qualificationModel!.data![i].isvalue = false;
        notifyListeners();
      }
    }
    for (int i = 0; i < industryListModel!.data!.length; i++) {
      if (industryListModel!.data![i].isValue == true) {
        industryListModel!.data![i].isValue = false;
        notifyListeners();
      }
    }
    searchEditingController.text = '';
    addressController.text='';
    resetAddressList();

  }

  resetList() {
    qualificationList = [];
    industryList = [];
    jobList = [];
  }

  hitgetQualification() async {
    Map<String, dynamic> map = {"isActive": "true", "isDeleted": "false"};

    print(map);
    try {
      qualificationModel = await hitGetQualificationApi(map);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  hitgetIndustry() async {
    Map<String, dynamic> map = {"isActive": "true", "isDeleted": "false"};

    print(map);
    try {
      industryListModel = await IndustryListApi(map);

      notifyListeners();
    } on Exception catch (e) {
      jobListLoad = false;
      message = e.toString().replaceAll('Exception:', '');
      print(message);
      print(e.toString());
      notifyListeners();
    }
  }

  refeshList() {
    SaveJoblist;
    notifyListeners();
  }
resetAddressList()
{
  predictions=[];
  notifyListeners();
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

      print(predictions[0].placeId);
      print(predictions.length);
      notifyListeners();
    }
  }

  Future handleSearch(var query) async {
    predictions = [];
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


          notifyListeners();
        });
      } on Exception catch (e) {
        print(e);
      }
    } else {

      notifyListeners();
    }
  }
}
