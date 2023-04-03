import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/LoginListModel.dart';
import 'package:my_truck_dot_one/Model/switch_user_model.dart';
import 'package:my_truck_dot_one/Screens/BottomMenu/bottom_menu.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Component/select_mutiple_role.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Component/term_condition.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/Provider/term_condition_provider.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/CompanyProfile.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Userprofile.dart';
import 'package:my_truck_dot_one/Screens/SignUpScreen/SignUp_otp_Screen/Signupotp.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/chat_socket_connection.dart';
import '../../SignUpScreen/Provider/otp_provider.dart';
import '../../commanWidget/Comman_Alert_box.dart';

class LoginProvider extends ChangeNotifier {
  bool _loading = false;
  bool mutipleroleLoder = false;
  String? message = " ";
  bool obscureText = false;
  String? code = "0";
  String? resetkey;
  List<Role> mutipleRole = [];

  get loading => _loading;
  late LoginListModel _loginListModel;
  late SwitchUserModel switchUserModel;

  LoginListModel get loginListModel => _loginListModel;
  var name,
      rolename,
      companyName,
      profileImg,
      profileComplete,
      ProgressBar,
      created,
      roleId,
      policyStatus,
      wifiIP,
      id,
      create;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  late ChatSocketConnection _chatSocketConnection;
  var checkBoxValue = false;

  hitLogin(BuildContext context, double? lat, double? long,
      LoginProvider loginProvider) async {
    mutipleRole = [];
    var getId = await getUserId();
    var token = await getFireBaseToken();

    print(token);
    var date = new DateTime.now();
    Map<String, dynamic> map = {
      "email": email.text,
      "password": password.text,
      'deviceType': deviceType,
      'deviceId': deviceId,
      'deviceName': deviceName,
      'deviceVersion': deviceVersion,
      'deviceModel': deviceModel,
      'date': date.toString(),
      'deviceToken': token,
      // 'lat':lat,
      // 'lng':long,
      'clientIp': wifiIP,
      'source': deviceName + ' ' + 'and' + ' ' + deviceVersion,
    };
    _loading = true;
    notifyListeners();
    print(map);
    try {
      _loginListModel = await hitLoginApi(map);
      notifyListeners();
      if (_loginListModel.code == 403) {
        resetkey = loginListModel.data!.resetkey;
        hitchecktoken(context);
      } else if (_loginListModel.code == 200 || _loginListModel.code == 407) {
        _chatSocketConnection = context.read<ChatSocketConnection>();

        message = loginListModel.message.toString();

        id = _loginListModel.data!.id.toString();
        rolename = _loginListModel.data!.accessLevel.toString();
        companyName = _loginListModel.companyName;
        policyStatus = _loginListModel.data!.policyStatus;

        name = companyName == ''
            ? _loginListModel.data!.firstName! +
                ' ' +
                _loginListModel.data!.lastName.toString()
            : companyName;
        profileImg = _loginListModel.data!.image;
        profileComplete = _loginListModel.data!.profileComplete;
        ProgressBar = _loginListModel.data!.progressBar!.floor();
        created = _loginListModel.data!.companyId;

        roleId = _loginListModel.data!.roleId!.id.toString();

        mutipleRole.addAll(_loginListModel.roles!);
        checkPlan(_loginListModel.data!.planData);

        if (mutipleRole.length > 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => OtpProvider(),
                      child: MutipleRoleSelected(
                          mutipleRole, roleId, loginProvider, id))));
        } else {
          _chatSocketConnection.send('join-conversation', {'loggedInUser': id});
          _chatSocketConnection.send("login", id);

          setProgressBar(ProgressBar == null ? 0 : ProgressBar.floor());

          saveData(id, rolename, name, profileImg, profileComplete, created,
              loginListModel.data!.defaultLanguage!, policyStatus);

          switch (loginListModel.data!.accessLevel) {
            case ("COMPANY"):
              if (policyStatus == false)
                showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => TermConditionProvider(
                              loginListModel.data!.email!,
                            ),
                        child: TermsCondition())).then((value) {
                  removeData();
                });
              else if (profileComplete == false)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (_) => ProfileProvider(),
                            child: CompanyProfile(false))));
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Company', 0)),
                    (Route<dynamic> route) => false);
              break;
            case ("ENDUSER"):
              if (policyStatus == false)
                showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => TermConditionProvider(
                              loginListModel.data!.email!,
                            ),
                        child: TermsCondition())).then((value) {
                  removeData();
                });
              else if (profileComplete == false)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUser(false)));
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('User', 0)),
                    (Route<dynamic> route) => false);
              break;
            case ("DISPATCHER"):
              if (profileComplete == false)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUser(false)));
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Dispatcher', 0)),
                    (Route<dynamic> route) => false);

              break;
            case ("SELLER"):
              if (profileComplete == false)
                DialogUtils.AlertBox(
                  context,
                  onDoneFunction: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false);
                  },
                  oncancelFunction: () => Navigator.pop(context),
                  title: 'Profile Complete!',
                  buttonTitle: "yes",
                  alertTitle:
                      "Kindly fill your profile before proceeding further.",
                );
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Seller', 0)),
                    (Route<dynamic> route) => false);
              break;
            case ("HR"):
              if (policyStatus == false)
                showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => TermConditionProvider(
                              loginListModel.data!.email!,
                            ),
                        child: TermsCondition())).then((value) {
                  removeData();
                });
              else if (profileComplete == false)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUser(false)));
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Hr', 0)),
                    (Route<dynamic> route) => false);
              break;
            case ("DRIVER"):
              if (policyStatus == false)
                showDialog(
                    context: context,
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => TermConditionProvider(
                              loginListModel.data!.email!,
                            ),
                        child: TermsCondition())).then((value) {
                  removeData();
                });
              else if (profileComplete == false)
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileUser(false)));
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Driver', 0)),
                    (Route<dynamic> route) => false);
              break;

            case ("SALESPERSON"):
              if (profileComplete == false)
                DialogUtils.AlertBox(
                  context,
                  onDoneFunction: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false);
                  },
                  oncancelFunction: () => Navigator.pop(context),
                  title: 'Profile Complete!',
                  buttonTitle: "yes",
                  alertTitle:
                  "Kindly fill your profile before proceeding further.",
                );
              else
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => BottomMenu('Saleperson', 0)),
                    (Route<dynamic> route) => false);
              break;
            default:
              print("Plz Check profile");
          }
        }
      }

      _loading = false;
      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');

      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }

    _loading = false;
  }

  Future<void> getNetworkInfo() async {
    final info = NetworkInfo();
    wifiIP = await info.getWifiIP();
  }

  // reset inputfield
  void Reset() {
    email.text = "";
    password.text = "";
  }

