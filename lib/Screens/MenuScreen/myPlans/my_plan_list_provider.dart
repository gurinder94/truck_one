import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/normal_response.dart';
import 'package:my_truck_dot_one/Model/constant_model.dart';

import '../../../AppUtils/constants.dart';
import '../../../Model/MyPlanModel.dart';
import '../../../Model/validate_receipt_ios_model.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class MyPlanListProvider extends ChangeNotifier {
  int menuClick = 0;

  // static var selectedPlanType = "ECOMMERCE";
  MyPlanModel myPlanModel = MyPlanModel();
  var _monthlySubscriptionId = [
    "ecommercemonthlybasic",
    "ecommercemonthlypremium"
  ];
  var _yearlySubscriptionId = [
    "ecommerceyearlybasic",
    "ecommerceyearlypremium"
  ];
  List<String> kProductIds = [];
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? subscription;
  List<String> notFoundIds = <String>[];
  late ConstantModell constant;
  List<ProductDetails> products = <ProductDetails>[];
  List<PurchaseDetails> purchases = <PurchaseDetails>[];
  List<LatestReceiptInfo> inApp = <LatestReceiptInfo>[];
  bool buyProductLoder = false;
  bool isAvailable = false;
  bool isTest = false;
  bool purchasePending = false;
  ResponseModel? responseModel;
  PurchaseDetails? previousPurchase;
  bool loading = true;
  String? queryProductError;
  late ValidateReceiptIosModel validateReceiptIosModel;
  var productList = [];
  final Stream<List<PurchaseDetails>> purchaseUpdated =
      InAppPurchase.instance.purchaseStream;
  Map<String, PurchaseDetails> purch = {};

  String message = '';

  Future<void> initStoreInfo() async {
    loading = true;

    final bool isAvailable = await _inAppPurchase.isAvailable();

    print("isAvailable>> $isAvailable");
    if (!isAvailable) {
      this.isAvailable = isAvailable;
      products = <ProductDetails>[];
      purchases = <PurchaseDetails>[];
      notFoundIds = <String>[];

      purchasePending = false;
      loading = false;

      return;
    }

    final ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(kProductIds.toSet());
    if (productDetailResponse.error != null) {
      queryProductError = productDetailResponse.error!.message;
      this.isAvailable = isAvailable;
      products = productDetailResponse.productDetails;
      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;

      purchasePending = false;
      loading = false;

      print("error_ ${notFoundIds}");
      notifyListeners();
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      queryProductError = null;
      this.isAvailable = isAvailable;
      products = productDetailResponse.productDetails;

      purchases = <PurchaseDetails>[];
      notFoundIds = productDetailResponse.notFoundIDs;
      print("isAvailable_  ${productDetailResponse.notFoundIDs}");
      purchasePending = false;
      loading = false;
      notifyListeners();
      return;
    }

    this.isAvailable = isAvailable;
    products = productDetailResponse.productDetails;
    notFoundIds = productDetailResponse.notFoundIDs;
    purchasePending = false;
    loading = false;
    products.sort((b, a) => a.price.compareTo(b.price));
    print("NAM#>> ${products[0].title}");
    // getmyPlan();

    notifyListeners();
  }

  Future setPurchase() async {
    print("setPurchase>> ");
    if (Platform.isIOS) {
      var paymentWrapper = SKPaymentQueueWrapper();
      var transactions = await paymentWrapper.transactions();
      transactions.forEach((transaction) async {
        await paymentWrapper.finishTransaction(transaction);
      });
    }
    restorePurchases();
    purch = Map<String, PurchaseDetails>.fromEntries(
        purchases.map((PurchaseDetails purchase) {
      if (purchase.pendingCompletePurchase) {
        print("setPurchase>> pendingCompletePurchase ${purchase.error?.code} ");
        print(
            "setPurchase>> pendingCompletePurchase ${purchase.error?.message} ");
        _inAppPurchase.completePurchase(purchase);
      }
      return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
    }));
  }

  //listener
  void initData() async {
    print("kProductIds.toSet()>> ${kProductIds.toSet()}");
    kProductIds = _monthlySubscriptionId;
    await initStoreInfo();

    await setListener();
    _inAppPurchase.restorePurchases();
  }

  setListener() async {
    subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
      listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      subscription!.cancel();
      notifyListeners();
    }, onError: (Object error) {
      print(error);
      // handle error here.
    });

    notifyListeners();
  }

  Future<void> listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    print(purchaseDetailsList.length);

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          final bool valid = await _verifyPurchase(purchaseDetails);

          print('valid>> ${valid}');
          if (valid) {
            if (Platform.isIOS) {
              print(
                  "sdjhsdjhksdjhkajhdsahjasdhjk    ${purchaseDetails.productID}");
              //  final bool valid = await _verifyPurchase(purchaseDetails.productID);
              var receiptBody = {
                'receipt-data':
                    purchaseDetails.verificationData.localVerificationData,
                // receipt key you will receive in request purchase callback function
                "exclude-old-transactions": true,
                'password': '777b657dd5984c8d820b86f9ee25d868'
              };

              try {
                var res = await hitValidateReceiptIos(
                  receiptBody,
                  isTest
                      ? 'https://sandbox.itunes.apple.com/verifyReceipt'
                      : 'https://buy.itunes.apple.com/verifyReceipt',
                );

                deliverProduct(purchaseDetails, res);

                break;
              } on Exception catch (e) {
                _handleInvalidPurchase(purchaseDetails);
                notifyListeners();
              }
            } else {
              purchases.add(purchaseDetails);
              PurchaseWrapper billingClientPurchase =
                  (purchaseDetails as GooglePlayPurchaseDetails)
                      .billingClientPurchase;
              print(
                  "billingClientPurchase>> ${billingClientPurchase.originalJson}");
              print(
                  "billingClientPurchase>> ${billingClientPurchase.developerPayload}");
              var googlePlayPurchaseDetails = GooglePlayPurchaseDetails(
                productID: purchaseDetails.productID,
                verificationData: purchaseDetails.verificationData,
                transactionDate: purchaseDetails.transactionDate,
                billingClientPurchase: billingClientPurchase,
                purchaseID: billingClientPurchase.orderId,
                status: purchaseDetails.status,
              );

              notifyListeners();
              print(
                  'googlePlayPurchaseDetails>> purchaseID ${googlePlayPurchaseDetails.purchaseID}');
              print(
                  'googlePlayPurchaseDetails>> purchaseToken ${billingClientPurchase.purchaseToken}');
              print(
                  'googlePlayPurchaseDetails>> status ${googlePlayPurchaseDetails.status.name}');
              print(
                  'googlePlayPurchaseDetails>>localVerificationData ${googlePlayPurchaseDetails.verificationData.localVerificationData}');
              print(
                  'googlePlayPurchaseDetails>> serverVerificationData ${googlePlayPurchaseDetails.verificationData.serverVerificationData}');
            }
          } else {
            _handleInvalidPurchase(purchaseDetails);
          }
        } else if (purchaseDetails.status == PurchaseStatus.restored) {
          print("restore>> ${purchaseDetails.purchaseID}");
          print(
              "restore>>localVerificationData  ${purchaseDetails.verificationData.localVerificationData}");
          print(
              "restore>>serverVerificationData  ${purchaseDetails.verificationData.serverVerificationData}");
          purchases.add(purchaseDetails);
          notifyListeners();
        }

        if (purchaseDetails.pendingCompletePurchase) {
          purchasePending = false;
          if (navigatorKey.currentContext!.mounted) notifyListeners();
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  setMenuClick(int pos, BuildContext context) {
    menuClick = pos;
    print("menuClick>> $menuClick");
    if (menuClick == 0) {
      kProductIds = _monthlySubscriptionId;
      initStoreInfo();
      notifyListeners();
    } else {
      kProductIds = _yearlySubscriptionId;
      initStoreInfo();
      notifyListeners();
    }
    print(menuClick);
  }

  onPopUpMenuClickAction(
    String type,
  ) {
    _monthlySubscriptionId = [];
    _yearlySubscriptionId = [];
    switch (type) {
      case "ECOMMERCE":
        _monthlySubscriptionId = [
          "ecommercemonthlybasic",
          "ecommercemonthlypremium"
        ];
        _yearlySubscriptionId = [
          "ecommerceyearlybasic",
          "ecommerceyearlypremium"
        ];
        break;

      case "EVENT":
        _monthlySubscriptionId = ["eventmonthlybasic", "eventmonthlypremium"];
        _yearlySubscriptionId = ["eventyearlybasic", "eventyearlypremium"];
        break;
      case "JOB":
        _monthlySubscriptionId = ["jobmonthlybasic", "jobmonthlypremium"];
        _yearlySubscriptionId = ["jobyearlybasic", "jobyearlypremium"];
        break;
      case "SERVICE":
        _monthlySubscriptionId = [
          "servicemonthlybasic",
          "servicemonthlypremium"
        ];
        _yearlySubscriptionId = ["serviceyearlybasic", "serviceyearlypremium"];
        break;
      case "TRIP_PLANNER":
        _monthlySubscriptionId = [
          "tripplanneryearlybasic",
          "tripplanneryearlypremium"
        ];
        _yearlySubscriptionId = [
          "TRIP_PLANNER_YEARLY_BASIC",
          "TRIP_PLANNER_YEARLY_PREMIUM"
        ];
        break;
    }
    print("onPopUpMenuClickAction  ${_monthlySubscriptionId.toSet()}");
    print("onPopUpMenuClickAction  ${_yearlySubscriptionId.toSet()}");
    if (menuClick == 0) {
      kProductIds = _monthlySubscriptionId;
      initStoreInfo();
      notifyListeners();
    } else {
      kProductIds = _yearlySubscriptionId;
      initStoreInfo();
      notifyListeners();
    }
    print(menuClick);
  }

  void showPendingUI() {
    purchasePending = true;
    notifyListeners();
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    print("_handleInvalidPurchase");
    purchasePending = false;
    notifyListeners();
    print("_handleInvalidPurchase>>> ${purchaseDetails.error?.message}");
    print(purchaseDetails.error);
  }

  void handleError(IAPError iapError) {
    purchasePending = false;
    print("iapError>>> ${iapError.message}");
    // notifyListeners();
  }

  void disposee() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    // subscription!.cancel();
    notifyListeners();
  }

  Future<void> requestPurchase(ProductDetails product) async {
    buyProductLoder = true;
    notifyListeners();
    // var transactions = await SKPaymentQueueWrapper().transactions();
    // transactions.forEach((skPaymentTransactionWrapper) {
    //   SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
    // });
    print("requestPurchase  dff ${product.id}");
    late PurchaseParam purchaseParam;
    try {
      purchaseParam =
          PurchaseParam(productDetails: product, applicationUserName: null);
      await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);

      purchasePending = false;
      notifyListeners();
    } on Exception catch (e) {
      print("requestPurchase   ${e}");
      if (e is PlatformException) {
        print(e.code + "e.code");
        if (e.code == 'storekit_duplicate_product_object') {
          ProductDetailsResponse productDetailResponse =
              await _inAppPurchase.queryProductDetails(kProductIds.toSet());
          print(
              "requestPurchase storekit_duplicate_product_object ${productDetailResponse.productDetails.length}");
          if (productDetailResponse.productDetails.isNotEmpty) {
            print("requestPurchase>>> dd ${purchases.length}");
            for (var _purchaseDetails in purchases) {
              if (_purchaseDetails.pendingCompletePurchase) {
                await _inAppPurchase.completePurchase(_purchaseDetails);
              }
            }
            print("object requestPurchase${purchases.length}");
          }
          var paymentWrapper = SKPaymentQueueWrapper();
          var transactions = await paymentWrapper.transactions();
          transactions.forEach((transaction) async {
            await paymentWrapper.finishTransaction(transaction);
          });
        }
      }
      buyProductLoder = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> myPlanList = [];

  getmyPlan() async {
    var getid = await getUserId();
    Map<String, dynamic> map = {
      "userId": getid,
    };

    try {
      constant = await hitMyPlan(map);
      constant.data?.forEach((element) {
        Map<String, dynamic> mdata = {};
        mdata['endDate'] = "${element.group?[0].endDate}";
        mdata['appKey'] = "${element.group?[0].data?.appKey}";
        mdata['paymentMode'] = "${element.group?[0].paymentMode}";
        myPlanList.add(mdata);
      });
      notifyListeners();
    } on Exception catch (e) {
      message = e.toString().replaceAll('Exception:', '');
      print(e.toString());
      notifyListeners();
    }
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails, res) async {
    try {
      inApp.clear();
      print("deliverProduct>> ${purchaseDetails.productID}");

      log("deliverProduct>> res ${res.body}");
      purchases.add(purchaseDetails);
      var getid = await getUserId();
      var response = json.decode(res.body);

      log("deliverProduct>> res ${response}");
      validateReceiptIosModel =
          await ValidateReceiptIosModel.fromJson(response);
      log("Receipts>> Length ${validateReceiptIosModel.latestReceiptInfo.length}");
      print(getid);
      log("Receipts>> validateReceiptIosModel ${jsonEncode(validateReceiptIosModel.latestReceiptInfo)}");
      responseModel = await hitSubscriptionPlanPayment({
        "userId": getid,
        "paymentData":
            jsonDecode(jsonEncode(validateReceiptIosModel.latestReceiptInfo)),
        "deviceName": deviceId,
        "paymentMode": "IOS",
        "paymentType": "INAPPPURCHASE"
      }).catchError((onError) {
        buyProductLoder = false;
        notifyListeners();
      });
      inApp.addAll(validateReceiptIosModel.latestReceiptInfo);
      buyProductLoder = false;

      notifyListeners();
      purchasePending = false;
    } on Exception catch (e) {
      print(e);
    }
  }

  void requestOfferCode(ProductDetails product) async {
    InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = InAppPurchase
        .instance
        .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
    iosPlatformAddition.presentCodeRedemptionSheet();
  }

  void restorePurchases() {
    _inAppPurchase.restorePurchases();
  }
}

Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
  return Future<bool>.value(true);
}

class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}
//
// setPreviousPlan() {
//   final Map<String, PurchaseDetails> purchase =
//       Map<String, PurchaseDetails>.fromEntries(
//           purchases.map((PurchaseDetails purchase) {
//     if (purchase.pendingCompletePurchase) {
//       _inAppPurchase.completePurchase(purchase);
//     }
//     return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
//   }));
//
//   productList.addAll(products.map(
//     (ProductDetails productDetails) {
//       previousPurchase = purchase[productDetails.id];
//
//       print("dskjsdajkadkjs${previousPurchase}");
//       notifyListeners();
