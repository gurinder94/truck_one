import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_manage_product_screen/Component/manage_product_item.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_manage_product_screen/Component/product_manage_fliter.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import '../../commanWidget/comman_bottom_sheet.dart';

import 'Provider/seller_product_list_provider.dart';

class ManageProductScreen extends StatefulWidget {
  bool backButton;
  ManageProductScreen(this.backButton);

  @override
  State<ManageProductScreen> createState() => _ManageProductScreenState();
}

class _ManageProductScreenState extends State<ManageProductScreen> {
  @override
  late SellerProductListProvider sellerProductListProvider;

  String searchText = '';

  Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    // TODO: implement initState
    sellerProductListProvider = context.read<SellerProductListProvider>();
    sellerProductListProvider.hitCategoryList();
    sellerProductListProvider.resetDrop();
    sellerProductListProvider.resetList();
    sellerProductListProvider.getSellerProduct('', '');
    super.initState();
  }

  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text('Manage Product'),
        leading:widget.backButton==false? GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ):SizedBox(),
        floatingActionWidget: SizedBox(),
        // FloatingActionButton(
        //   onPressed: () {
        //     DialogUtils.showMyDialog(
        //       context,
        //       onDoneFunction: () async {
        //         _launchURL();
        //         Navigator.pop(context);
        //       },
        //       oncancelFunction: () => Navigator.pop(context),
        //       title: 'Add Product',
        //       alertTitle: 'Add Product Message',
        //       btnText: "Done",
        //     );
        //   },
        //   child: Icon(
        //     Icons.add,
        //     color: Colors.white,
        //   ),
        //   backgroundColor: PrimaryColor,
        //   elevation: 5,
        // ),
        // actions: Row(
        //   children: [
        //     SizedBox(
        //       width: 10,
        //     ),
        //     AnimationSearchBar(
        //       onTextChange: (val) {
        //         if (searchText == '') {
        //           searchText = val;
        //         }
        //
        //         if (!sellerProductListProvider.loading) {
        //           sellerProductListProvider.resetList();
        //           sellerProductListProvider.getSellerProduct(val, '');
        //         }
        //       },
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     CommanCirleWidget(
        //       icons: Icon(
        //         Icons.filter_list,
        //         color: Colors.black,
        //       ),
        //       onDone: () {
        //         CommanBottomSheet.ShowBottomSheet(
        //           context,
        //           child: ProductManageFliter(sellerProductListProvider),
        //         );
        //       },
        //     ),
        //     SizedBox(
        //       width: 15,
        //     ),
        //   ],
        // ),
        actions: SizedBox(),
        child: Column(children: [
          SizeConfig.screenHeight! < 1010
              ? SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 15
                      : SizeConfig.safeBlockVertical! * 12, //10 for example
                )
              : SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 8
                      : SizeConfig.safeBlockVertical! * 9, //10 for example
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: CommanSearchBar(
                    onTextChange: (val) {
                      _debouncer.run(() {
                        if (!sellerProductListProvider.loading) {
                          sellerProductListProvider.resetList();
                          sellerProductListProvider.getSellerProduct(val, '');
                        }
                      });
                    },
                    IconName: GestureDetector(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      onTap: () {
                        CommanBottomSheet.ShowBottomSheet(context,
                            child:
                                ProductManageFliter(sellerProductListProvider));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child:
              Consumer<SellerProductListProvider>(builder: (_, proData, __) {
            if (proData.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (proData.ProductList.length == 0)
              return Center(
                  child:
                      Text(AppLocalizations.instance.text('No Record Found')));
            else
              return ListView.builder(
                  itemCount: proData.ProductList.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return SellerProductItem(proData.ProductList[index]);
                  });
          }))
        ]));
  }
}

_launchURL() async {
  String url = Base_url_Add_Product;
  print(url);
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    throw 'Could not launch $url';
  }
}
