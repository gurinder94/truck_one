import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:provider/provider.dart';
import '../../My_Group_List/groups_list_page.dart';
import '../../Provider/my_groups_provider.dart';

class CreateGroupProvider extends ChangeNotifier {
  late BuildContext context;
  bool loading = false;
  String? visibility;

  List<String> visual = ['Public', 'Private'];

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  ResponseModel _model = ResponseModel();

  ResponseModel get model => _model;

  createGroup(Map<String, dynamic> map) async {
    loading = true;
    notifyListeners();
    print(map);
    try {
      _model = await hitCreateGroup(map);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                    create: (context) => MyGroupsProvider(),
                    child: GroupsListPage(),
                  )));
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  setVisiblity(String? value) {
    visibility = value!;
    notifyListeners();
  }
}
