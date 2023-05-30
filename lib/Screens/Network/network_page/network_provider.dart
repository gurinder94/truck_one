import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import '../../../Model/NetworkModel/group_invitation_model 2.dart';
import '../../../Model/NetworkModel/job_invitation_model 2.dart';
import '../../../Model/NetworkModel/recommandation_model 2.dart';

class NetworkProvider extends ChangeNotifier {
  int _tabEnable = 0;

  int get tabEnable => _tabEnable;
  ResponseModel? responseModel;
  var getRole;
  void setRecommendationTab(
    int val,
  ) {
    _tabEnable = val;
    notifyListeners();
  }

  late BuildContext context;
  bool loading = true, paginationLoading = false, groupInvitationLoding = false;

  setContext(BuildContext context) {
    this.context = context;
  }

  String message = '';
  RecommendationModel _model = RecommendationModel();

  RecommendationModel get model => _model;
  GroupInvitationModel _groupInvitationModel = GroupInvitationModel();

  GroupInvitationModel get groupInvitationModel => _groupInvitationModel;
  List<PersonInfo> _list = [];

  List<PersonInfo> get list => _list;
  List<GroupInfo> _groupInfoList = [];

  List<GroupInfo> get groupInfoList => _groupInfoList;
  bool t = false;
  late JobInvitationModel jobInvitationModel;
  List<Datum> JobInvitationlist = [];

  connectUser(
    Map<String, dynamic> map,
    BuildContext context,
    NetworkProvider provider,
    int index,
  ) async {
    groupInvitationLoding=true;
    notifyListeners();

    try {
      var getid = await getUserId();
      ResponseModel model = await hitConnectPeople(map);

      provider.list.removeAt(index);
      groupInvitationLoding=false;

      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
      notifyListeners();
    }
    groupInvitationLoding=false;
    loading = false;
  }

  removeConnectionList(NetworkProvider provider,
      int index,)
  {
    provider.list.removeAt(index);
    notifyListeners();
  }

  getRecommendations(Map<String, dynamic> map, bool pagination, val) async {
    if (pagination)
      paginationLoading = true;
    else {
      _list=[];
      loading = true;
    }

    notifyListeners();
    try {
      _model = await hitGetRecommendations(map);
      _list.addAll(_model.data!);
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(
        message,
      );
      print(e.toString());
      notifyListeners();
    }
    paginationLoading = false;
    loading = false;
  }

  getGroupInvitation(Map<String, dynamic> map) async {
    loading = true;
    notifyListeners();

    reset();
    try {
      _groupInvitationModel = await hitGetGroupInvitationApi(map);
      _groupInfoList.addAll(_groupInvitationModel.data!);
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
  }

  getInviteAccept(Map<String, dynamic> map, BuildContext context,
      NetworkProvider provider, int i, int index) async {

    try {
      if (i == 2)
        provider.groupInfoList.removeAt(index);
      else
        provider.list.removeAt(index);
      responseModel = await hitInviteAcceptApi(map);
      showMessage(responseModel!.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(responseModel!.message.toString());
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  getJobInvitation(Map<String, dynamic> map) async {

    loading = true;
    notifyListeners();
    reset();
    try {
      jobInvitationModel = await hitGetJobInvitationApi(map);
      JobInvitationlist=[];
      JobInvitationlist.addAll(jobInvitationModel.data!);

      print(JobInvitationlist.length);
      showMessage(jobInvitationModel.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  getInviteDecline(
    Map<String, dynamic> map,
    int index,
    NetworkProvider provider,
    int i,
  ) async {
    loading = true;
    notifyListeners();

    print(map);
    try {
      if (i == 2)
        provider.groupInfoList.removeAt(index);
      else
        provider.list.removeAt(index);

      responseModel = await hitInviteDeclineApi(map);
      showMessage(responseModel!.message.toString());
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message);
      print(e.toString());
      notifyListeners();
    }
    loading = false;
  }

  void reset() {
    _list = [];
    _groupInfoList=[];
    JobInvitationlist=[];
    notifyListeners();
  }

  void s(bool value) {
    t = value;
    notifyListeners();
  }

  onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  checkrole() async {
    getRole = await getRoleInfo();
    notifyListeners();
    print(getRole);
  }
}
