import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../provider/choose_Source_Provider.dart';

class DestinationAddress extends StatelessWidget {
  AddTripProvider addTripProvider;

  DestinationAddress(this.addTripProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Consumer<ChooseSourceProvider>(builder: (_, proData, __) {
      print(proData.predictions.length);
      return ListView.builder(
          itemCount: proData.predictions.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) =>
              proData.addressController.text.isEmpty
                  ? SizedBox()
                  : ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(proData.predictions[index].description!),
                      onTap: () {
                        proData.addressController.text =
                            proData.predictions[index].description!;
                        // proData.DestinationSearch(proData.addressController.text,context,addTripProvider);

                        addTripProvider.DestinationSearch(
                            proData.addressController.text,
                            context,
                            addTripProvider);

                        Navigator.pop(navigatorKey.currentState!.context);

                        // debugPrint(proData.predictions[index].placeId);
                      }));
    }));
  }
}
