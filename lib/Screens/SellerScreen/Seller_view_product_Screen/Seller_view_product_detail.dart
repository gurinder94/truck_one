import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/Seller_view_product_Screen/seller_head_part.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/Seller_view_product_Screen/seller_lower_part.dart';
import 'package:provider/provider.dart';

import 'Provider/Seller_view_detail_provider.dart';

class SelllerProductDetail extends StatelessWidget {
  String id;

  SelllerProductDetail(this.id);

  @override
  Widget build(BuildContext context) {
    var _provider = context.read<SellerViewProductProvider>();

    _provider.getProductView(id);
    return Scaffold(
      body: Selector<SellerViewProductProvider, bool>(
          selector: (_, provider) => provider.loading,
          builder: (context, paginationLoading, child) {
            return paginationLoading == true
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    controller: _provider.scrollController,
                    child: Stack(children: [
                      SellerHeadPart(),
                      SellerLowerPart(_provider.productView)
                    ]),
                  );
          }),
    );
  }
}
