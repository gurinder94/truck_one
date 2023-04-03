import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Provider/Dispatcher_provider.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import 'Dispatcher_Item.dart';

class DispatcherList extends StatelessWidget {
  DispatcherProvider listProvider;
  String type;
   DispatcherList(this. listProvider,this.type , );

  @override
  Widget build(BuildContext context) {
    return    Expanded(child:
    Consumer<DispatcherProvider>(builder: (_, proData, __) {
      if (proData.tripPlannerListLoad) {
        return Center(
          child: CircularProgressIndicator.adaptive(),
        );
      }
      if (proData.tripList.length == 0)
        return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
      else
        return ListView.builder(
            padding: EdgeInsets.zero,
            controller: proData.scrollController,
            itemCount: proData.tripList.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider<TripPlannerModel>.value(

                  value: proData.tripList[index],

                  child: DispatcherItem(proData,index,type));
            });
    }));
  }
}
