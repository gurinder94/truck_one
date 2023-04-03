import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class SearchKeyword extends StatelessWidget {
  ProductListProvider productListProvider;
  SearchKeyword(this.productListProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2,),

          Center(child: Text(AppLocalizations.instance.text("Filter by keyword"),style: TextStyle(color: Colors.black,fontSize: 18),)),
          SizedBox(height: 5,),
          Divider(),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InputTextField(
                child: TextFormField(
                  controller: productListProvider.searchText,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText:AppLocalizations.instance.text("Search"),
                hintStyle: TextStyle(fontSize: 17),
                // prefixIcon: Icon(
                //   Icons.sear,
                // ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
