// // To parse this JSON data, do
// //
// //     final subscriptionPlanModel = subscriptionPlanModelFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
//
// import 'package:my_truck_dot_one/AppUtils/constants.dart';
// import 'package:my_truck_dot_one/Screens/PricingScreen/Provider/Pricing_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../ApiCall/api_Call.dart';
// import '../../AppUtils/UserInfo.dart';
// import '../../PaymentSuccessModel.dart';
// import '../../Screens/AddCartScreen/Payment_ Success_Screen.dart';
// import '../../Screens/BottomMenu/bottom_menu.dart';
// import '../../Screens/MyPlanScreen/my_plan_provider.dart';
// import '../../Screens/MyPlanScreen/my_plan_screen.dart';
// import '../../Screens/PricingScreen/component/payment_success_Screen.dart';
// import 'Add_to_cart_model.dart';
// import 'package:http/http.dart' as http;
//
// import 'Subscription_payment_successful_model.dart';
//
// SubscriptionPlanModel subscriptionPlanModelFromJson(String str) =>
//     SubscriptionPlanModel.fromJson(json.decode(str));
//
// String subscriptionPlanModelToJson(SubscriptionPlanModel data) =>
//     json.encode(data.toJson());
//
// class SubscriptionPlanModel {
//   SubscriptionPlanModel({
//     this.code,
//     this.message,
//     this.data,
//   });
//
//   int? code;
//   String? message;
//   List<PricingModel>? data;
//
//   factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
//       SubscriptionPlanModel(
//         code: json["code"],
//         message: json["message"],
//         data: List<PricingModel>.from(
//             json["data"].map((x) => PricingModel.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "message": message,
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }
//
// class PricingModel extends ChangeNotifier {
//   PricingModel({
//     this.id,
//     this.planName,
//     this.description,
//     this.title,
//     this.validity,
//     this.planPrice,
//     this.features,
//     this.discountType,
//     this.discountValue,
//     this.finalPrice,
//     this.heading,
//     this.androidPercent,
//     this.iphonePercent,
//     this.inCart,
//     this.iphone_price,
//     this.android_price,
//   });
//
//   String? id;
//   String? planName;
//   String? description;
//   String? title;
//   String? validity;
//   double? planPrice;
//   List<Feature>? features;
//   String? discountType;
//   int? discountValue;
//   double? finalPrice;
//   String? heading;
//   int? androidPercent;
//   int? iphonePercent;
//   bool? inCart;
//   var iphone_price;
//   var android_price;
//   bool paymentLoder = false;
//   late SubscriptionPaymentSuccessfulModel _subscriptionPaymentSuccessfulModel;
//
//   factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
//         id: json["_id"],
//         planName: json["plan_name"],
//         description: json["description"],
//         title: json["title"],
//         validity: json["validity"],
//         planPrice: json["planPrice"].toDouble(),
//         features: List<Feature>.from(
//             json["features"].map((x) => Feature.fromJson(x))),
//         discountType: json["discountType"],
//         discountValue: json["discountValue"],
//         finalPrice: json["finalPrice"].toDouble(),
//         heading: json["heading"],
//         androidPercent: json["android_percent"],
//         iphonePercent: json["iphone_percent"],
//         inCart: json["inCart"],
//         iphone_price: json["iphone_price"],
//         android_price: json["android_price"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "plan_name": planName,
//         "description": description,
//         "title": title,
//         "validity": validity,
//         "planPrice": planPrice,
//         "features": List<dynamic>.from(features!.map((x) => x.toJson())),
//         "discountType": discountType,
//         "discountValue": discountValue,
//         "finalPrice": finalPrice,
//         "heading": heading,
//         "android_percent": androidPercent,
//         "iphone_percent": iphonePercent,
//         "inCart": inCart,
//         "iphone_price": iphone_price,
//         "android_price": android_price,
//       };
//   AddToCartModel? cartModel;
//   var loder = false;
//
//   hitGetAddToCart(String planId, String title, PriceProvider provider) async {
//     var userId = await getUserId();
//     loder = true;
//     notifyListeners();
//     Map<String, dynamic> map = {
//       "planId": planId,
//       "title": title,
//       "userId": userId,
//     };
//
//     print(map);
//     try {
//       cartModel = await hitSubscriptionPlanAddToCart(map);
//       // provider.listener!.AddToCartItem();
//       // provider.setCount();
//       inCart = true;
//       loder = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       loder = false;
//       showMessage(message);
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<void> makePayment(double price, PriceProvider provider) async {
//     try {
//       paymentLoder = true;
//       notifyListeners();
//       // 1. create payment intent on the server
//       PaymentSuccessModel _payment = await _createTestPaymentSheet(price);
//       notifyListeners();
//
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           // Main params
//           paymentIntentClientSecret: _payment.clientSecret,
//           customFlow: false,
//           customerId: _payment.customer,
//           merchantDisplayName: "MyTruck.one",
//           // Extra params
//           applePay: const PaymentSheetApplePay(
//             merchantCountryCode: 'US',
//           ),
//           googlePay: const PaymentSheetGooglePay(
//             merchantCountryCode: 'US',
//           ),
//           setupIntentClientSecret: _payment.clientSecret,
//         ),
//       );
//       await Stripe.instance.presentPaymentSheet();
//       hitPaymentSuccess(_payment.id!, price, provider);
//       notifyListeners();
//     } on Exception catch (e) {
//       paymentLoder = false;
//       notifyListeners();
//       if (e is StripeException) {
//         paymentLoder = false;
//         notifyListeners();
//         print("Error from Stripe: ${e.error.localizedMessage}");
//       } else {
//         paymentLoder = false;
//         notifyListeners();
//         print("Unforeseen error: ${e}");
//       }
//       rethrow;
//     }
//     paymentLoder = false;
//   }
//
//   hitPaymentSuccess(
//       String clientSecret, double price, PriceProvider provider) async {
//     var userId = await getUserId();
//     var name = await getNameInfo();
//     notifyListeners();
//     Map<String, dynamic> map = {
//       "userId": userId,
//       "paymentId": clientSecret,
//     };
//
//     print(map);
//     try {
//       _subscriptionPaymentSuccessfulModel = await hitPaymentSuccessApi(map);
//
//       checkPlanValidity(_subscriptionPaymentSuccessfulModel);
//       // Navigator.of(navigatorKey.currentState!.context).push(
//       //   MaterialPageRoute(
//       //       builder: (context) => PaymentSucessScreen(
//       //           provider, clientSecret, price.floor().toString(), name)),
//       // );
//       Future.delayed(const Duration(seconds: 5), () {
//         Navigator.pushReplacement(
//             navigatorKey.currentState!.context,
//             MaterialPageRoute(
//                 builder: (context) => ChangeNotifierProvider(
//                     create: (_) => MyPlanProvider(),
//                     child: MyPlanScreen()))).then((value) {
//           provider.setMenuClick(0, navigatorKey.currentState!.context);
//
//         });
//       });
//
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       showMessage(message.toString());
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//
//   Future<PaymentSuccessModel> _createTestPaymentSheet(double price) async {
//     print(price);
//     Map<String, dynamic> body1 = {
//       'amount': price.floor().toString() + '00',
//       'currency': "usd",
//     };
//
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
//     notifyListeners();
//     if (body['error'] != null) {
//       throw Exception(body['error']);
//     }
//
//     return PaymentSuccessModel.fromJson(body);
//   }
//
//   checkPlanValidity(
//       SubscriptionPaymentSuccessfulModel subscriptionPaymentSuccessfulModel) {
//     for (int i = 0; i < subscriptionPaymentSuccessfulModel.data!.length; i++) {
//       for (int j = 0;
//           j < subscriptionPaymentSuccessfulModel.data![i].features!.length;
//           j++) {
//         if (subscriptionPaymentSuccessfulModel
//                 .data![i].features![j].constName ==
//             "WEATHER") {
//           setWeatherPlanData(true);
//           setWeatherValue(subscriptionPaymentSuccessfulModel
//               .data![i].features![j].keyValue!
//               .toInt());
//         } else if (subscriptionPaymentSuccessfulModel
//                 .data![i].features![j].constName ==
//             "NOOFTRIPS") {
//           setGpsPlanData(true);
//         }
//       }
//     }
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
