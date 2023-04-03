// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
//
// import '../../../ApiCall/api_Call.dart';
// import '../../../AppUtils/UserInfo.dart';
// import '../../../AppUtils/constants.dart';
// import '../../../Model/PlanUpgradeSuccessModel.dart';
// import '../../../Model/SubscriptionPlanModel/Subscription_payment_successful_model.dart';
// import '../../../Model/plan_upgrade_model.dart';
// import '../../../PaymentSuccessModel.dart';
// import '../../AddCartScreen/Payment_ Success_Screen.dart';
// import '../../AddCartScreen/Payment_Failed_Screen.dart';
// import '../../BottomMenu/bottom_menu.dart';
// import '../payment_success_upgrade_screen.dart';
//
// class PlanUpgradeProvider extends ChangeNotifier {
//   bool loding = false, markePaymentLoder = false;
//   PlanUpgradeModel? planUpgradeModel;
//   PlanUpgradeSuccessModel? _planUpgradeSuccessModel;
//   PaymentSuccessModel? _payment;
//
//   hitGetSubscriptionPlan(String planId, String planValidity) async {
//     var getId = await getUserId();
//     loding = true;
//     notifyListeners();
//     Map<String, dynamic> map = {
//       "planId": planId,
//       "userId": getId,
//       "validityType": planValidity,
//       "deviceType":Platform.isIOS==true?"IOS":"'ANDROID"
//     };
//
//     print(map);
//
//     try {
//       planUpgradeModel = await hitUpgradePlanListApi(map);
//       loding = false;
//
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//
//       print(e.toString());
//       loding = false;
//       notifyListeners();
//     }
//   }
//
//
// }
