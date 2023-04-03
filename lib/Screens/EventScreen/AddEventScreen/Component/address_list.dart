import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/AddEventScreen/Provider/AddEventProvider.dart';
import 'package:provider/provider.dart';

class AddressList extends StatelessWidget {
  const AddressList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        height: 300,
        child: Consumer<AddEventProvider>(builder: (_, proData, __) {
          // if (proData) {
          //   return Center(
          //     child: CircularProgressIndicator.adaptive(),
          //   );
          // }
          // if (proData.eventListModel == null ||
          //     proData.eventListModel!.data!.length == 0)
          //   return Center(child: Text('No Record Found'));
          // else
          return ListView.builder(
              itemCount: proData.predictions.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) =>

                  ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.pin_drop,
                          color: Colors.white,
                        ),
                      ),
                      title:
                      Text(proData.predictions[index].description!),
                      onTap: () {

                        proData
                              .addressController.text =
                        proData.predictions[index].description!;
                        proData.handleSearch(proData
                              .addressController.text);
                          debugPrint(proData.predictions[index].placeId);
                      }
                  )
          );
        },
        ),
      );
  }
}

    //   Container(
    //     width: double.infinity,
    //     height: 200,
    //     child: ListView.builder(
    //     padding: EdgeInsets.zero,
    //     itemCount: paginationLoading.predictions.length,
    //     itemBuilder: (context, index) {
    //   return ListTile(
    //     leading: CircleAvatar(
    //       child: Icon(
    //         Icons.pin_drop,
    //         color: Colors.white,
    //       ),
    //     ),
    //     title:
    //     Text(paginationLoading.predictions[index].description!),
    //     onTap: () {
    //       setState(() {
    //         paginationLoading
    //             .addressController.text =
    //         paginationLoading.predictions[index].description!;
    //         _addEventProvider.handleSearch(_addEventProvider
    //             .addressController.text);
    //         debugPrint(_addEventProvider.predictions[index].placeId);
    //       });
    //     },
    //   );
    // },
    // ),

