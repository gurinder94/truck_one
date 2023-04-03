import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/ecommerce_product_list_model.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/price_filter.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/select%20_brand.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/select-sub-category.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/Fliter_component/year_fliter.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../Fliter_component/Product_condation.dart';
import '../Provider/fliter_tabber_provider.dart';
import '../Fliter_component/Search_fliter_Keyword.dart';
import '../fliter_product_list.dart';
import '../Fliter_component/select _model.dart';
import 'Component/Product_item.dart';
import 'Provider/ecommerce_product_list_provider.dart';

class ProductList extends StatefulWidget {
  String categoryName;
  String categoryId;

  ProductList(
    this.categoryName,
    this.categoryId,
  );

  @override
  State<ProductList> createState() =>
      _ProductListState(categoryName, categoryId);
}

class _ProductListState extends State<ProductList> {
  int? val;

  late FliterProvider _provider;
  late ProductListProvider _productListProvider;
  var Heading = [
    'Filter by Keyword',
    'Select sub-category',
    'Select-Model',
    'Select-Brand',
    'Product-Condition',
    'Price',
    'Year',
  ];

  String categoryName, categoryId;
  int pagee = 1;

  _ProductListState(this.categoryName, this.categoryId);

  ScrollController scrollController = ScrollController();

  void initState() {
    _productListProvider =
        Provider.of<ProductListProvider>(context, listen: false);
    _productListProvider.productList = [];
    _productListProvider.reset();
    _productListProvider.getModelList();

    _productListProvider.getSubCategory(categoryId);
    _productListProvider.getBrandList();
    Future.delayed(Duration(milliseconds: 100), () {
      _productListProvider.getProduct(categoryId, 1, false);
      _productListProvider.productList = [];
    });
    addScrollListener(context);
  }

  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width;
    double cardHeight = cardWidth / 200.ceil();
    _provider = Provider.of<FliterProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text("${AppLocalizations.instance.text(categoryName)}"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          GestureDetector(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.more_vert)),
            onTap: () {
              showFliter();
            },
          )
        ],
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 10,
        ),
        Expanded(child: Consumer<ProductListProvider>(
          builder: (context, noti, child) {
            return noti.Productloading
                ? Center(child: CircularProgressIndicator())
                : noti.productList.length == 0
                    ? Center(
                        child: Text(
                            AppLocalizations.instance.text("No Record Found")))
                    : GridView.builder(
                        shrinkWrap: true,
                        controller: scrollController,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 300,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio:
                              MediaQuery.of(context).size.width < 900
                                  ? (cardWidth / cardHeight) / 270
                                  : (cardWidth / cardHeight) / 250,
                        ),
                        itemCount: noti.productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ChangeNotifierProvider<ProductModel>.value(
                              value: noti.productList[index],
                              child: ProductItem(
                                categoryId,
                                noti.productList[index].id.toString(),
                              ));
                        },
                      );
          },
        )),
        Selector<ProductListProvider, bool>(
            selector: (_, provider) => provider.pagionation,
            builder: (context, paginationLoading, child) {
              return PaginationWidget(paginationLoading);
            }),
      ]),
    );
  }

  menuWidget(
    BuildContext context,
  ) {
    print(Provider.of<ProductListProvider>(context, listen: true).menuClick);
    switch (Provider.of<ProductListProvider>(context, listen: true).menuClick) {
      case 0:
        return SearchKeyword(_productListProvider);

      case 1:
        return SubCategory(_productListProvider);

      case 2:
        return SelectModel(_productListProvider);
      case 3:
        return SelectBrand(_productListProvider);
      case 4:
        return ProductCondation(_productListProvider);
      case 5:
        return PriceFliter(_productListProvider);
      case 6:
        return YearFliter(
          _productListProvider,
        );
    }
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pagee = pagee + 1;
        if (_productListProvider.productListModel.data!.length == 0) {
        } else {
          _productListProvider.getProduct(categoryId, pagee, true);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  Flitershow() {
    print(MediaQuery.of(context).size.height);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height < 700
            ? MediaQuery.of(context).size.height * 0.90
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
                  Text("Category : $categoryName"),
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  width: 160,
                  height: 500,
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
                                          style: TextStyle(color: Colors.white),
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
                            _productListProvider.setMenuClick(index);
                          },
                        );
                      }),
                )),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 500,
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 380,
                      child: menuWidget(context),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CommanButtonWidget(
                            title: "Clear",
                            buttonColor: PrimaryColor,
                            titleColor: APP_BG,
                            onDoneFuction: () {
                              _productListProvider.resetFilter();
                            },
                            loder: false,
                          ),
                        ),
                        Expanded(
                          child: CommanButtonWidget(
                            title: "Apply",
                            buttonColor: PrimaryColor,
                            titleColor: APP_BG,
                            onDoneFuction: () {
                              _productListProvider.productList = [];
                              _productListProvider.getProduct(
                                  categoryId, 1, false);
                              Navigator.pop(context);
                            },
                            loder: false,
                          ),
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  showFliter() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              child: FliterProductList(
                  _productListProvider, categoryName, categoryId));
        });
  }
}
