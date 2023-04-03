import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_manage_product_screen/Component/unarchive_drop_down.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_manage_product_screen/Provider/seller_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../../../commanWidget/comman_button_widget.dart';
import 'isactive_drop_down.dart';

class ProductManageFliter extends StatelessWidget {
  SellerProductListProvider sellerProductListProvider;

  ProductManageFliter(this.sellerProductListProvider);

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
          AppLocalizations.instance.text("Status"),
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          IsActiveDropDownSeller(),
          SizedBox(
            height: 20,
          ),
          UnarchiveDropDown(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text("Cancel"),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    sellerProductListProvider.resetDrop();
                    sellerProductListProvider.resetList();
                    sellerProductListProvider.getSellerProduct('', '');
                    Navigator.pop(context);
                  },
                  loder: false,
                ),
              ),
              Expanded(
                child: CommanButtonWidget(
                  title:AppLocalizations.instance.text("Apply"),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    sellerProductListProvider.getSellerProduct(
                        '', sellerProductListProvider.categoryId.toString());
                    sellerProductListProvider.resetList();
                    Navigator.of(context).pop();
                  },
                  loder: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
