import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/ViewEvent.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:my_truck_dot_one/Screens/NotificationScreen/Provider/notificationProvider.dart';
import 'package:my_truck_dot_one/Screens/PricingScreen/Provider/Pricing_provider.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:new_version/new_version.dart';
// import 'package:new_version/new_version.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'AppUtils/chat_socket_connection.dart';
import 'AppUtils/constants.dart';
import 'Model/JobModel/JobViewList.dart';
import 'Model/NotificationModel/ReceiveNotificationMessageModel.dart';
import 'Screens/BottomMenu/Provider/bottom_provider.dart';
import 'Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'Screens/Ecommerce_Screen/Provider/fliter_tabber_provider.dart';
import 'Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'Screens/EventScreen/AddEventScreen/Provider/show_date_time_Provider.dart';
import 'Screens/EventScreen/EventListScreen/Provider/EventListProvider.dart';
import 'Screens/ForgetPasswordScreen/Provider/ForgetPasswordProvider.dart';
import 'Screens/Home/Provider/home_page_list_provider.dart';
import 'Screens/Home/Provider/like_provider.dart';
import 'Screens/Home/like_component/like_list.dart';
import 'Screens/JobScreen/ApplyForm/Provider/applyJobProvider.dart';
import 'Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';
import 'Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'Screens/JobScreen/ViewJob/ViewJob.dart';
import 'Screens/Language_Screen/application_localizations.dart';
import 'Screens/Language_Screen/language_Provider.dart';
import 'Screens/LoginScreen/Provider/LoginPageProvider.dart';
import 'Screens/Network/network_page/network_page.dart';
import 'Screens/Network/network_page/network_provider.dart';
import 'Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'Screens/SellerScreen/seller_manage_product_screen/Provider/seller_product_list_provider.dart';
import 'Screens/SellerScreen/seller_product_question_screen/Provider/seller_product_question _answer.dart';
import 'Screens/SellerScreen/seller_product_question_screen/seller_question_screen.dart';
import 'Screens/SignUpScreen/Provider/SignUpCompanyProvider.dart';
import 'Screens/SignUpScreen/Provider/SignUpUserProvider.dart';
import 'Screens/SignUpScreen/Provider/Sign_up_provider.dart';
import 'Screens/Trip Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'Screens/Trip Planner/AddTripPlannerScreen/Provider/TripTabBarProvider.dart';
import 'Screens/Trip Planner/Dispatcher_Screen/Dispatche_main_Screen.dart';
import 'Screens/Trip Planner/Dispatcher_Screen/Provider/Dispatcher_provider.dart';
import 'Screens/Trip Planner/HosScreen/Provider/HosMapProvider.dart';
import 'Screens/Trip Planner/Provider/TripPlannerProvider.dart';
import 'Screens/Trip Planner/TripPlannerScreen/Provider/TripPlannerTabbar.dart';
import 'Screens/Trip Planner/UserLiveMap/Provider/route_marker_list_provider.dart';
import 'Screens/team_manage_Screen /company_team_manage/company_team_mange_component/team_manage_screen.dart';
import 'Screens/team_manage_Screen /seller_manage_team/Provider/seller_manage_team_Provider.dart';
import 'SplashPage.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notifications',
    importance: Importance.high, playSound: true);
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  //InAppPurchaseStoreKitPlatform.registerPlatform();
  HttpOverrides.global = MyHttpOverrides();

  // Stripe.publishableKey =
  //     "pk_test_51Kr8LcHADmW2C08gSJ6IZv0twGo2kR3IrVsKjTVlkPfcHcUS4MGYVH0W8ig0hYsH1hlEbb8zOT7hzxnm3LdL5omm00Jx9LeJAa";
  // // merchant.my-truck_dot_one
  // Stripe.merchantIdentifier = 'merchant.my-truck-dot-one';
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();
  // await Stripe.instance.applySettings();
  //FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    notificationReceiver();
    // TODO: implement initState
    Language_PAGE_OPEN = true;
    print(Language_PAGE_OPEN);
    initPlatformState();
    generateToken();

    Future.delayed(Duration(seconds: 5), () {
      updateApp();
    });
    getAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    contxt = context;

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => ChatSocketConnection(context, 'null'),
            lazy: false,
          ),
          ChangeNotifierProvider(create: (_) => PriceProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => AddTripProvider()),
          ChangeNotifierProvider(create: (_) => BottomProvider()),
          ChangeNotifierProvider(create: (_) => TripTabBarProvider()),
          ChangeNotifierProvider(create: (_) => ShowTimeProvider()),
          ChangeNotifierProvider(create: (_) => EventListProvider()),
          ChangeNotifierProvider(create: (_) => ShowTimeProvider()),
          ChangeNotifierProvider(create: (_) => TripPlannerListProvider()),
          ChangeNotifierProvider(create: (_) => UserProfileProvider()),
          ChangeNotifierProvider(create: (_) => JobListProvider()),
          ChangeNotifierProvider(create: (_) => JobApplyProvider()),
          ChangeNotifierProvider(create: (_) => UserJobProvider()),
          ChangeNotifierProvider(create: (_) => TripPlannerTabProvider()),
          ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
          ChangeNotifierProvider(create: (_) => HomePageListProvider()),
          ChangeNotifierProvider(create: (_) => CompanyProvider()),
          ChangeNotifierProvider(create: (_) => NotificationProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => RouteMarkerListProvider()),
          ChangeNotifierProvider(create: (_) => DispatcherProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => FliterProvider()),
          ChangeNotifierProvider(create: (_) => HosMapProvider()),
          ChangeNotifierProvider(create: (_) => RouteMarkerProvider()),
          ChangeNotifierProvider(create: (_) => ProductListProvider()),
          ChangeNotifierProvider(create: (_) => SellerManageTeamProvider()),
          ChangeNotifierProvider(create: (_) => SellerProductListProvider()),
          ChangeNotifierProvider(create: (_) => JobDetailModel()),
          ChangeNotifierProvider(create: (_) => ChatViewGroupProvider()),
          ChangeNotifierProvider(
              create: (_) => LanguageChangeNotifierProvider()),
        ],
        child: Selector<LanguageChangeNotifierProvider, dynamic>(
            selector: (_, provider) => provider.languageCode,
            builder: (context, languageCode, child) {
              print("selector ${languageCode}");
              return MaterialApp(
                  theme: ThemeData(
                      colorScheme: ColorScheme.fromSwatch(
                        primarySwatch: buildMaterialColor(Color(0xFF044a87)),
                      ),
                      primaryColor: PrimaryColor,
                      textTheme: TextTheme(
                        bodyText1: TextStyle(fontSize: 18.0),
                        bodyText2: TextStyle(fontSize: 14.0),
                        button: TextStyle(fontSize: 16.0),
                      )),
                  debugShowCheckedModeBanner: false,
                  title: 'My Truck One',
                  supportedLocales: [
                    const Locale('en'),
                    const Locale("pa"),
                    const Locale("es"),
                  ],
                  locale: new Locale(languageCode),
                  localizationsDelegates: [
                    AppLocalizationsDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (locale, supportedLocales) {
                    for (var supportedLocaleLanguage in supportedLocales) {
                      if (supportedLocaleLanguage.languageCode ==
                              locale!.languageCode &&
                          supportedLocaleLanguage.countryCode ==
                              locale.countryCode) {
                        return supportedLocaleLanguage;
                      }
                    }
                    return supportedLocales.first;
                  },
                  navigatorKey: navigatorKey,
                  // home: SplashPage(),
                  home: SplashPage());
            }));
  }

  MaterialColor buildMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.data}');
  var dataSp = message.data.toString().split(',');
  Map<String, dynamic> mapData = Map();
  dataSp.forEach((element) => mapData[element.split(':')[0].toString()] =
      element.split(':')[1].toString());
  //
  // NavigationPage(
  //     mapData.values.elementAt(2), mapData.values.elementAt(1).toString());
}

