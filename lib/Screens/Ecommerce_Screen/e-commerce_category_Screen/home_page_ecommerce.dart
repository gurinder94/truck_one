import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/product_list.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../Language_Screen/application_localizations.dart';
import 'Provider/category_provider.dart';

class HomePageEcommerce extends StatefulWidget {
  @override
  State<HomePageEcommerce> createState() => _HomePageEcommerceState();
}

class _HomePageEcommerceState extends State<HomePageEcommerce> {
  @override
  late CategoryProvider _categoryProvider;

  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      _categoryProvider = context.read<CategoryProvider>();
      _categoryProvider.getCategory();
    });
  }

  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth / 200.ceil();
    var provider = context.watch<CategoryProvider>();
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text('${AppLocalizations.instance.text('E-commerce')}'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [],
        ),
        body: provider.loading == true
            ? Center(child: CircularProgressIndicator())
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    AppLocalizations.instance.text("E-commerce title"),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(child:
                    Consumer<CategoryProvider>(builder: (context, noti, child) {
                  return GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: MediaQuery.of(context).size.width < 900
                          ? (cardWidth / cardHeight) / 235
                          : (cardWidth / cardHeight) / 200,
                      crossAxisSpacing: 1.0,
                      children: List.generate(
                        noti.ecommerceCategoryModel.data!.length,
                        (index) {
                          return GestureDetector(
                            child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                child: Column(children: [
                                  LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      if (constraints.maxWidth > 400) {
                                        return eventImage(
                                            370,
                                            noti.ecommerceCategoryModel
                                                .data![index].image
                                                .toString());
                                      } else {
                                        return eventImage(
                                            160,
                                            noti.ecommerceCategoryModel
                                                .data![index].image
                                                .toString());
                                      }
                                    },
                                  ),
                                  Spacer(),
                                  Center(
                                    child: Text(
                                      noti.ecommerceCategoryModel.data![index]
                                          .categoryName
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w800,
                                          shadows: [
                                            Shadow(
                                                color: Colors.black12,
                                                offset: Offset(3.0, 3.0),
                                                blurRadius: 3.0),
                                            Shadow(
                                                color: Colors.white10,
                                                offset: Offset(-2.0, -2.0),
                                                blurRadius: 3.0),
                                          ]),
                                    ),
                                  ),
                                  Spacer(),
                                ])),
                            onTap: () {
                              noti.ecommerceCategoryModel.data![index]
                                          .categoryName ==
                                      "Accessories"
                                  ? SizedBox()
                                  : noti.ecommerceCategoryModel.data![index]
                                              .categoryName ==
                                          "Spare parts"
                                      ? SizedBox()
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ProductList(
                                                    noti
                                                        .ecommerceCategoryModel
                                                        .data![index]
                                                        .categoryName
                                                        .toString(),
                                                    noti.ecommerceCategoryModel
                                                        .data![index].id
                                                        .toString(),
                                                  )));
                            },
                          );
                        },
                      ));
                }))
              ]));
  }

  eventImage(double hei, String bannerImage) {
    return Container(
      height: hei,
      child: bannerImage == "null"
          ? Image.asset(
              "icons/default.jpg",
              height: hei,
              width: double.infinity,
              fit: BoxFit.fill,
            )
          : Image.network(
              "https://mytruck.one:1337/uploads/category/thumbnail/" +
                  bannerImage,
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
            ),
    );
  }
}
