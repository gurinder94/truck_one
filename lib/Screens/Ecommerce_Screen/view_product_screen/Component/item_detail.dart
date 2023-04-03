import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../e_commerce_view_product_provider/Product_view_Provider.dart';

class ItemDetails extends StatelessWidget {
  ProductViewProvider productViewProvider;
  var curreny;
  ItemDetails(
    this.productViewProvider,
  );

  Widget build(BuildContext context) {
     curreny = productViewProvider.productView.data!.currency.toString();
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppLocalizations.instance.text("About this item"),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          showDetail("Breaks",
              productViewProvider.productView.data!.breaks.toString()),
          Divider(),
          productViewProvider.productView.data!.color!.length == 0
              ? SizedBox()
              : showColor(
                  "Color",
                  productViewProvider.productView.data!.color!.length == 0
                      ? null
                      : productViewProvider.productView.data!.color),
          productViewProvider.productView.data!.color!.length == 0
              ? SizedBox()
              : Divider(),
          showDetail("Engine Make",
              productViewProvider.productView.data!.engineBrand.toString()),
          Divider(),
          showDetail(
              "Engine Displacement",
                          curreny == "CAD" ?     productViewProvider.productView.data!.engineDisplacement
                              .toString()+' Cc': curreny == "MXN"?    productViewProvider.productView.data!.engineDisplacement
                              .toString()+" Cc":  productViewProvider.productView.data!.engineDisplacement
                              .toString()+" Cc"),
          Divider(),
          showDetail(
              "Fuel Power Output",

                          curreny == "CAD"
                  ?  productViewProvider.productView.data!.enginePoweroutput
                              .toString() +'  Hp'
                  :  curreny == "MXN"?productViewProvider.productView.data!.enginePoweroutput
                              .toString() +'  Hp':productViewProvider.productView.data!.enginePoweroutput
                              .toString() +'  Hp'),
          Divider(),
          showDetail(
              "Fuel Capacity",

                  curreny ==
                  "CAD"
                  ?   productViewProvider.productView.data!.fuelCapacity
                      .toString() +' Gal ':
          curreny == "MXN"?productViewProvider.productView.data!.fuelCapacity
        .toString() +'  L':productViewProvider.productView.data!.fuelCapacity
        .toString() +'  Kg'),
          Divider(),
          showDetail("Fuel Type",
              productViewProvider.productView.data!.fuelType.toString()),
          Divider(),
          showDetail(
              "Gross Weight",

              productViewProvider.productView.data!.grossWeight.toString() +' Kg'),

          Divider(),
          productViewProvider.productView.data!.height == null
              ? SizedBox()
              : showDetail(
                  "Height",
                      curreny ==
                      "CAD"
                      ? productViewProvider.productView.data!.height.toString()+' M':    curreny ==
          "MXN"
          ?productViewProvider.productView.data!.height.toString()+ ' M'
              : productViewProvider.productView.data!.height.toString()+" M"),
          Divider(),
          showDetail("Load Capacity",
              productViewProvider.productView.data!.loadCapacity.toString()),
          Divider(),
          showDetail("Mileage",
                 curreny ==
                  "CAD"
                  ? productViewProvider.productView.data!.mileage.toString() +   ' Km':
              curreny ==
                  "MXN"
                  ?  productViewProvider.productView.data!.mileage.toString() +  ' Km'
                  :  productViewProvider.productView.data!.mileage.toString() +  " Km"),
          Divider(),
          showDetail(
              "Net Weight",

    curreny ==
    "CAD"
    ?      productViewProvider.productView.data!.netWeight.toString() +' Kg':  curreny ==
                  "MXN"
                  ?     productViewProvider.productView.data!.netWeight.toString() + ' Kg'
                  :      productViewProvider.productView.data!.netWeight.toString() +' Kg'),
          Divider(),
          showDetail("Suspension",
              productViewProvider.productView.data!.suspension.toString()),
          Divider(),
          showDetail(
              "WheelBase",

                  curreny ==
                  "CAD"
                  ?   productViewProvider.productView.data!.wheelBase.toString() +' M':
              curreny ==
                  "MXN"
                  ?   productViewProvider.productView.data!.wheelBase.toString() +' M'
                  :   productViewProvider.productView.data!.wheelBase.toString() +' In'),

          Divider(),
          productViewProvider.productView.data!.transmissionType==null?SizedBox():     showDetail(
              "Transmission Type",

              productViewProvider.productView.data!.transmissionType.toString()),
          productViewProvider.productView.data!.transmissionType==null?SizedBox():     Divider(),
          showDetail("Brand",
              productViewProvider.productView.data!.dataBrandName.toString()),
          Divider(),
          showDetail("Model",
              productViewProvider.productView.data!.dataModelName.toString()),
          Divider(),
          showDetail("Year of Production",
              productViewProvider.productView.data!.productionYear.toString()),
          Divider(),
          showDetail("Condition",
              productViewProvider.productView.data!.condition.toString()),
          Divider(),
          showDetail("Location",
              productViewProvider.productView.data!.location.toString()),
          Divider(),
          productViewProvider.productView.data!.width==null?SizedBox():   showDetail("Width",
               curreny ==
                  "CAD"
                  ?  productViewProvider.productView.data!.width.toString() +' M': curreny ==
                  "MXN"
                  ?  productViewProvider.productView.data!.width.toString() +' M'
                  :  productViewProvider.productView.data!.width.toString() +' In'),
          productViewProvider.productView.data!.width==null?SizedBox():    Divider(),

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
          Expanded(child: Text(value.toString())),
        ],
      ),
    );
  }

  showColor(String? Heading, var value) {
    print(value);
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 20),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                width: 250,
                child: Text(
                  AppLocalizations.instance.text(Heading.toString()),
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
                            padding: const EdgeInsets.only(left: 0, right: 5),
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
