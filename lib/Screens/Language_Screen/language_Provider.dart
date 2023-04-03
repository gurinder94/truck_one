import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/SplashPage.dart';
import 'package:my_truck_dot_one/main.dart';

import '../../ApiCall/api_Call.dart';
import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../../Model/NetworkModel/normal_response.dart';
import '../BottomMenu/bottom_menu.dart';
import 'package:provider/provider.dart';

class LanguageChangeNotifierProvider with ChangeNotifier {
  Locale _currentLocale = new Locale("en");
  bool loading = false;

  Locale get currentLocale => _currentLocale;

  String languageCode = "en";
  late BuildContext context;

  LanguageChangeNotifierProvider() {
    setlanguage();
  }

  changeLocale(String _locale) async {
    this._currentLocale = new Locale(_locale);
    notifyListeners();
    var roleTitle = await getRoleInfo();

    switch (_locale) {
      case "en":
        getlanguage("en");
        setLanguage("english");
        break;
      case "pa":
        getlanguage("pa");
        setLanguage("punjab");
        break;
      case "es":
        getlanguage("es");
        setLanguage("spanish");
        break;
    }
    notifyListeners();
  }

  setBuildcontext(BuildContext context) {
    this.context = context;
  }

  Future<void> getlanguage(String languagecode) async {
    var uId = await getUserId();
    var roleTitle = await getRoleInfo();
    Map<String, dynamic> map = {
      "userId": uId,
      "defaultLanguage": languagecode,
    };

    loading = true;
    notifyListeners();
    try {
      ResponseModel responseModel = await hitDefaultLanguageApi(map);
      setlanguage();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashPage()),
          (Route<dynamic> route) => false);
      runApp(MyApp());

      loading = false;
      Language_PAGE_OPEN = false;
      notifyListeners();
    } on Exception catch (e) {
      var message = e.toString().replaceAll('Exception:', '');
      loading = false;
      notifyListeners();
    }
  }

  Future<dynamic> setlanguage() async {
    var code = await getLanguage();
    switch (code) {
      case "english":
        languageCode = "en";
        setLanguage("english");
        break;
      case "punjab":
        languageCode = "pa";
        setLanguage("punjab");

        break;
      case "spanish":
        languageCode = "es";
        setLanguage("spanish");

        break;
    }

    notifyListeners();
    return languageCode;
  }

  Future<String> getlanguagecode() async {
    languageCode = await getLanguage();
    if (languageCode == "punjab") {
      languageCode = "pa";
      // setState(() { languagecode = "pa"; });
      print(languageCode);
    }
    if (languageCode == "english") {
      languageCode = 'en';
      print(languageCode);
    }
    if (languageCode == "spanish") {
      languageCode = 'es';
      print(languageCode);
    }
    print(languageCode);
    notifyListeners();
    return languageCode;
  }
}
