import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../provider/choose_Source_Provider.dart';

class DestinationTripHistry extends StatefulWidget {

  AddTripProvider addTripProvider;
DestinationTripHistry(this.addTripProvider, {Key? key}) : super(key: key);

  @override
  State<DestinationTripHistry> createState() => _DestinationTripHistryState();
}

class _DestinationTripHistryState extends State<DestinationTripHistry> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Consumer<ChooseSourceProvider>(builder: (_, proData, __) {


          if (proData.getLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
           }
          if (
              proData.histryLocation.length == 0)
            return Center(child: Text('No Recent Trips'));
          else
          return ListView.builder(
              itemCount: proData.histryLocation.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) =>
                  ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(proData.histryLocation[index].destination!.address.toString()),
                      onTap: () {
                        proData
                            .addressController.text =
                            proData.histryLocation[index].destination!.address.toString();

                        widget.addTripProvider.DestinationSearch(proData.addressController.text, context, widget.addTripProvider);

                        widget.  addTripProvider.setAddressDestination(proData.histryLocation[index].destination!.address.toString());
                        Navigator.pop(navigatorKey.currentState!.context);

                      }));
        }
        )
    );
  }
}
