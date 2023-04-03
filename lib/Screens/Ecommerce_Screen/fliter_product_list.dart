import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/price_filter.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/select%20_brand.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/select%20_model.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/select-sub-category.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/year_fliter.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/constants.dart';
import '../commanWidget/comman_button_widget.dart';
import 'Fliter_component/Product_condation.dart';
import 'Fliter_component/Search_fliter_Keyword.dart';

class FliterProductList extends StatefulWidget {
  String categoryName;
  ProductListProvider productListProvider;
  String categoryId;

  FliterProductList(
      this.productListProvider, this.categoryName, this.categoryId,
      {Key? key})
      : super(key: key);

  @override
  State<FliterProductList> createState() => _FliterProductListState();
}

class _FliterProductListState extends State<FliterProductList> {
  var Heading = [
    AppLocalizations.instance.text('Filter by keyword'),
    AppLocalizations.instance.text('Select Sub-Category'),
    AppLocalizations.instance.text('Select-Model'),
    AppLocalizations.instance.text('Select-Brand'),
    AppLocalizations.instance.text('Product-Condition'),
    AppLocalizations.instance.text('Price'),
    AppLocalizations.instance.text('Year'),

  ];
  int? val;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height < 700
          ? MediaQuery.of(context).size.height * 0.85
          : MediaQuery.of(context).size.height * 0.75,
      decoration: new BoxDecoration(
        color: APP_BG,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(25.0),
          topRight: const Radius.circular(25.0),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Category : ${widget.categoryName}"),
              ],
            ),
          ),
          Divider(),
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: Heading.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: index == val
                                ? Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            Heading[index],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: PrimaryColor.withOpacity(0.9),
                                        border: Border(
                                          right: BorderSide(
                                            //                   <--- left side
                                            color:
                                                Colors.black38.withOpacity(0.1),
                                          ),
                                        )),
                                  )
                                : Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(Heading[index]),
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border(
                                      right: BorderSide(
                                        //                   <--- left side
                                        color: Colors.black38.withOpacity(0.1),
                                      ),
                                    )),
                                  ),
                            onTap: () {
                              setState(() {
                                val = index;
                                print(index);
                              });
                              widget.productListProvider.setMenuClick(index);
                            },
                          );
                        }),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height < 1009
                          ? MediaQuery.of(context).size.height * 0.5
                          : MediaQuery.of(context).size.height / 1.9,
                      child: menuWidget(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CommanButtonWidget(
                  title: AppLocalizations.instance.text('Clear'),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    widget.productListProvider.resetFilter();
                  },
                  loder: false,
                ),
              ),
              Expanded(
                child: CommanButtonWidget(
                  title:AppLocalizations.instance.text('Apply'),
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () {
                    widget.productListProvider..productList = [];
                    widget.productListProvider
                      ..getProduct(widget.categoryId, 1, false);
                    Navigator.pop(context);
                  },
                  loder: false,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  menuWidget(
    BuildContext context,
  ) {
    print(Provider.of<ProductListProvider>(context, listen: true).menuClick);
    switch (Provider.of<ProductListProvider>(context, listen: true).menuClick) {
      case 0:
        return SearchKeyword(widget.productListProvider);

      case 1:
        return SubCategory(widget.productListProvider);

      case 2:
        return SelectModel(widget.productListProvider);
      case 3:
        return SelectBrand(widget.productListProvider);
      case 4:
        return ProductCondation(widget.productListProvider);
      case 5:
        return PriceFliter(widget.productListProvider);
      case 6:
        return YearFliter(
          widget.productListProvider,
        );
    }
  }
}
