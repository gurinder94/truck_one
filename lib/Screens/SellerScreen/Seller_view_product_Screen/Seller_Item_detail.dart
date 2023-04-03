import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_truck_dot_one/Model/E_commerce_Model/product_view_model.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

class SellerItemDetails extends StatelessWidget {
  ProductView productView;

  SellerItemDetails(this.productView);

  Widget build(BuildContext context) {
    var curreny = productView.data!.currency;
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
            height: 10,
          ),
          Divider(),
          showDetail("Breaks", productView.data!.breaks.toString()),
          Divider(),
          productView.data!.color!.length == 0
              ? SizedBox()
              : showColor(
                  "Color",
                  productView.data!.color!.length == 0
                      ? null
                      : productView.data!.color),
          productView.data!.color!.length == 0 ? SizedBox() : Divider(),
          showDetail("Engine Make", productView.data!.engineBrand.toString()),
          Divider(),
          showDetail(
              "Engine Displacement",
              curreny == "CAD"
                  ? productView.data!.engineDisplacement.toString() + ' Cc'
                  : curreny == "MXN"
                      ? productView.data!.engineDisplacement.toString() + " Cc"
                      : productView.data!.engineDisplacement.toString() +
                          " Cc"),
          Divider(),
          showDetail(
              "Fuel Power Output",
              curreny == "CAD"
                  ? productView.data!.enginePoweroutput.toString() + '  Hp'
                  : curreny == "MXN"
                      ? productView.data!.enginePoweroutput.toString() + '  Hp'
                      : productView.data!.enginePoweroutput.toString() +
                          '  Hp'),
          Divider(),
          showDetail(
              "Fuel Capacity",
              curreny == "CAD"
                  ? productView.data!.fuelCapacity.toString() + ' Gal '
                  : curreny == "MXN"
                      ? productView.data!.fuelCapacity.toString() + '  L'
                      : productView.data!.fuelCapacity.toString() + '  Kg'),
          Divider(),
          showDetail("Fuel Type", productView.data!.fuelType.toString()),
          Divider(),
          showDetail(
              "Gross Weight", productView.data!.grossWeight.toString() + ' Kg'),
          productView.data!.height == null
              ? SizedBox():    Divider(),
          productView.data!.height == null
              ? SizedBox()
              : showDetail(
                  "Height",
                  curreny == "CAD"
                      ? productView.data!.height.toString() + ' M'
                      : curreny == "MXN"
                          ? productView.data!.height.toString() + ' M'
                          : productView.data!.height.toString() + " M"),
          Divider(),
          showDetail(
              "Load Capacity", productView.data!.loadCapacity.toString()),
          Divider(),
          showDetail(
              "Mileage",
              curreny == "CAD"
                  ? productView.data!.mileage.toString() + ' Km'
                  : curreny == "MXN"
                      ? productView.data!.mileage.toString() + ' Km'
                      : productView.data!.mileage.toString() + " Km"),
          Divider(),
          showDetail(
              "Net Weight",
              curreny == "CAD"
                  ? productView.data!.netWeight.toString() + ' Kg'
                  : curreny == "MXN"
                      ? productView.data!.netWeight.toString() + ' Kg'
                      : productView.data!.netWeight.toString() + ' Kg'),
          Divider(),
          showDetail("Suspension", productView.data!.suspension.toString()),
          Divider(),
          showDetail(
              "WheelBase",
              curreny == "CAD"
                  ? productView.data!.wheelBase.toString() + ' M'
                  : curreny == "MXN"
                      ? productView.data!.wheelBase.toString() + ' M'
                      : productView.data!.wheelBase.toString() + ' In'),
          Divider(),
          productView.data!.transmissionType == null
              ? SizedBox()
              : showDetail("Transmission Type",
                  productView.data!.transmissionType.toString()),
          productView.data!.transmissionType == null ? SizedBox() : Divider(),
          showDetail("Brand", productView.data!.dataBrandName.toString()),
          Divider(),
          showDetail("Model", productView.data!.dataModelName.toString()),
          Divider(),
          showDetail("Year of Production",
              productView.data!.productionYear.toString()),
          Divider(),
          showDetail("Condition", productView.data!.condition.toString()),
          Divider(),
          showDetail("Location", productView.data!.location.toString()),
          Divider(),
          productView.data!.width==null? SizedBox():  showDetail(
              "Width",
              curreny == "CAD"
                  ? productView.data!.width.toString() + ' M'
                  : curreny == "MXN"
                      ? productView.data!.width.toString() + ' M'
                      : productView.data!.width.toString() + ' In'),
          productView.data!.width==null? SizedBox():       Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 25, top: 0),
            child: Text(
              AppLocalizations.instance.text('Description'),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
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
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
      child: Container(
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
      ),
    );
  }

  showColor(String? Heading, var value) {
    print(value);
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
    );
  }
}

Color hexToColor(String code) {
  var p = code.length;
  return new Color(int.parse(code.substring(1, p), radix: 16) + 0xFF000000);
}
