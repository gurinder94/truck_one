import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

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
import '../../../Model/validate_receipt_ios_model.dart';

import 'package:in_app_purchase_android/billing_client_wrappers.dart';

var _GpsSubscriptionId = ["gpsmonthlyplan", "gpsyearlyplan"];
var _weatherSubscriptionId = ["Weather_Plan_Monthly_7.99"];
List<String> kProductIds = _GpsSubscriptionId;

class PriceProvider extends ChangeNotifier {
  int menuClick = 0;

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

    print(
        "productDetailResponse>> ${productDetailResponse.notFoundIDs.toList()}");
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
      print("isAvailable_ ${productDetailResponse.notFoundIDs}");
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
    print(products[0].title);
    notifyListeners();
  }

  setPurchase() async {
    print("setPurchase>> ");
    var paymentWrapper = SKPaymentQueueWrapper();
    var transactions = await paymentWrapper.transactions();
    transactions.forEach((transaction) async {
      await paymentWrapper.finishTransaction(transaction);
    });
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
    productList.addAll(products.map(
      (ProductDetails productDetails) {
        previousPurchase = purch[productDetails.id];
      },
    ));
    getmyPlan();
  }

  //listener
  void initData() async {
    ProductDetailsResponse productDetailResponse =
        await _inAppPurchase.queryProductDetails(kProductIds.toSet());
    setListener();

    if (productDetailResponse.error != null) {}
    if (productDetailResponse.productDetails.isEmpty) {
      final Map<String, PurchaseDetails> purch =
          Map<String, PurchaseDetails>.fromEntries(
              purchases.map((PurchaseDetails purchase) {
        if (purchase.pendingCompletePurchase) {
          _inAppPurchase.completePurchase(purchase);
        }
        return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
      }));
      for (var _purchaseDetails in purchases) {
        if (_purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(_purchaseDetails);
        }
      }
    }
    initStoreInfo();
    // setPurchase();
    notifyListeners();
  }

  setListener() {
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
          if (valid) {
            //  final bool valid = await _verifyPurchase(purchaseDetails.productID);
            if (Platform.isIOS) {
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
              // android code goes here

              // final GooglePlayPurchaseDetails? oldSubscription =
              // _getOldSubscription(productDetails, purchases);
              /*if (productDetails is GooglePlayProductDetails) {
                SkuDetailsWrapper skuDetails = (productDetails as GooglePlayProductDetails).skuDetails;
                print(skuDetails.introductoryPricePeriod);
              }*/

              PurchaseWrapper billingClientPurchase =
                  (purchaseDetails as GooglePlayPurchaseDetails)
                      .billingClientPurchase;
              var googlePlayPurchaseDetails = GooglePlayPurchaseDetails(
                productID: purchaseDetails.productID,
                verificationData: purchaseDetails.verificationData,
                transactionDate: purchaseDetails.transactionDate,
                billingClientPurchase: billingClientPurchase,
                status: purchaseDetails.status,
              );

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
          print("restore");
        }

        if (purchaseDetails.pendingCompletePurchase) {
          purchasePending = false;
          notifyListeners();
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  setMenuClick(int pos, BuildContext context) {
    menuClick = pos;
    if (menuClick == 0) {
      kProductIds = _GpsSubscriptionId;
      initStoreInfo();
      notifyListeners();
    } else {
      kProductIds = _weatherSubscriptionId;
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
    notifyListeners();
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
    print("requestPurchase  dff");
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
    if (Platform.isAndroid) {
      InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = InAppPurchase
          .instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();

      iosPlatformAddition.showPriceConsentIfNeeded();
    } else {
      InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = InAppPurchase
          .instance
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.presentCodeRedemptionSheet();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    GooglePlayPurchaseDetails? oldSubscription;
    // if (productDetails.id == _kSilverSubscriptionId &&
    //     purchases[_kGoldSubscriptionId] != null) {
    //   oldSubscription =
    //   purchases[_kGoldSubscriptionId]! as GooglePlayPurchaseDetails;
    // } else if (productDetails.id == _kGoldSubscriptionId &&
    //     purchases[_kSilverSubscriptionId] != null) {
    //   oldSubscription =
    //   purchases[_kSilverSubscriptionId]! as GooglePlayPurchaseDetails;
    // }
    oldSubscription!.billingClientPurchase.purchaseToken ?? "";
    return oldSubscription;
  }
}

Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
  log("VericationData Local :  ${purchaseDetails.verificationData.localVerificationData}");

  log("VericationData Server :  ${purchaseDetails.verificationData.serverVerificationData}");

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
