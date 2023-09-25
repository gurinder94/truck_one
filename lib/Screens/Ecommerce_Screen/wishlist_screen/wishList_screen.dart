import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import 'Component/wishlist_list.dart';
import 'Provider/wishList_Provider.dart';

class WishListScreen extends StatelessWidget {
  @override
  bool iswishList = false;
  late WishListProvider _wishListProvider;
  late ScrollController scrollController;

  Widget build(BuildContext context) {
    _wishListProvider = context.read<WishListProvider>();
    _wishListProvider.WishList = [];
    _wishListProvider.getWishList();
    scrollController = new ScrollController();
    _wishListProvider.initScrollListener(scrollController);
    //
    // return Scaffold(
    //     backgroundColor: Color(0xFFEEEEEE),
    //     body: Column(children: [
    //       ServiceAppBar(
    //         title: 'WishList',
    //         backbutton: true,
    //         Search: SizedBox(),
    //         child: SizedBox(),
    //       ),
    //       WishList(_wishListProvider)
    //     ]));

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text('WishList'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              SizedBox(
                height: 90,
              ),
              WishList(_wishListProvider),
              PaginationWidget(_wishListProvider.paginationLoder),
            ],
          ),
        ));
  }
}
