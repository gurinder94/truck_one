import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/seller_product_List_model.dart';
import 'package:provider/provider.dart';

import '../../../../AppUtils/constants.dart';
import '../../../commanWidget/custom_image_network.dart';
import '../../Seller_view_product_Screen/Provider/Seller_view_detail_provider.dart';
import '../../Seller_view_product_Screen/Seller_view_product_detail.dart';

class SellerProductItem extends StatelessWidget {
  SellerProduct productList;
   SellerProductItem(this.productList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              CustomImage(
                  image:productList.images!
                      .length ==
                      0
                      ? ''
                      : Base_URL_ProductList +
                      productList.images![0]
                          .name
                          .toString(),
                  width: 100,
                  boxFit: BoxFit.cover,
                  height: 100),
              SizedBox(
                width: 10,
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 220,
                      child: Text(
                        productList.productName
                            .toString() +
                            ' ' +
                            "${'(' + productList.categoryName.toString() + ')'}",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 200,
                          child: Text(
                            productList.location
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.price_check_rounded,
                          size: 25,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          productList.currency
                              .toString() +
                              ' ' +
                              productList.price
                                  .toString(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius:
              BorderRadius.all(Radius.circular(15)),
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
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => SellerViewProductProvider(),
                    child: SelllerProductDetail(productList.id
                        .toString()))));
      },
    );
  }
}
