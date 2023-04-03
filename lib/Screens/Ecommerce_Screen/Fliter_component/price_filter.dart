import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class PriceFliter extends StatefulWidget {
  ProductListProvider productListProvider;
  PriceFliter(this. productListProvider);

  @override
  State<PriceFliter> createState() => _PriceFliterState(productListProvider);
}

class _PriceFliterState extends State<PriceFliter> {


  ProductListProvider productListProvider;
  _PriceFliterState(this. productListProvider);
  RangeValues _currentRangeValues =  RangeValues(0, 100000);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height: 2,),

        Center(child: Text(AppLocalizations.instance.text("Price"),style: TextStyle(color: Colors.black,fontSize: 18),)),
        SizedBox(height: 5,),
        Divider(),

        SizedBox(height: 15,),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                width: 70,
                child: InputTextField(
                  child: Center(
                      child: Text(_currentRangeValues.start.round().toString())),
                ),
              ),
              SizedBox(
                height: 30,
                width: 70,
                child: InputTextField(
                  child: Center(
                      child: Text(_currentRangeValues.end.round().toString())),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 100000,
            divisions: 12,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                productListProvider.valuePriceStart= _currentRangeValues.start.round().toString();
                productListProvider.valuePriceEnd= _currentRangeValues.end.round().toString();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                width: 50,
                child: Center(child: Text("Min")),
              ),
              SizedBox(
                height: 30,
                width: 50,
                child: Center(child: Text("Max")),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
