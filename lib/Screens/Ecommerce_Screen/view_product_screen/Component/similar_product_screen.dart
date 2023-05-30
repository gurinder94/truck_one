import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/view_product.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';

import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class SimilarProductScreen extends StatelessWidget {
  ProductViewProvider proData;

  SimilarProductScreen(
    this.proData,
  );

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth / 200.ceil();
    return Container(
        height: 270,
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 290,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: (cardWidth / cardHeight) / 160,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: proData.similarProduct.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                print(proData.productView.data!.id.toString());

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (_) => ProductViewProvider(),
                            child: ViewProduct(
                              proData.similarProduct.data![index].id.toString(),
                              proData.categoryId.toString(),
                            ))));
              },
              child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  width: 100,
                  height: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(5, 5)),
                        BoxShadow(
                            color: Colors.white,
                            blurRadius: 4,
                            offset: Offset(-5, -5))
                      ]),
                  child: Column(children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth > 400) {
                          return eventImage(
                              350,
                              proData.similarProduct.data![index].images!
                                          .length ==
                                      0
                                  ? "null"
                                  : proData.similarProduct.data![index]
                                      .images![0].name
                                      .toString());
                        } else {
                          return eventImage(
                              150,
                              proData.similarProduct.data![index].images!
                                          .length ==
                                      0
                                  ? "null"
                                  : proData.similarProduct.data![index]
                                      .images![0].name
                                      .toString());
                        }
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      proData.similarProduct.data![index].productName
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0),
                            Shadow(
                                color: Colors.white10,
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 3.0),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      proData.similarProduct.data![index].currency.toString() +
                          ' ' +
                          proData.similarProduct.data![index].price.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0),
                            Shadow(
                                color: Colors.white10,
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 3.0),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      proData.similarProduct.data![index].location.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.black26,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          shadows: [
                            Shadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 3.0),
                            Shadow(
                                color: Colors.white10,
                                offset: Offset(-2.0, -2.0),
                                blurRadius: 3.0),
                          ]),
                    ),
                  ])),
            );
          },
        ));
  }
}

eventImage(double hei, String bannerImage) {
  return Stack(
    children: [
      CustomImage(
          image: bannerImage == "null"
              ? ''
              : Base_URL_ProductList + bannerImage.toString(),
          width: double.infinity,
          boxFit: BoxFit.fill,
          height: 140)
    ],
  );
}
