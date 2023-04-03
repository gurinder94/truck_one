import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:provider/src/provider.dart';
import '../../commanWidget/custom_image_network.dart';
import 'Provider/Seller_view_detail_provider.dart';

class SellerHeadPart extends StatefulWidget {


  @override
  State<SellerHeadPart> createState() => _SellerHeadPartState();
}

class _SellerHeadPartState extends State<SellerHeadPart> {
  var pagePos=0;
  @override
  Widget build(BuildContext context) {
    var productview = context.watch<SellerViewProductProvider>();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        productview.productView.data!.images!.length == 0
            ? Container(
          height: 550,
          width: double.infinity,
          child: Image.asset(
            'icons/defaultImage.jpg',
            fit: BoxFit.cover,
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
                    boxFit: BoxFit.cover,
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
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    SizedBox(
                      width: 100,
                    ),
                    Text(
                      'Product View',
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
                )
            ),

          ),
        ),

      ],
    );
  }
}
