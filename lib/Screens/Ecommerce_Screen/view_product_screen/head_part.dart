import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/product_list.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import '../wishlist_screen/Provider/wishList_Provider.dart';
import '../wishlist_screen/wishList_screen.dart';
import 'Component/animation_heart.dart';
import 'e_commerce_view_product_provider/Product_view_Provider.dart';

class HeadPart extends StatefulWidget {
  String categoryName;
  String categoryId;


  HeadPart(
    this.categoryName,
    this.categoryId,
   {
    Key? key,
  });

  @override
  State<HeadPart> createState() => _HeadPartState();
}

class _HeadPartState extends State<HeadPart> {
  int pagePos = 0;
  int off = 0;
  int to = 420;
  bool p = true;

  ScrollController _scrollController = ScrollController();

  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        off = _scrollController.offset.toInt();
        setState(() {});
      });
  }


  Widget build(BuildContext context) {
    var productview = context.watch<ProductViewProvider>();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        productview.productView.data!.images!.length == 0
            ? Container(
                height: 550,
                width: double.infinity,
                child: Image.asset(
                  'assets/default.png',
                  fit: BoxFit.fill,
                ),
              )
            : SizedBox(
                height: 550,
                width: double.infinity,
                child: PageView.builder(
                    itemCount: productview.productView.data!.images!.length,
                    onPageChanged: (val) {
                      pagePos = val;
                      setState(() {
                        print(pagePos);
                      });
                    },
                    controller: PageController(
                        initialPage: 0, keepPage: true, viewportFraction: 1),
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return CustomImage(
                        width: double.infinity,
                        height: 500,
                        image: SERVER_URL +
                            "/uploads/product/image/" +
                            productview.productView.data!.images![pagePos].name
                                .toString(),
                        boxFit: BoxFit.fill,
                      );
                    })),
        Container(
          alignment: Alignment.bottomCenter,
          height: 110,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 25,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: productview.productView.data!.images!.length,
                    itemBuilder: (context, index) => Container(
                          height: index == pagePos ? 9 : 5,
                          width: index == pagePos ? 9 : 5,
                          margin: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        )),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.transparent,
            Color(0x4B525050),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 90,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () {
                          getEventFavouriteList(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      AppLocalizations.instance.text("Product View"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Spacer(
                      flex: 1,
                    )
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black12,
                Colors.black12.withOpacity(0.2),
                Colors.black12,
                Color(0x4B525050),
              ],
            )),
          ),
        ),
        Positioned(
            top: 0, right: 0, left: 0, bottom: 0, child: HeartAnimation()),
      ],
    );
  }

  getEventFavouriteList(BuildContext context) async {

  Navigator.pop(context);


  }
}
