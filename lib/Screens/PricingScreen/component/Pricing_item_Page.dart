import 'package:flutter/material.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_truck_dot_one/Model/account_detail_Model.dart';
import 'package:my_truck_dot_one/Model/constant_model.dart';
import 'package:my_truck_dot_one/Screens/PricingScreen/Provider/Pricing_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import '../../../AppUtils/constants.dart';
import '../../commanWidget/commanButton.dart';

class PricingItem extends StatelessWidget {
  ProductDetails product;
  int index;
  PriceProvider proData;
  PurchaseDetails? previousPurchase;
  List<Group>? group;

  PricingItem(this.product, this.index, this.previousPurchase, this.proData,
      this.group,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("333333333333333${previousPurchase}");
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
                    product.title.replaceAll('_', ' '),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                )
                    : Text(
                  capitalize(product.title
                      .replaceAll('_', ' ')
                      .contains("Weather Plan Monthly")
                      ? "Weather Monthly Plan"
                      : product.title
                      .replaceAll('_', ' ')
                      .contains("GPS Plan Monthly")
                      ? "GPS Monthly Plan"
                      : product.title.replaceAll('_', ' ')),
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
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width / 1.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommanButton(
                        title:
                        previousPurchase == null ? "BUY NOW" : "Purchased",
                        buttonColor: PrimaryColor,
                        titleColor: APP_BG,
                        onDoneFuction: () {
                         /* for (int i = 0; i < group!.length; i++) {
                            if (group![i].data!.title == 'GPS') {
                              if (group![i].data!.validity == 'MONTHLY') {

                                print("000000000000");
                                SizedBox();
                              } else if (group![i].data!.validity == 'YEARLY') {
                                SizedBox();
                                print("1111111111111");
                              } else {
                                FlutterInappPurchase.instance
                                    .clearTransactionIOS().then((value) =>
                                    proData.requestPurchase(product));
                              }
                            } else if (group![i].data!.title == "WEATHER") {
                              if (group![i].data!.validity == 'MONTHLY') {
                                SizedBox();

                                print("2222222222222222");
                              } else if (group![i].data!.validity == 'YEARLY') {
                                SizedBox();

                                print("3333333333333333");
                              } else {
                                FlutterInappPurchase.instance
                                    .clearTransactionIOS().then((value) =>
                                    proData.requestPurchase(product));
                              }
                            }
                          }*/
                          print(previousPurchase);
                          previousPurchase == null
                              ? FlutterInappPurchase.instance
                                  .clearTransactionIOS()
                                  .then((value) =>
                                      proData.requestPurchase(product))
                              : SizedBox();
                        },
                        loder: false,
                      ),
                    ],
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
                      width: 250,
                      padding: EdgeInsets.all(10),
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 35, right: 35),
                        child: new Text(
                          "RECOMMENDED",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      color: Color(0xFFEDBC48)),
                  alignment: FractionalOffset.center,
                  transform: new Matrix4.identity()
                    ..rotateZ(-25 * 4.1415927 / 180),
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
