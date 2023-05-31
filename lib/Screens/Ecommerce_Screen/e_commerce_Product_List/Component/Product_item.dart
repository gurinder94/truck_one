import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_product_list_model.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/InsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';

import '../../view_product_screen/e_commerce_view_product_provider/Product_view_Provider.dart';
import '../../view_product_screen/view_product.dart';

class ProductItem extends StatelessWidget {
  String categoryId;
  String productId;

  ProductItem(this.categoryId, this.productId);

  @override
  Widget build(BuildContext context) {
    var data = context.watch<ProductModel>();

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 400) {
                return ProductImage(
                    350,
                    data.images!.length == 0
                        ? 'null'
                        : data.images![0].name.toString(),
                    data.iswishList,
                    data);
              } else {
                return ProductImage(
                    150,
                    data.images!.length == 0
                        ? 'null'
                        : data.images![0].name.toString(),
                    data.iswishList,
                    data);
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            data.productName.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            data.currency.toString() + '  ' + data.price.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            data.location.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
            ),
          )
        ]),
        decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
      ),
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => ProductViewProvider(),
                        child:
                            ViewProduct(productId, categoryId, ))))
            .then((value) {
          var product = context.read<ProductListProvider>();
          product.productList = [];
          product.getProduct(categoryId, 1, false);
        });
      },
    );
  }

  ProductImage(
      double hei, String bannerImage, bool? iswishList, ProductModel data) {
    return Stack(
      children: [
        CustomImage(
          width: double.infinity,
          height: 150,
          image: bannerImage == "null"
              ? ''
              : Base_URL_ProductList + bannerImage.toString(),
          boxFit: BoxFit.fill,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: iswishList == true
                    ? GestureDetector(
                        onTap: () {
                          data.removeWishlist(
                            data.id.toString(),
                            false,
                          );
                        },
                        child: InsiderButton(
                            Icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 25,
                        )),
                      )
                    : GestureDetector(
                        onTap: () {
                          data.addWishlist(data.id.toString(), true);
                        },
                        child: OutsideButton(
                          Icon: Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                      ),
              )
            ],
          ),
          decoration: BoxDecoration(),
        )
      ],
    );
  }
}