//check
  hitchecktoken(BuildContext context) async {
    var res;

    Map<String, dynamic> map = {
      'token': resetkey,
    };
    _loading = true;
    notifyListeners();
    print(map);
    try {
      res = await hitCheckToken(map);
      _loading = false;
      notifyListeners();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (_) => OtpProvider(), child: SignUpOtp(resetkey!))));
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginScreen()));
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
  }

// mutiple  role Api
  hitMutipleRole(String roleId, String? newRoleId, String? newRoleName,
      BuildContext context, String id) async {
    Map<String, dynamic> map = {
      "oldRoleId": roleId,
      "roleId": newRoleId,
      "roleTitle": newRoleName!.toUpperCase(),
      "userId": id,
    };
    mutipleroleLoder = true;
    notifyListeners();
    print(map);
    try {
      _chatSocketConnection = context.read<ChatSocketConnection>();

      switchUserModel = await hitSwitchUserApi(map);

      if (switchUserModel.code == 200) {
        message = switchUserModel.message.toString();

        var id = switchUserModel.data!.userInfo!.id.toString();

        var rolename = switchUserModel.data!.userInfo!.accessLevel
            .toString()
            .toUpperCase();
        name = switchUserModel.data!.companyName == null
            ? switchUserModel.data!.userInfo!.firstName.toString() +
                ' ' +
                switchUserModel.data!.userInfo!.lastName.toString()
            : switchUserModel.data!.companyName;
        create = switchUserModel.data!.companyId;

        profileImg = switchUserModel.data!.userInfo!.image;
        profileComplete = switchUserModel.data!.userInfo!.profileComplete;
        ProgressBar = switchUserModel.data!.userInfo!.progressBar;
        setProgressBar(ProgressBar == null ? 0 : ProgressBar.floor());
        saveData(id, rolename, name, profileImg ?? '', profileComplete, create,
            switchUserModel.data!.userInfo!.defaultLanguage!, policyStatus);

        checkMutiplePlan(switchUserModel.data!.userInfo!.planData);
        _chatSocketConnection.send('join-conversation', {'loggedInUser': id});
        _chatSocketConnection.send("login", id);

        switch (switchUserModel.data!.userInfo!.accessLevel
            .toString()
            .toLowerCase()) {
          case ("company"):
            if (policyStatus == false)
              showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => TermConditionProvider(
                            switchUserModel.data!.userInfo!.email!,
                          ),
                      child: TermsCondition()))
                ..then((value) {
                  removeData();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                });
            else if (profileComplete == false)
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                          create: (_) => ProfileProvider(),
                          child: CompanyProfile(false))));
            else
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => BottomMenu('Company', 0)),
                  (Route<dynamic> route) => false);

            break;
          case ("enduser"):
            if (policyStatus == false)
              showDialog(
                  context: context,
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => TermConditionProvider(
                            switchUserModel.data!.userInfo!.email!,
                          ),
                      child: TermsCondition())).then((value) {
                removeData();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (Route<dynamic> route) => false);
              });
            else if (profileComplete == false)
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUser(false)));
            else
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => BottomMenu('User', 0)),
                  (Route<dynamic> route) => false);
            break;
          case ("seller"):
            if (profileComplete == false)
              DialogUtils.AlertBox(
                context,
                buttonTitle: "yes",
                onDoneFunction: () async {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                oncancelFunction: () {
                  removeAllSharedPrefrerencesData();
                  Navigator.pop(context);
                },
                title: 'Profile InComplete!',
                alertTitle:
                    "Kindly fill your profile before proceeding further.",
              );
            else
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => BottomMenu('Seller', 0)),
                  (Route<dynamic> route) => false);
            break;
          default:
        }
        showMessage(message!);
      }

      notifyListeners();
    } on Exception catch (e) {
      _loading = false;
      message = e.toString().replaceAll('Exception:', '');
      showMessage(message!);
      print(e.toString());
      notifyListeners();
    }
    email.text = "";
    password.text = "";
    mutipleroleLoder = false;
  }