Future<void> initPlatformState() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id.toString();
    deviceName = androidInfo.device.toString();
    deviceVersion = androidInfo.version.toString();
    deviceModel = androidInfo.model.toString();
    deviceType = 'ANDROID';
    print('Running on $deviceId--- $deviceType'); // e.g. "Moto G (4)"
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.utsname.nodename.toString();
    deviceName = iosInfo.utsname.sysname.toString();
    deviceVersion = iosInfo.utsname.version.toString();
    deviceModel = iosInfo.utsname.machine.toString();
    deviceType = 'IOS';
    print('Running on $deviceId--- $deviceType'); // e.g. "iPod7,1"
  } else {
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    print('Running on ${webBrowserInfo.userAgent}');
  }
}

Future<void> generateToken() async {
  var getId = await getUserId();
  if (getId == null) {
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    }

    await FirebaseMessaging.instance
        .getToken()
        .then((value) => {setFireBaseToken(value!), print(value)});
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
  requestAlertPermission: false,
  requestBadgePermission: false,
  requestSoundPermission: false,
);

Future<void> notificationReceiver() async {
  FirebaseMessaging.instance.getInitialMessage().then((value) => (message) {});
  final InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: initializationSettingsIOS,
  );
  await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);

  FirebaseMessaging.onMessage.listen((event) {
    RemoteNotification? notification = event.notification;
    AndroidNotification? android = event.notification?.android;
    if (notification != null && android != null) {
      HomePageListProvider _notiCount =
          navigatorKey.currentState!.context.read<HomePageListProvider>();
      _notiCount.setCount(_notiCount.totalCount + 1);
      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
          payload: jsonEncode(event.data));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    onNotificationClick(event.data.toString());
  });
}

