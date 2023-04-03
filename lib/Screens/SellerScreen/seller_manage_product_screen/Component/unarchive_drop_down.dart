import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_drop.dart';
import 'package:provider/provider.dart';
import '../Provider/seller_product_list_provider.dart';


class UnarchiveDropDown extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Consumer<SellerProductListProvider>(
      builder: (context, notify, child) {
        return CommanDrop(
          title: "",
          onChangedFunction: (String newValue) {
            notify.setSelectedarchive(newValue);
          },
          selectValue: notify.valueSelectedarchive,
           itemsList: notify.archive.map<DropdownMenuItem<String>>(
                (final String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Center(child: Text(value)),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
