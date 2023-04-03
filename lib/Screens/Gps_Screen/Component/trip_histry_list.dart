import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../provider/add_Trip_Provider.dart';
import '../provider/choose_Source_Provider.dart';



class TripHistryList extends StatelessWidget {

  AddTripProvider addTripProvider;
TripHistryList( this.addTripProvider,  {Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
        child:Consumer<ChooseSourceProvider>(builder: (_, proData, __) {
          print(proData.predictions.length);

          if (proData. getLoading ) {
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
                      title: Text(proData.histryLocation[index].source!.address.toString()),
                      onTap: () {
                        proData
                            .addressController.text =
                            proData.histryLocation[index].source!.address.toString();

                        addTripProvider.setAddressChooseSource(proData.histryLocation[index].source!.address.toString());

                         addTripProvider.setAddress( proData.histryLocation[index].source!.location!.coordinates![1],  proData.histryLocation[index].source!.location!.coordinates![0]);
                         Navigator.pop(navigatorKey.currentState!.context);
                        // debugPrint(proData.predictions[index].placeId);
                      }));
        }
        )
    );
  }
}
