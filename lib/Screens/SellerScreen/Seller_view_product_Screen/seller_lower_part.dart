import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/Seller_view_product_Screen/seller_trailer_detail.dart';
import 'package:provider/src/provider.dart';

import 'Provider/Seller_view_detail_provider.dart';
import 'Seller_Item_detail.dart';

class SellerLowerPart extends StatelessWidget {
  Data? data;
  ProductView productView;
  SellerLowerPart(this.productView);



  @override
  Widget build(BuildContext context) {
    var _provider = context.watch<SellerViewProductProvider>();

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
                            productView.data!.productName.toString(),
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
                          productView.data!.currency.toString()+' '+ productView.data!.price.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                )),
            Divider(),
            SizedBox(
              height: 5,
            ),

            _provider.productView.data!.categoryName=="Trucks"?  SellerItemDetails(productView):SellerTrailerDetails(productView),
            // ItemDetails(_productViewProvider),

            // SellerDetail(_productViewProvider),

            Divider(),
            SizedBox(
              height: 10,
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

              child: Text(value.toString()),
            ),
          ),
        ],
      ),
    ),
  );
}

eventImage(double hei, String bannerImage) {
  return Stack(
    children: [
      Container(
        height: hei,
        child: Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Pakistani_truck.jpg/200px-Pakistani_truck.jpg",
          height: hei,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.black12,
          Colors.black12,
          Colors.black12,
          Colors.black12,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      )
    ],
  );
}
