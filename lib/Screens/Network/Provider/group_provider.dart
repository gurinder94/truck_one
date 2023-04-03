import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';

class GroupProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = true, paginationLoading = true;
  String? gId;
  bool flag = true;

  late ResponseModel _responseModel;
  var userImage;
  var userName;

  setContext(BuildContext context, String gId) {
    this.context = context;
    this.gId = gId;
  }

  int pagee = 1;
  String? getId;
  ScrollController scrollController = new ScrollController();
  String message = '';
  GroupModel _model = GroupModel();
  List<PostDatum> _list = [];

  List<PostDatum> get list => _list;

  GroupModel get model => _model;

  getGroupDetail(String gId, bool paginationValue, int pagee) async {
    getId = await getUserId();
    Map<String, dynamic> map = {
      "groupId": gId,
      "userId": getId,
      "page": pagee,
    };
    if (paginationValue == true)
      paginationLoading = true;
    else {
      loading = true;
    }

    notifyListeners();
    print(map);
    try {
      _model = await hitOpenGroup(map);
      list.addAll(_model.data!.postData!);
      loading = false;
      getUserData();
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
      notifyListeners();
    }
    loading = false;
    paginationLoading = false;
  }

  groupPostDelete(
    Map<String, dynamic> map,
    pos,
    GroupProvider groupProvider,
    PostDatum data,
    String id,
  ) async {
    print(map);
    try {
      print("message");
      ResponseModel res = await hitDeletePost(map);

      groupProvider.list.removeAt(pos);
      Navigator.pop(context);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
    }
  }

  hitGroupJoin(
    Map<String, dynamic> map,
  ) async {
    print(map);
    try {
      print("message");
      ResponseModel res = await JoinGroupApi(map);

      showMessage(res.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
    }
  }

  refresh() async {
    list.clear();
    notifyListeners();

    getGroupDetail(gId!, false, 1);
  }

  checkDescription(bool value) {
    flag = value;
    notifyListeners();
  }

  getUserData() async {
    userImage = await getprofileInfo();
    userName = await getNameInfo();
  }

  ref(pos) {
    list.removeAt(pos);
    notifyListeners();
  }

  groupPostReport(Map<String, dynamic> map) async {
    print(map);
    try {
      ResponseModel res = await hitPostReport(map);
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

  hitgroupAction(Map<String, dynamic> map) async {
    print(map);
    try {
      ResponseModel res = await groupActionApi(map);
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

  hitgroupPrivateRequest(Map<String, dynamic> map) async {
    print(map);
    try {
      ResponseModel res = await groupPrivateRequestApi(map);
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

  changeNamebutton(String status) {
    model.data!.status = status;
    print(model.data!.status);
    notifyListeners();
  }

  getInviteAccept(Map<String, dynamic> map) async {
    print(map);
    try {
      ResponseModel responseModel = await hitInviteAcceptApi(map);
      showMessage(responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  addScrollListener(BuildContext context, String gId) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pagee = pagee + 1;
        if (model.data!.postData!.length == 0) {
        } else {
          pagnationList(context, pagee, gId);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  pagnationList(BuildContext context, int pagee, String gId) async {
    getGroupDetail(gId, true, pagee);
  }

  getInviteDecline(
    Map<String, dynamic> map,
  ) async {
    print(map);
    try {
      ResponseModel responseModel = await hitInviteDeclineApi(map);
      showMessage(responseModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
  }

  restPage(int page) {
    pagee = page;
  }
//
// refreshGroupViewList()
// async {
//   list=[];
//   getId = await getUserId();
//   Map<String, dynamic> map = {
//     "groupId": gId,
//     "userId": getId,
//     "page":1,
//   };
//
//     loading = true;
//
//
//   notifyListeners();
//   print(map);
//   try {
//     _model = await hitOpenGroup(map);
//     list.addAll(_model.data!.postData!);
//     loading = false;
//     getUserData();
//     notifyListeners();
//   } on Exception catch (e) {
//     message = e.toString().replaceAll('Exception:', '');
//     showMessage(
//       message,
//     );
//     print(e.toString());
//     notifyListeners();
//   }
//   loading = false;
//
// }

}