onSelectNotification(payload) async {
  onNotificationClick(payload);
}

Future<void> onNotificationClick(String? payload) async {
  {
    try {
      ReceiveMessageModel model =
          ReceiveMessageModel.fromJson(jsonDecode(payload!));

      switch (model.notificationType) {
        case "EVENT":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (_) => UserEventViewProvider(),
                        child: UserViewEvent(model.id!),
                      )));

          break;
        case "JOB":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => JobViewProvider(),
                      child: ViewJob(model.id!, true))));

          break;
        case "ECOMMERCE":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => SellerProductQuestionProvider(),
                      child: SellerQuestionScreen())));

          break;
        case "SELLERANSWERED":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => SellerProductQuestionProvider(),
                      child: SellerQuestionScreen())));

          break;

        case "USERLEFT":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => ManagerTeamProvider(),
                      child: CompanyTeamManageScreen(1, true))));
          break;
        case "TRIP":
          var getrole = await getRoleInfo();
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) =>
                      DispatcherScreen(getrole.toString().toUpperCase())));
          break;
        case "SENDINVITATION":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => NetworkProvider(),
                      child: NetworkPage(0))));
          break;
        case "LIKEADDED":
          Navigator.push(
              navigatorKey.currentState!.context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => LikeProvider(),
                      child: LikeScreen(model.toString().trim()))));
          break;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}

Future<void> updateApp() async {
  final newVersion = NewVersion(
    iOSId: 'com.my-truck-dot-one',
    androidId: 'com.my_truck_dot_one',
  );
  final status = await newVersion.getVersionStatus();
  if (status != null) {
    debugPrint(status.releaseNotes);
    debugPrint(status.appStoreLink);
    debugPrint(status.localVersion);
    debugPrint(status.storeVersion);
    AppversionName = status.storeVersion;
    debugPrint(status.canUpdate.toString());
    if (status.canUpdate) {
      newVersion.showUpdateDialog(
        context: navigatorKey.currentState!.context,
        versionStatus: status,
        dialogTitle: 'New Update Available',
        dialogText: 'Newer Version of App Available.',
      );
    }
  }
}

getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppversionName = packageInfo.version;
}
// NavigationPage(String name, String id) async {
//   if (name.contains("JOB")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => JobViewProvider(),
//                 child: ViewJob(id.toString().trim(), true))));
//   } else if (name.contains("ECOMMERCE")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => SellerProductQuestionProvider(),
//                 child: SellerQuestionScreen())));
//   } else if (name.contains("SELLERANSWERED")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => SellerProductQuestionProvider(),
//                 child: SellerQuestionScreen())));
//   } else if (name.contains("USERLEFT")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => ManagerTeamProvider(),
//                 child: CompanyTeamManageScreen(1, true))));
//   } else if (name.contains("TRIP")) {
//     var getrole = await getRoleInfo();
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 DispatcherScreen(getrole.toString().toUpperCase())));
//   } else if (name.contains("SENDINVITATION")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => NetworkProvider(), child: NetworkPage(0))));
//   } else if (name.contains("LIKEADDED")) {
//     Navigator.push(
//         navigatorKey.currentState!.context,
//         MaterialPageRoute(
//             builder: (context) => ChangeNotifierProvider(
//                 create: (_) => LikeProvider(),
//                 child: LikeScreen(id.toString().trim()))));
//   } else {
//     print("errror");
//   }
// }
