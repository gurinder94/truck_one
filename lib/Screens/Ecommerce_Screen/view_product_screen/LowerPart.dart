import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/Component/item_detail.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/Component/similar_product_screen.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../Provider/fliter_tabber_provider.dart';
import 'Component/customer_question.dart';
import 'Component/customer_question_answer.dart';
import 'Component/seller_detail.dart';
import 'Component/trailer_Item.dart';
import 'e_commerce_view_product_provider/Product_view_Provider.dart';

class LowerPart extends StatefulWidget {
  ProductViewProvider viewProduct;

  LowerPart(this.viewProduct);

  @override
  State<LowerPart> createState() => _LowerPartState(viewProduct);
}

class _LowerPartState extends State<LowerPart> {
  late FliterProvider provider;
  ProductViewProvider _productViewProvider;

  _LowerPartState(this._productViewProvider);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = context.read<FliterProvider>();

    provider.getFavourite(_productViewProvider.productView.data!.iswishList);
  }

  @override
  Widget build(BuildContext context) {
    var _provider = context.watch<FliterProvider>();

    return Container(
        margin: EdgeInsets.only(top: (500 - _provider.offset).abs()),
        decoration: BoxDecoration(
            color: APP_BG,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 130,
                height: 4,
                color: Colors.black,
              ),
            ),
            Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          child: Text(
                            _productViewProvider.productView.data!.productName
                                .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Text(
                            _productViewProvider.productView.data!.currency
                                    .toString() +
                                ' ' +
                                _productViewProvider.productView.data!.price
                                    .toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              _provider.checkFavourite == true
                                  ? Icons.favorite
                                  : Icons.favorite,
                              size: 20,
                              color: _provider.checkFavourite == true
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                          onTap: () {
                            //

                            if (_provider.checkFavourite == false) {
                              _provider.getFavourite(true);
                              provider.addWishlist(
                                  _productViewProvider.productView.data!.id
                                      .toString(),
                                  true);
                              provider.listener!.UnFavouriteEventHit();
                            } else {
                              _provider.getFavourite(false);
                              provider.removeWishlist(
                                  _productViewProvider.productView.data!.id
                                      .toString(),
                                  true);
                              provider.listener!.FavouriteEventHit();
                            }
                          },
                        )
                      ],
                    ),
                  ],
                )),
            Divider(),
            SizedBox(
              height: 8,
            ),
            _productViewProvider.productView.data!.categoryName == "Trucks"
                ? ItemDetails(_productViewProvider)
                : TrailerDetails(_productViewProvider),
            Divider(),
            SellerDetail(_productViewProvider),
            CustomerQuestion(_productViewProvider),
            Divider(),
            SizedBox(
              height: 8,
            ),
            Center(
              child: Text(
                AppLocalizations.instance.text(
                  "Customers Q & A's",
                ),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Consumer<ProductViewProvider>(builder: (_, proData, __) {
              if (proData.questionLoder) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.questionAnswerModel.data!.length == 0)
                return Center(
                    child: Text(
                        '${AppLocalizations.instance.text('Be the first to ask a question')}'));
              else
                return CustomerAnswer(proData);
            }),
            Divider(),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "${AppLocalizations.instance.text("Similar Products")}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ),
            Consumer<ProductViewProvider>(builder: (_, proData, __) {
              if (proData.similarLoder) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.similarProduct.data!.length == 0)
                return Center(
                    child: Text(
                        "${AppLocalizations.instance.text("No Record Found")}"));
              else
                return GestureDetector(child: SimilarProductScreen(proData));
            }),
            SizedBox(
              height: 50,
            ),
          ],
        ));
  }
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
                Heading.toString(),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
