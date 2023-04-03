import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';

class ProductCondation extends StatefulWidget {
  ProductListProvider productListProvider;

  ProductCondation(this.productListProvider);

  @override
  State<ProductCondation> createState() =>
      _ProductCondationState(productListProvider);
}

class _ProductCondationState extends State<ProductCondation> {
  @override
  ProductListProvider productListProvider;

  _ProductCondationState(this.productListProvider);

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 2,
          ),
          Center(
              child: Text(
           AppLocalizations.instance.text( "Product-Condition",),
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
          SizedBox(
            height: 5,
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: productListProvider.newProduct.length,
                itemBuilder: (BuildContext context, int index) {
                  var key = productListProvider.productCondation[index];
                  return ListTile(
                      leading: Container(
                          width: 20,
                          child: Checkbox(
                              value: productListProvider.newProduct[key],
                              onChanged: (val) {
                                productListProvider.newProduct[key] = val!;
                                setState(() {
                                  if (productListProvider.newProduct[
                                          productListProvider
                                              .productCondation[index]] ==
                                      true)
                                    productListProvider.valueProductCondation
                                        .add(productListProvider
                                            .productCondation[index]);
                                  else
                                    productListProvider.valueProductCondation
                                        .remove(productListProvider
                                            .productCondation[index]);
                                  print(productListProvider
                                      .valueProductCondation);
                                });
                              })),
                      title: Text(key.toString()));
                }),
          ),
        ],
      ),
    );
  }
}
