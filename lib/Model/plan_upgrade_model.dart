// // To parse this JSON data, do
// //
// //     final planUpgradeModel = planUpgradeModelFromJson(jsonString);
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:my_truck_dot_one/Screens/PlanUpgradeScreen/Provider/plan_upgrade_provider.dart';
//
// import '../ApiCall/api_Call.dart';
// import '../AppUtils/UserInfo.dart';
// import '../AppUtils/constants.dart';
// import '../PaymentSuccessModel.dart';
// import '../Screens/AddCartScreen/Payment_Failed_Screen.dart';
// import '../Screens/BottomMenu/bottom_menu.dart';
// import '../Screens/PlanUpgradeScreen/payment_success_upgrade_screen.dart';
// import 'PlanUpgradeSuccessModel.dart';
//
// PlanUpgradeModel planUpgradeModelFromJson(String str) =>
//     PlanUpgradeModel.fromJson(json.decode(str));
//
// String planUpgradeModelToJson(PlanUpgradeModel data) =>
//     json.encode(data.toJson());
//
// class PlanUpgradeModel {
//   PlanUpgradeModel({
//     this.code,
//     this.message,
//     this.data,
//   });
//
//   int? code;
//   String? message;
//   List<Datum>? data;
//
//   factory PlanUpgradeModel.fromJson(Map<String, dynamic> json) =>
//       PlanUpgradeModel(
//         code: json["code"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class Datum extends ChangeNotifier {
//   Datum({
//     this.id,
//     this.planName,
//     this.heading,
//     this.validity,
//     this.planPrice,
//     this.features,
//     this.finalPrice,
//     this.androidPrice,
//     this.iphonePrice,
//   });
//
//   String? id;
//   String? planName;
//   String? heading;
//   String? validity;
//   var planPrice;
//   List<Feature>? features;
//   var finalPrice;
//   var androidPrice;
//   var iphonePrice;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["_id"],
//         planName: json["plan_name"],
//         heading: json["heading"],
//         validity: json["validity"],
//         planPrice: json["planPrice"],
//         features: List<Feature>.from(
//             json["features"].map((x) => Feature.fromJson(x))),
//         finalPrice: json["finalPrice"].toDouble(),
//         androidPrice: json["android_price"].toDouble(),
//         iphonePrice: json["iphone_price"].toDouble(),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "plan_name": planName,
//         "heading": heading,
//         "validity": validity,
//         "planPrice": planPrice,
//         "features": List<dynamic>.from(features!.map((x) => x.toJson())),
//         "finalPrice": finalPrice,
//         "android_price": androidPrice,
//         "iphone_price": iphonePrice,
//       };
//   bool markePaymentLoder = false;
//
//   PlanUpgradeSuccessModel? _planUpgradeSuccessModel;
//   PaymentSuccessModel? _payment;
//
//   hitUpgradePlan(String paymentId, String selectedPlanId, String previousPlanId,
//       totalPrice, PlanUpgradeProvider proData) async {
//     var getId = await getUserId();
//     var name = await getNameInfo();
//
//     Map<String, dynamic> map = {
//       "paymentId": paymentId,
//       "userId": getId,
//       "SelectedPlanId": selectedPlanId,
//       "previousPlanId": previousPlanId
//     };
//
//     print(map);
//
//     try {
//       _planUpgradeSuccessModel = await hitUpgradePlanApi(map);
//
//       Navigator.of(navigatorKey.currentState!.context).push(
//         MaterialPageRoute(
//             builder: (context) => PaymentUpgradeScreen(
//                 proData.planUpgradeModel!, paymentId, totalPrice, name)),
//       );
//       Future.delayed(const Duration(seconds: 5), () {
//         Navigator.of(navigatorKey.currentState!.context).pushReplacement(
//           MaterialPageRoute(
//               builder: (context) => BottomMenu('User', 0)),
//         );
//
//       });
//       markePaymentLoder = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//
//         print(message);
//         Navigator.of(navigatorKey.currentState!.context).push(
//           MaterialPageRoute(builder: (context) => PaymentFailedScreen()),
//         );
//         Future.delayed(const Duration(seconds: 5), () {
//           Navigator.pop(navigatorKey.currentState!.context);
//         });
//
//
//       markePaymentLoder = false;
//
//       notifyListeners();
//     }
//   }
//
//   Future<void> makePayment(var totalPrice, String planId, String previousPlanId, PlanUpgradeProvider proData) async {
//     markePaymentLoder = true;
//
//     notifyListeners();
//     try {
//       _payment = await _createTestPaymentSheet(totalPrice);
//
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Main params
//           paymentIntentClientSecret: _payment!.clientSecret,
//           customFlow: false,
//           customerId: _payment!.customer,
//           merchantDisplayName: "MyTruck.one",
//           // Extra params
//           applePay: const PaymentSheetApplePay(
//             merchantCountryCode: 'US',
//           ),
//           googlePay: const PaymentSheetGooglePay(
//             merchantCountryCode: 'US',
//           ),
//           setupIntentClientSecret: _payment!.clientSecret,
//         ),
//       );
//       await Stripe.instance.presentPaymentSheet();
//
//       hitUpgradePlan(_payment!.id!,  planId,previousPlanId, totalPrice,proData);
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         markePaymentLoder = false;
//         notifyListeners();
//         showMessage("Payment Failed");
//       } else {
//         markePaymentLoder = false;
//         notifyListeners();
//         print("Unforeseen error: ${e}");
//       }
//       rethrow;
//     }
//   }
//
//   Future<PaymentSuccessModel> _createTestPaymentSheet(totalPrice) async {
//     Map<String, dynamic> body1 = {
//       'amount': totalPrice.floor().toString() +
//           "00"
//               "",
//       'currency': "usd",
//     };
//     print(body1);
//     // final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
//     final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
//     final response = await http.post(
//       url,
//       headers: {
//         "Authorization":
//             " Bearer sk_test_51Kr8LcHADmW2C08gZvIxbRYPW1fP4ACbBfpQnOXwTWHKlNiHwjNfKRdAIjdbu9nUefBNEPUbrtBPFAzxES0sQ4Q500e3CB5q2Y",
//         "Content-Type": "application/x-www-form-urlencoded"
//       },
//       body: body1,
//     );
//
//     final body = json.decode(response.body);
//
//     if (body['error'] != null) {
//       throw Exception(body['error']);
//     }
//
//     return PaymentSuccessModel.fromJson(body);
//   }
// }
//
// class Feature {
//   Feature({
//     this.keyName,
//     this.constName,
//     this.keyValue,
//     this.id,
//   });
//
//   String? keyName;
//   String? constName;
//   int? keyValue;
//   String? id;
//
//   factory Feature.fromJson(Map<String, dynamic> json) => Feature(
//         keyName: json["keyName"],
//         constName: json["constName"],
//         keyValue: json["keyValue"],
//         id: json["_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "keyName": keyName,
//         "constName": constName,
//         "keyValue": keyValue,
//         "_id": id,
//       };
// }
