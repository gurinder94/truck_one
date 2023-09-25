import 'dart:io';

import 'package:flutter/material.dart';

//import for GooglePlayProductDetails
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

//import for SkuDetailsWrapper
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

// import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_truck_dot_one/Model/constant_model.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/myPlans/my_plan_list_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';

//import for GooglePlayProductDetails
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

//import for SkuDetailsWrapper
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import '../../../AppUtils/constants.dart';
import '../../commanWidget/commanButton.dart';

class MyPlanListItem extends StatelessWidget {
  ProductDetails product;
  int index;
  MyPlanListProvider proData;
  PurchaseDetails? previousPurchase;
  List<Group>? group;

  MyPlanListItem(
      this.product, this.index, this.previousPurchase, this.proData, this.group,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mdata = proData.myPlanList.where((element) {
      return element['appKey'] == product.id;
    });
    var endDate = "";
    if (mdata.length > 0) {
      print("mdata>> endDate ${mdata.first['endDate']}");
      endDate = mdata.first['endDate'];
    }

    print('Title>> ${product.title}');
    print('Title>>  previousPurchase ${previousPurchase}');

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                product.title.contains("Yearly")
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          product.title.replaceAll(
                              '(MyTruck.one: truck jobs, maps)', ' '),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    : Text(
                        capitalize(
                          product.title.replaceAll(
                              '(MyTruck.one: truck jobs, maps)', ' '),
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.description,
                      ),
                      SizedBox()
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonRichText(
                      richText1: product.price,
                      style1: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          height: 1.4,
                          color: Colors.black),
                      richText2: product.title.contains("Yearly")
                          ? " per Year"
                          : " per Month",
                      style2: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                endDate != ""
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Expires on ${endDate}"),
                      )
                    : Container(),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.0,
                  child: endDate == ""
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AbsorbPointer(
                              absorbing: previousPurchase != null,
                              child: CommanButton(
                                title: previousPurchase == null
                                    ? "Buy Now"
                                    : "Purchased",
                                buttonColor: PrimaryColor,
                                titleColor: APP_BG,
                                onDoneFuction: () {
                                  // proData.initData();
                                  proData.requestPurchase(product);

                                  // final PurchaseDetails oldPurchaseDetails = ;
                                  // PurchaseParam purchaseParam = GooglePlayPurchaseParam(
                                  // productDetails: pr,
                                  // changeSubscriptionParam: ChangeSubscriptionParam(
                                  // oldPurchaseDetails: oldPurchaseDetails,
                                  // prorationMode: ProrationMode.immediateWithTimeProration));
                                  // InAppPurchase.instance
                                  //     .buyNonConsumable(purchaseParam: purchaseParam);
                                },
                                loder: false,
                              ),
                            ),
                            Platform.isIOS
                                ? AbsorbPointer(
                                    absorbing: previousPurchase != null,
                                    child: previousPurchase == null
                                        ? CommanButton(
                                            title: "Redeem code",
                                            buttonColor: PrimaryColor,
                                            titleColor: APP_BG,
                                            onDoneFuction: () {
                                              proData.requestOfferCode(product);
                                            },
                                            loder: false,
                                          )
                                        : SizedBox(),
                                  )
                                : Container(),
                          ],
                        )
                      : SizedBox(
                          height: 50,
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
            Positioned(
                left: -30,
                top: 25,
                child: product.title.contains("Yearly")
                    ? Transform(
                        child: Container(
                            width: 200,
                            padding: EdgeInsets.all(10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 35, right: 35),
                              child: new Text(
                                "RECOMMENDED",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            color: Color(0xFFEDBC48)),
                        alignment: FractionalOffset.center,
                        transform: new Matrix4.identity()
                          ..rotateZ(-25 * 4.4415927 / 180),
                      )
                    : SizedBox())
          ],
        ),
        decoration: product.title.contains("Yearly")
            ? BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                    BoxShadow(
                        color: Color(0xFFEDBC48),
                        blurRadius: 1,
                        offset: Offset(-2, -2)),
                    BoxShadow(
                        color: Color(0xFFEDBC48),
                        blurRadius: 1,
                        offset: Offset(2, 2)),
                  ])
            : BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 5,
                        offset: Offset(-5, -5)),
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        offset: Offset(5, 5)),
                  ]),
      ),
    );
  }

  displayText(String name, String value, String name2, String value2) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$value',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name2',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '$value2',
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
