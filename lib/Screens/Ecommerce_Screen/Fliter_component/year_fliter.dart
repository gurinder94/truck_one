import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/e_commerce_Product_List/Provider/ecommerce_product_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';

class YearFliter extends StatefulWidget {
  ProductListProvider productListProvider;

  YearFliter(
    this.productListProvider,
  );

  @override
  State<YearFliter> createState() => _YearFliterState(
        productListProvider,
      );
}

class _YearFliterState extends State<YearFliter> {
  ProductListProvider productListProvider;

  _YearFliterState(
    this.productListProvider,
  );

  RangeValues _currentRangeValues = RangeValues(1990, 2023);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 2,
        ),
        Center(
            child: Text(
          AppLocalizations.instance.text("Year"),
          style: TextStyle(color: Colors.black, fontSize: 18),
        )),
        SizedBox(
          height: 5,
        ),
        Divider(),
        SizedBox(
          height: 15,
        ),
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
                      child:
                          Text(_currentRangeValues.start.round().toString())),
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
          padding: EdgeInsets.all(10.0),
          child: RangeSlider(
            values: _currentRangeValues,
            min: 1990,
            max: 2023,
            divisions: 100,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),

            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                productListProvider.valueYearStart =
                    _currentRangeValues.start.round().toString();
                productListProvider.valueYearEnd =
                    _currentRangeValues.end.round().toString();
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
