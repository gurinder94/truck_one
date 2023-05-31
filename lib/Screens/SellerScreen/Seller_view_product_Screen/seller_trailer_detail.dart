import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

class SellerTrailerDetails extends StatelessWidget {
  ProductView productView;

  SellerTrailerDetails(this.productView);

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
            height: 5,
          ),
          Divider(),
          showDetail("Brand", productView.data!.dataBrandName.toString()),
          Divider(),
          showDetail("Model", productView.data!.dataModelName.toString()),
          Divider(),
          showDetail("Year of Production",
              productView.data!.productionYear.toString()),
          Divider(),
          showDetail("Condition", productView.data!.condition),
          Divider(),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Currency",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                ),
                Expanded(
                  child: Text(productView.data!.currency! +
                      ' ' +
                      productView.data!.price.toString()),
                ),
              ],
            ),
          ),
          Divider(),
          showDetail(
              "Gross Weight", productView.data!.grossWeight.toString() + ' KG'),
          Divider(),
          productView.data!.height == null
              ? SizedBox()
              : showDetail("Height", productView.data!.height.toString()),
          showDetail(
              "Load Capacity", productView.data!.loadCapacity.toString()),
          Divider(),
          showDetail(
              "Net Weight", productView.data!.netWeight.toString() + ' KG'),
          Divider(),
          showDetail("Suspension", productView.data!.suspension.toString()),
          Divider(),
          showDetail("Location", productView.data!.location.toString()),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: Text(
              AppLocalizations.instance.text("Description"),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Html(data: productView.data!.description.toString(), style: {
              "body": Style(
                fontSize: FontSize(16.0),
              ),
            }),
          )
        ],
      ),
    );
  }

  showDetail(String? Heading, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
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
          Expanded(
            child: Text(value.toString()),
          ),
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
