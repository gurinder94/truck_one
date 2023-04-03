import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/Provider/View_fleet_Manger_Provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/view_fleet_Screen/view_fleet_manger.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import '../Provider/fleet_manager_provider.dart';

import 'component/fleet_manager_item.dart';

class FleetManagerList extends StatelessWidget {
  ViewFleetManagerProvider viewFleetManagerProvider;
  FleetManagerProvider fleetManagerProvider;
  FleetManagerList(this.viewFleetManagerProvider,this.fleetManagerProvider );

  @override
  Widget build(BuildContext context) {

    return Consumer<FleetManagerProvider>(builder: (_, proData, __) {
      if (proData.loading) {
    return Center(
      child: CircularProgressIndicator(),
    );
      }
      else if (proData.fleetManagerModel==null)
            return Center(
        child: CircularProgressIndicator(),
      );
      else if(proData.FleetMangerList.length==0)
    return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
      else {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: proData.FleetMangerList.length,
              padding: EdgeInsets.zero,
              controller: fleetManagerProvider.scrollController,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: FeetManagerItem(proData.FleetMangerList[index],proData),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ChangeNotifierProvider(
                              create: (_) => ViewFleetManagerProvider(),

                              child: FleetDetail(proData
                                  .FleetMangerList[index].id
                                  .toString()),
                            )));

                    // ViewFleetManagerProvider
                  },
                );
              }),
        ),

        PaginationWidget(proData.PaginationLoader)
      ],
    );
      }
    });
  }
}
