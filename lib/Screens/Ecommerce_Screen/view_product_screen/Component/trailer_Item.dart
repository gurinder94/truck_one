import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class TrailerDetails extends StatelessWidget {
  ProductViewProvider productViewProvider;

  TrailerDetails(
    this.productViewProvider,
  );

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppLocalizations.instance.text(
                "About this item",
              ),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          showDetail(
              "Brand",
              productViewProvider.productView.data!.dataBrandName.toString()),
          Divider(),
          showDetail(
              "Model",
              productViewProvider.productView.data!.dataModelName.toString()),
          Divider(),
          showDetail(
              "Year of Production",
              productViewProvider.productView.data!.productionYear.toString()),
          Divider(),
          showDetail(
              "Condition",
              productViewProvider.productView.data!.condition.toString()),
          Divider(),
          showDetail(
              "Price",
              productViewProvider.productView.data!.currency!+' '+    productViewProvider.productView.data!.price.toString()),
          Divider(),

          showDetail(
              "Gross Weight",
              productViewProvider.productView.data!.grossWeight.toString() +
                  ' KG'),
          Divider(),
          productViewProvider.productView.data!.height == null
              ? SizedBox()
              : showDetail("Height",
                  productViewProvider.productView.data!.height.toString()),
          showDetail("Load Capacity",
              productViewProvider.productView.data!.loadCapacity.toString()),
          Divider(),
          showDetail(
              "Net Weight",
              productViewProvider.productView.data!.netWeight.toString() +
                  ' KG'),
          Divider(),
          showDetail("Suspension",
              productViewProvider.productView.data!.suspension.toString()),
          Divider(),
          showDetail("Location",
              productViewProvider.productView.data!.location.toString()),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 5, right: 20),
            child: Text(
              AppLocalizations.instance.text('Description'),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Html(
              data: productViewProvider.productView.data!.description
                  .toString(),
            ),
          )
        ],
      ),
    );
  }

  showDetail(String? Heading, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              AppLocalizations.instance.text(Heading.toString()),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          Expanded(child: Text(value.toString())),
        ],
      ),
    );
  }

  showColor(String? Heading, var value) {
    print(value);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: 250,
                child: Text(
                  Heading.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
            ),
            //
            //
            //           value.isEmpty?SizedBox():

            if (value == null)
              SizedBox(
                width: 20,
              )
            else
              Flexible(
                child: Container(
                    width: 300,
                    child: Row(
                      children: [
                        for (var i in value)
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                  color: hexToColor(i), shape: BoxShape.circle),
                            ),
                          ),
                      ],
                    )),
              ),
          ],
        ),
      ),
    );
  }
}

Color hexToColor(String code) {
  var p = code.length;
  return new Color(int.parse(code.substring(1, p), radix: 16) + 0xFF000000);
}
