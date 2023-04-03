import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';

class SubCategory extends StatefulWidget {
  ProductListProvider productListProvider;
  SubCategory(this.productListProvider);

  @override
  State<SubCategory> createState() => _SubCategoryState(productListProvider);
}

class _SubCategoryState extends State<SubCategory> {
  @override

  ProductListProvider productListProvider;
  _SubCategoryState(this.productListProvider);



  void initState()
  {

  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: [
          SizedBox(height: 5,),

          Center(child: Text(AppLocalizations.instance.text('Select Sub-Category'),style: TextStyle(color: Colors.black,fontSize: 18),)),
          SizedBox(height: 5,),
          Divider(),
          SizedBox(height: 15,),
          Expanded(
            child: ListView.builder(
                itemCount: productListProvider.categoryList.data!.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      leading: Container(
                        width: 20,
                        child: RadioListTile(
                          value:  productListProvider.categoryList.data![index].id.toString(),
                          groupValue: productListProvider.valueCategory,
                          onChanged: (ind) => setState(() {
                            productListProvider.valueCategory = ind;

                          }),

                        ),
                      ),
                      title: Text(productListProvider.categoryList.data![index].categoryName.toString()));
                }),
          )
        ],
      ),
    );
  }
}
