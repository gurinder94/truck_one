import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_category_model.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:provider/provider.dart';

import '../Provider/seller_product_list_provider.dart';

class IsActiveDropDownSeller extends StatelessWidget {
  var value;

  @override
  Widget build(BuildContext context) {
    return Consumer<SellerProductListProvider>(
      builder: (context, notify, child) {
        return CommanDrop(
          title: "Select Category",
          onChangedFunction: (String newValue) {
            var id = indexState(newValue, notify);
            notify.setSelectedItem(newValue, id);
          },
          selectValue: notify.valueSelectedCategory,
          itemsList: notify.ecommerceCategoryModel!.data!.map((Datum value) {
            return new DropdownMenuItem<String>(
              value: value.categoryName,
              child: Center(
                child: Text(value.categoryName.toString(),
                    style: new TextStyle(color: Colors.black)),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  indexState(
    String? newValue,
    SellerProductListProvider notify,
  ) {
    final index = notify.ecommerceCategoryModel!.data!
        .indexWhere((element) => element.categoryName == newValue);
    print('${index}___');
    return notify.ecommerceCategoryModel!.data![index].id;
  }
}
