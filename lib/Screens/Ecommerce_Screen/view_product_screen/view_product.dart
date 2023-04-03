import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Provider/fliter_tabber_provider.dart';
import 'package:provider/provider.dart';
import '../e_commerce_Product_List/product_list.dart';
import '../wishlist_screen/Provider/wishList_Provider.dart';
import '../wishlist_screen/wishList_screen.dart';
import 'LowerPart.dart';
import 'e_commerce_view_product_provider/Product_view_Provider.dart';
import 'head_part.dart';

class ViewProduct extends StatelessWidget {
  ScrollController scrollController = ScrollController();
  String id;
  String categoryId;


  ViewProduct(
    this.id,
    this.categoryId,

  );

  @override
  Widget build(BuildContext context) {
    var provider = context.read<FliterProvider>();

    var viewProduct = context.read<ProductViewProvider>();


    Future.delayed(Duration(milliseconds: 100), () {
      viewProduct.getProductView(id);
      provider.scrollListener();
    });

    viewProduct.setCategory(categoryId, id);
    return WillPopScope(
      onWillPop: () => backNavigator(context, viewProduct),
      child: Scaffold(
          backgroundColor: APP_BG,
          body: Selector<ProductViewProvider, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, paginationLoading, child) {
                return paginationLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        controller: scrollController,
                        child: Stack(children: [
                          HeadPart(
                              viewProduct.productView.data!.categoryName
                                  .toString(),
                              categoryId,
                              ),
                          LowerPart(viewProduct),
                        ]),
                      );
              })),
    );
  }

  backNavigator(BuildContext context, ProductViewProvider viewProduct) {
    Navigator.pop(context);
    // wishList == "WishList"
    //     ? Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => ChangeNotifierProvider(
    //                   create: (_) => WishListProvider(),
    //                   child: WishListScreen(),
    //                 )))
    //     : wishList == "SimilarList"
    //         ? Navigator.pop(context)
    //         // : Navigator.pushReplacement(
    //         //     context,
    //         //     MaterialPageRoute(
    //         //         builder: (context) => ProductList(
    //         //             viewProduct.productView.data!.categoryName.toString(),
    //         //             categoryId)));
    //         // productListProvider.getProduct(categoryId,1,false);
    //         // This block runs when you have come back to the 1st Page from 2nd.
    //         : Navigator.pop(context);

    return false;
  }
}
