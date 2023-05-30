import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/view_product_screen/view_product.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/Provider/wishList_Provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/InsideButton.dart';
import 'package:provider/provider.dart';

import '../../view_product_screen/e_commerce_view_product_provider/Product_view_Provider.dart';

class WishList extends StatelessWidget {
  WishListProvider wishListProvider;

  WishList(this.wishListProvider);

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth / 200.ceil();

    return Consumer<WishListProvider>(builder: (context, noti, child) {
      if (noti.loading) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Center(child: CircularProgressIndicator.adaptive()),
          ],
        );
      }
      if (noti.wishListModel.data == null || noti.WishList.length == 0)
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
            ),
            Center(child: Text('No Record Found')),
          ],
        );
      else
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: MediaQuery.of(context).size.width < 900
                    ? (cardWidth / cardHeight) / 300
                    : (cardWidth / cardHeight) / 220,
              ),
              scrollDirection: Axis.vertical,
              itemCount: noti.WishList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(5, 5)),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 4,
                                offset: Offset(-5, -5))
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LayoutBuilder(
                              builder: (BuildContext context,
                                  BoxConstraints constraints) {
                                if (constraints.maxWidth > 400) {
                                  return eventImage(
                                      350,
                                      wishListProvider.WishList[index].image!
                                                  .length ==
                                              0
                                          ? ''
                                          : wishListProvider
                                              .WishList[index].image![0].name
                                              .toString(),
                                      wishListProvider,
                                      noti,
                                      index);
                                } else {
                                  return eventImage(
                                      150,
                                      wishListProvider.WishList[index].image!
                                                  .length ==
                                              0
                                          ? ''
                                          : wishListProvider
                                              .WishList[index].image![0].name
                                              .toString(),
                                      wishListProvider,
                                      noti,
                                      index);
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              noti.WishList[index].productName.toString(),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              noti.WishList[index].currency.toString() +
                                  ' ' +
                                  noti.WishList[index].price.toString(),
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              noti.wishListModel.data![index].location
                                  .toString(),
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ])),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => ProductViewProvider(),
                                child: ViewProduct(
                                    noti.WishList[index].productId.toString(),
                                    noti.WishList[index].categoryId.toString(),
                                    )))).then((value) {
                                      //"WishList"
                      wishListProvider.WishList = [];
                      wishListProvider.getWishList();
                    });
                  },
                );
              },
            ),
          ],
        );
    });
  }

  eventImage(
    double hei,
    String bannerImage,
    WishListProvider wishListProvider,
    WishListProvider noti,
    int index,
  ) {
    return Stack(
      children: [
        Image.network(
          Base_URL_ProductList + bannerImage,
          height: hei,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            return progress == null
                ? child
                : Center(
                    child: LoadingWidget(((progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!) *
                            100)
                        .toInt()));
          },
          errorBuilder: (a, b, c) => Center(
              child: Image.asset(
            'assets/default.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: hei,
          )),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    wishListProvider.removeWishlist(
                        noti.WishList[index].productId.toString(), index, noti);
                  },
                  child: InsiderButton(
                      Icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 25,
                  )),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(),
        )
      ],
    );
  }
}
