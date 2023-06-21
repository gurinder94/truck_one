import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/Component/gps_address_list.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/Component/trip_histry_list.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/input_shape.dart';
import '../provider/choose_Source_Provider.dart';

class ChooseSource extends StatefulWidget {
  TextEditingController chooseSource;
  AddTripProvider addTripProvider;
  String? title;

  ChooseSource(this.chooseSource, this.title, this.addTripProvider);

  @override
  State<ChooseSource> createState() => _ChooseSourceState();
}

class _ChooseSourceState extends State<ChooseSource> {
  late ChooseSourceProvider _chooseSourceProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chooseSourceProvider = context.read<ChooseSourceProvider>();
    _chooseSourceProvider.addressController.text = widget.chooseSource.text;

    _chooseSourceProvider.hitTripHistry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            InputShape(
              child: TextFormField(
                controller: _chooseSourceProvider.addressController,
                decoration: InputDecoration(
                    hintText: widget.title ?? 'Choose location',
                    border: InputBorder.none,
                    prefixIcon: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _chooseSourceProvider.addressController.text = "";

                          widget.chooseSource.text = "";
                          widget.addTripProvider.setvalue("");
                        },
                        icon: Icon(Icons.close))),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _chooseSourceProvider.autoCompleteSearch(value);
                  } else if (value.isEmpty) {
                    _chooseSourceProvider.addressController.text = "";

                    widget.chooseSource.text = "";
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: Container(
                      child: Icon(Icons.my_location_outlined,
                          color: Colors.blue, size: 20),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.2),
                        shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Your Location")
                ],
              ),
              onTap: () {
                _chooseSourceProvider.addressController.text = "Your location";
                widget.chooseSource.text = "Your location";
                if (widget.addTripProvider.model.routes == null)
                  _chooseSourceProvider.getLocation(widget.addTripProvider);
                else {
                  widget.addTripProvider.setResetRoute();
                  _chooseSourceProvider.getLocation(widget.addTripProvider);
                }
              },
            ),
            Divider(),
            // Selector<ChooseSourceProvider, var>(
            //     selector: (_, provider) =>
            //     provider.predictions.length,
            //     builder: (context, paginationLoading, child) {
            //
            //       return _chooseSourceProvider
            //           .addressController == 5
            //           ? SizedBox()
            //           :  AddressList();
            //     }),
            Selector<ChooseSourceProvider, dynamic>(
                selector: (_, provider) => provider.addressController.text,
                builder: (context, paginationLoading, child) {
                  return paginationLoading == ""
                      ? TripHistryList(widget.addTripProvider)
                      : AddressList(widget.addTripProvider);
                }),
          ],
        ),
      ),
    );
  }
}
