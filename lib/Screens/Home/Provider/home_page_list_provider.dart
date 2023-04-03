import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../AppUtils/data_items.dart';
import '../../../Model/NotificationModel/NotificationModel.dart';
import '../../../Model/account_detail_Model.dart';

class HomePageListProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false,
      paginationLoading = false;
  String? commentId;
  bool? check;
  late ResponseModel responseModel;
  late AccountDetailsModel accountDetailsModel;
  var s = '';
  bool sharePostLoder = false;
  late NotificationModel _notificationModel;
  int totalCount = 0;
  String? name;
  String? image;

  setContext(BuildContext context) {
    this.context = context;
  }

  getUserDetail() async {
    name = await getNameInfo();
    image = await getprofileInfo();
    notifyListeners();
  }

  String message = '';
  PostListModel _postModel = PostListModel();
  List<PostItem> _list = [];

  PostListModel get postModel => _postModel;

  List<PostItem> get list => _list;

  getPosts(Map<String, dynamic> map, pagination) async {

    if (pagination == false) {
      _list = [];

      loading = true;
    } else {
      paginationLoading = true;
    }

    notifyListeners();

    try {
      _postModel = await hitGetPosts(map);
      _list.addAll(_postModel.data!);

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      // showMessage(
      //   message,
      // );
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    paginationLoading = false;
  }

  postDelete(Map<String, dynamic> map,
      pos,
      HomePageListProvider listProvider,) async {
    print(map);
    try {
      responseModel = await hitDeletePost(map);
      listProvider.list.removeAt(pos);
      listProvider.refresh();
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }
  }

  sharePost(Map<String, dynamic> map) async {
    print(map);
    sharePostLoder = true;
    notifyListeners();

    try {
      var res = await hitSharePost(map);
      refresh();
      sharePostLoder = false;

      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      sharePostLoder = false;
      print(e.toString());
    }
  }

  postReport(Map<String, dynamic> map,
      int position,
      HomePageListProvider listProvider,) async {
    print(map);
    try {
      ResponseModel res = await hitPostReport(map);
      listProvider.list.removeAt(position);
      listProvider.refresh();
      showMessage(
        res.message.toString(),
      );
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
    }
  }

  void resetBookings() {
    _list = [];
  }

  void refreshser(val) {
    list[val].caption = '';
    notifyListeners();
  }

  Future<void> refresh() async {
    var getid = await getUserId();
    resetBookings();
    getPosts({
      "userId": getid,
      "count": 10,
      "page": 1,
      //"type": "Connections"
    }, false);
  }

  setCommentId(String commentId) {
    this.commentId = commentId;

    print(commentId);
  }

  setCheckRecomment(bool check) {
    this.check = check;
    print(check);
  }

  getAccountDetail() async {
    var roleName = await getRoleInfo();
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "isReaded": false,
      "accessLevel": roleName.toString().toUpperCase(),
      "userId": getid,
      "role": roleName.toString().toUpperCase(),
    };

    try {
      accountDetailsModel = await hitAccountInformationApi(map);

      totalCount = accountDetailsModel.data!.unreadCount!.toInt();
      saveData(
          accountDetailsModel.data!.companyName == null
              ? capitalize(
              accountDetailsModel.data!.userInfo!.firstName.toString() +
                  ' ' +
                  accountDetailsModel.data!.userInfo!.lastName.toString())
              : accountDetailsModel.data!.companyName.toString(),
          accountDetailsModel.data!.userInfo!.image.toString());
      checkPlan(accountDetailsModel.data!.userInfo!.planData);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');

      print(e.toString());
      notifyListeners();
    }
  }

  checkPlan(List<PlanData>? planData) {
    if (planData!.length != 0) {
      for (int i = 0; i < planData.length; i++) {
        for (int j = 0; j < planData[i].features!.length; j++) {

          if (planData[i].features![j].constName == "NOOFEVENTS") {
            setEventPlanData(true);
            setCreateEvent(planData[i].features![j].keyValue!.toInt());

            break;
          } else {
            if (planData[i].features![j].constName == "NOOFEVENTS")
              setEventPlanData(false);
          }
          if (planData[i].features![j].constName == "WEATHER") {
            setWeatherPlanData(true);
            setWeatherValue(planData[i].features![j].keyValue!.toInt());
            break;
          } else {
            if (planData[i].features![j].constName == "WEATHER")
              setWeatherPlanData(false);
          }
          if (planData[i].features![j].constName == "NOOFTRIPS") {
            setGpsPlanData(true);
            break;
          } else {
            if (planData[i].features![j].constName == "NOOFTRIPS")
              setGpsPlanData(false);
          }
        }
      }
      setplanDate(true);
    } else {
      setplanDate(false);
    }
  }

  void saveData(String? name,
      String? profileImg,) {
    setNameInfo(name);
    setprofileInfo(profileImg);
  }

  removeAllSharedPrefrerencesData() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    await prefrences.remove("name");
  }

  void setCount(int totalCount) {
    this.totalCount = totalCount;
    notifyListeners();

    print(totalCount);
  }


}
