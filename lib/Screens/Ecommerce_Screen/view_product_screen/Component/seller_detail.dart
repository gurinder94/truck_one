import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../../../../AppUtils/UserInfo.dart';
import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class SellerDetail extends StatelessWidget {
  ProductViewProvider productViewProvider;

  SellerDetail(this.productViewProvider);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppLocalizations.instance.text("Seller Detail"),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          showDetail("Sold By",
              productViewProvider.productView.data!.sellerName.toString()),
          Divider(),
          showDetail("Location",
              productViewProvider.productView.data!.selleraddress.toString()),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.instance.text('Rating'),
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: productViewProvider
                      .sellerRatingModel.data!.length==0?Text("No Review"): Row(
                    children: [
                      for (int i = 0;
                          i <=
                              productViewProvider
                                  .sellerRatingModel.data![0].avgRating!;
                          i++)
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
                child: Container(
                  width: 140,
                  height: 40,
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFD9D8D8),
                          offset: Offset(5.0, 5.0),
                          blurRadius: 7,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(.4),
                          offset: Offset(-5.0, -5.0),
                          blurRadius: 10,
                        ),
                      ]),
                  child: Center(
                      child: Text(
                    AppLocalizations.instance.text("Contact Seller"),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  )),
                ),
                onTap: () async {
                  var uId = await getUserId();

                  if (uId ==
                      productViewProvider.productView.data!.createdById) {
                    print(productViewProvider.id);
                    print(uId);
                    showMessage("Cannot chat with this account");
                  } else {
                    productViewProvider.addChatList(
                        productViewProvider.productView.data!.createdById
                            .toString(),
                        productViewProvider.productView.data!.sellerName
                            .toString(),
                        null,
                        context);
                  }
                }),
          )
        ],
      ),
    );
  }

  showDetail(String? Heading, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: 250,
                child: Text(
                  AppLocalizations.instance.text(
                    Heading.toString(),
                  ),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: 300,
                child: Text(value.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
