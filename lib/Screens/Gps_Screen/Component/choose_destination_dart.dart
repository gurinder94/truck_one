import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/Component/trip_histry_destination_list.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../commanWidget/input_shape.dart';
import '../provider/choose_Source_Provider.dart';
import 'destination_Address_list.dart';

class ChooseNextDestination extends StatefulWidget {
  TextEditingController chooseDestination;
  AddTripProvider addTripProvider;

  ChooseNextDestination(this.chooseDestination, this.addTripProvider);

  @override
  State<ChooseNextDestination> createState() => _ChooseNextDestinationState();
}

class _ChooseNextDestinationState extends State<ChooseNextDestination> {
  late ChooseSourceProvider _chooseSourceProvider;

  void initState() {
    // TODO: implement initState
    super.initState();
    _chooseSourceProvider = context.read<ChooseSourceProvider>();
    _chooseSourceProvider.addressController.text =
        widget.chooseDestination.text;
    _chooseSourceProvider.hitTripHistry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_BG,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          InputShape(
            child: TextFormField(
              controller: _chooseSourceProvider.addressController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _chooseSourceProvider.autoCompleteSearch(value);
                } else if (value.isEmpty) {
                  _chooseSourceProvider.addressController.text = "";
                  widget.chooseDestination.text = "";
                }
              },
              decoration: InputDecoration(
                  hintText: 'Choose Destination',
                  border: InputBorder.none,
                  prefixIcon: GestureDetector(
                    child: Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        _chooseSourceProvider.addressController.text = "";

                        widget.chooseDestination.text = "";
                        widget.addTripProvider
                            .setvalueDestinationsTextEditer("");
                      },
                      icon: Icon(Icons.close))),
            ),
          ),
          Divider(),
          Selector<ChooseSourceProvider, dynamic>(
              selector: (_, provider) => provider.addressController.text,
              builder: (context, paginationLoading, child) {
                return paginationLoading == ""
                    ? DestinationTripHistry(widget.addTripProvider)
                    : DestinationAddress(widget.addTripProvider);
              }),
        ]),
      ),
    );
  }
}
