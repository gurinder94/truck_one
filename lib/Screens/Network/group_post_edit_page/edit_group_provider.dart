import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_detail_list.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/my_groups_provider.dart';
import 'package:provider/provider.dart';

import '../My_Group_List/groups_list_page.dart';

class EditGroupProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;
  bool updateLoading = false;
  String? visibility;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<String> visual = ['Public', 'Private'];
  String profileImage = '',
      coverImage = '';
  setContext(BuildContext context) {
    this.context = context;
  }

  GroupDetailsList? groupDetailsList;
  String message = '';
  ResponseModel _model = ResponseModel();

  ResponseModel get model => _model;

  updateGroup(Map<String, dynamic> map) async {
    updateLoading = true;
    notifyListeners();
    print(map);
    try {
      _model  = await hitUpdateGroup(map);
      updateLoading=false;
      notifyListeners();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChangeNotifierProvider(
                    create: (context) => MyGroupsProvider(),
                    child: GroupsListPage(),
                  )));

    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }
  setDate(GroupDetailsList? groupDetailsList)
  {
    title.text=groupDetailsList!.data!.name.toString();
    description.text=groupDetailsList.data!.description.toString();
    visibility=groupDetailsList.data!.type.toString();
    coverImage=groupDetailsList.data!.coverImage.toString();
    profileImage=groupDetailsList.data!.groupImage.toString();


    notifyListeners();

  }
  getGroupdetails(String? groupId) async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "groupId": groupId,
      'userId': getid,
    };

    loading = true;
    notifyListeners();
    print(map);
    try {
      groupDetailsList = await hitGroupDetail(map);
      setDate(groupDetailsList);
      loading = false;
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message, context);
      print(e.toString());
      notifyListeners();
    }

  }

  setVisiblity(String? value) {
    visibility = value!;
    notifyListeners();
  }

  void showMessage(String msg, context) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


}
