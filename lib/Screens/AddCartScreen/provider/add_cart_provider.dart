// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
//
//
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
//
// import '../../../ApiCall/api_Call.dart';
// import '../../../AppUtils/UserInfo.dart';
// import '../../../AppUtils/constants.dart';
// import '../../../Model/NetworkModel/normal_response.dart';
// import '../../../Model/SubscriptionPlanModel/Cart_model.dart';
// import '../../../Model/SubscriptionPlanModel/Subscription_payment_successful_model.dart';
// import '../../../PaymentSuccessModel.dart';
// import '../../BottomMenu/bottom_menu.dart';
// import '../../MyPlanScreen/my_plan_provider.dart';
// import '../../MyPlanScreen/my_plan_screen.dart';
// import '../Payment_ Success_Screen.dart';
// import '../Payment_Failed_Screen.dart';
//
// class AddCartProvider extends ChangeNotifier {
//   bool loading = false, markePaymentLoder = false;
//   CartModel? cartModel;
//   List<CardModelData> cartModelList = [];
//   late PaymentSuccessModel _payment;
//   var value;
//   var TotalPrice = 0.0;
//   var grandTotalPrice = 0.0;
//   late SubscriptionPaymentSuccessfulModel _subscriptionPaymentSuccessfulModel;
//
//   hitAddToCart() async {
//     var userId = await getUserId();
//     TotalPrice = 0.0;
//     grandTotalPrice = 0.0;
//     loading = true;
//     notifyListeners();
//     Map<String, dynamic> map = {
//       "userId": userId,
//       "deviceType": Platform.isIOS == true ? "IOS" : "ANDROID"
//     };
//
//     print(map);
//     try {
//       cartModel = await hitSubscriptionItemCart(map);
//       cartModelList.addAll(cartModel!.data!);
//       setTotalPriceItem(cartModelList);
//       print(cartModel!.grandTotal.toString());
//       cartModel!.data!.length == 0
//           ? SizedBox()
//           : cartModel!.promoData == null
//               ? setGrandTotalPriceItem(cartModelList)
//               : setDiscountTotalPrice();
//
//       cartModel!.promoData == null
//           ? SizedBox()
//           : SelectValuePromoCode(cartModel!.promoData!.appliedCode![0]);
//
//       loading = false;
//       notifyListeners();
//
//
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       loading = false;
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//
//   void SelectValuePromoCode(value) {
//     this.value = value;
//
//     notifyListeners();
//   }
//
//   void setTotalPriceItem(List<CardModelData> cartModelList) {
//     TotalPrice = 0.0;
//
//     for (int i = 0; i < cartModelList.length; i++) {
//       if (Platform.isIOS) {
//         TotalPrice = TotalPrice + cartModelList[i].iphone_price.floorToDouble();
//
//         notifyListeners();
//       } else {
//         TotalPrice =
//             TotalPrice + cartModelList[i].android_price.floorToDouble();
//         notifyListeners();
//       }
//     }
//   }
//
//   void setGrandTotalPriceItem(List<CardModelData> cartModelList) {
//     grandTotalPrice = 0.0;
//     for (int i = 0; i < cartModelList.length; i++) {
//       if (Platform.isIOS) {
//         grandTotalPrice =
//             grandTotalPrice + cartModelList[i].iphone_price.floorToDouble();
//
//         print(grandTotalPrice);
//         notifyListeners();
//       } else {
//         grandTotalPrice =
//             grandTotalPrice + cartModelList[i].android_price.floorToDouble();
//         notifyListeners();
//       }
//     }
//   }
//
//   Future<void> makePayment() async {
//     markePaymentLoder = true;
//     notifyListeners();
//     try {
//       _payment = await _createTestPaymentSheet();
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
//       hitPaymentSuccess(_payment.id!);
//
//       markePaymentLoder = false;
//       notifyListeners();
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
//   hitPaymentSuccess(String clientSecret) async {
//     var userId = await getUserId();
//     var name = await getNameInfo();
//     loading = true;
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
//       Navigator.of(navigatorKey.currentState!.context).push(
//         MaterialPageRoute(
//             builder: (context) => PaymentSuccessfullyPage(cartModelList,
//                 clientSecret, grandTotalPrice.floor().toString(), name)),
//       );
//       Future.delayed(const Duration(seconds: 5), () {
//         cartModelList.clear();
//         Navigator.pushReplacement(
//             navigatorKey.currentState!.context,
//             MaterialPageRoute(
//                 builder: (context) => ChangeNotifierProvider(
//                     create: (_) => MyPlanProvider(),
//                     child: MyPlanScreen()))).then((value) {
//           cartModelList = [];
//           hitAddToCart();
//         });
//       });
//
//       loading = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       Navigator.of(navigatorKey.currentState!.context).push(
//         MaterialPageRoute(builder: (context) => PaymentFailedScreen()),
//       );
//       Future.delayed(const Duration(seconds: 5), () {
//         Navigator.pop(navigatorKey.currentState!.context);
//       });
//       loading = false;
//       print(e.toString());
//       notifyListeners();
//     }
//   }
//
//   void setDelete(int index) {
//     cartModelList.removeAt(index);
//     value = null;
//     setGrandTotalPriceItem(cartModelList);
//     setTotalPriceItem(cartModelList);
//     notifyListeners();
//   }
//
//   setPromoCodeTotalPriceItem(int grandTotal) {
//     TotalPrice = grandTotal.toDouble();
//     notifyListeners();
//   }
//
//   Future<PaymentSuccessModel> _createTestPaymentSheet() async {
//     Map<String, dynamic> body1 = {
//       'amount': grandTotalPrice.floor().toString() +
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
//
//   setDiscountTotalPrice() async {
//     grandTotalPrice = 0.0;
//
//     var discountprice = await getplanAmount();
//     grandTotalPrice = discountprice!.floorToDouble();
//
//     if (grandTotalPrice > 0) {
//       grandTotalPrice=TotalPrice-grandTotalPrice;
//
//       notifyListeners();
//     } else {
//       grandTotalPrice = 0;
//       grandTotalPrice=TotalPrice-grandTotalPrice;
//       notifyListeners();
//     }
//
//     print("discount ${grandTotalPrice}");
//   }
//
//   hitFreePlan() async {
//     var userId = await getUserId();
//     markePaymentLoder = true;
//     notifyListeners();
//     Map<String, dynamic> map = {
//       "userId": userId,
//     };
//
//     print(map);
//     try {
//       _subscriptionPaymentSuccessfulModel = await hitFreePlanApi(map);
//       cartModelList.clear();
//       checkPlanValidity(_subscriptionPaymentSuccessfulModel);
//       Navigator.of(navigatorKey.currentState!.context).pushAndRemoveUntil(
//           MaterialPageRoute(builder: (context) => BottomMenu('User', 4)),
//           (Route<dynamic> route) => false);
//       markePaymentLoder = false;
//       notifyListeners();
//     } on Exception catch (e) {
//       var message = e.toString().replaceAll('Exception:', '');
//       showMessage(message);
//       markePaymentLoder = false;
//       notifyListeners();
//       notifyListeners();
//     }
//   }
// }