// Toggle Password Visibility
  void ShowVisiblePassword() {
    obscureText = !obscureText;
    notifyListeners();
  }

  //single role
//check planData
  checkPlan(List<PlanData>? planData) {
    if (planData!.length != 0) {
      for (int i = 0; i < planData.length; i++) {
        for (int j = 0; j < planData[i].features!.length; j++) {
          print(planData[i].features![j].keyName);
          setCreateEvent(planData[i].features![j].keyValue!.toInt());

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

  //mutiple role
//check Mutiple plan
  checkMutiplePlan(parseData) {
    if (parseData!.length != 0) {
      print(parseData.length);
      for (int i = 0; i < parseData.length; i++) {
        for (int j = 0; j < parseData[i].features!.length; j++) {
          print(parseData[i].features![j].keyValue!.toInt());
          if (parseData[i].features![j].constName == "NOOFEVENTS") {
            setCreateEvent(parseData[i].features![j].keyValue!.toInt());
            break;
          } else {
            if (parseData[i].features![j].constName == "NOOFEVENTS")
              setEventPlanData(false);
          }
          if (parseData[i].features![j].constName == "WEATHER") {
            setWeatherPlanData(true);
            setWeatherValue(parseData[i].features![j].keyValue!.toInt());

            break;
          } else {
            if (parseData[i].features![j].constName == "WEATHER")
              setWeatherPlanData(false);
          }
          if (parseData[i].features![j].constName == "NOOFTRIPS") {
            setGpsPlanData(true);

            break;
          } else {
            if (parseData[i].features![j].constName == "NOOFTRIPS")
              setGpsPlanData(false);
          }
        }
      }
      setplanDate(true);
    } else {
      print(parseData.length);
      setplanDate(false);
    }
  }

  void setTermCondition(bool val) {
    checkBoxValue = val;
    notifyListeners();
  }
}

void saveData(
  String? id,
  String rolename,
  String? name,
  String? profileImg,
  profileComplete,
  createdBy,
  String defaultLanguage,
  policyStatus,
) {
  print(id);
  setUserInfo(id);
  setLanguage(defaultLanguage == "en"
      ? "english"
      : defaultLanguage == "pa"
          ? "punjab"
          : "spanish");
  setRoleInfo(rolename);
  setNameInfo(name);

  setprofileInfo(profileImg);
  setCompanyId(createdBy == null ? '' : createdBy);
  setProfileComplete(profileComplete);
  setPolicyStatus(policyStatus);
}
