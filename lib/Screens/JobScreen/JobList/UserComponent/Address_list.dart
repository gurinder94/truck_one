import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/UserJobProvider.dart';

class JobAddressList extends StatelessWidget {
  const JobAddressList({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return
      Container(
        width: double.infinity,
        height: 230,

        child: Consumer<UserJobProvider>(builder: (_, proData, __) {
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


                      }
                  )
          );
        },
        ),
      );
  }
}
