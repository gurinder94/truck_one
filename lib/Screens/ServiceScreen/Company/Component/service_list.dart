import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/Company/Component/service_item.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/Company/Provider/service_provider_list.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/provider/view_service_provider.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/view_service.dart';

import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class ServiceListPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Consumer<ServiceProvider>(builder: (context, noti, child) {
        if (noti.loading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (noti.serviceList.length == 0)
          return Center(
              child: Text(AppLocalizations.instance.text('No Record Found')));
        else
          return ListView.builder(
              itemCount: noti.serviceList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: ServiceItem(noti.serviceList[index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>     ChangeNotifierProvider(create: (_) => ViewServiceProvider(),
                              child: ViewServiceScreen(
                                  noti.serviceList[index].id.toString()),
                            )));
                  },
                );
              });
      }),
    );
  }
}
