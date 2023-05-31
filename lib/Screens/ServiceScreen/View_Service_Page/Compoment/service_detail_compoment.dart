import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/provider/view_service_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import '../../../../AppUtils/constants.dart';

class ServiceCompoment extends StatelessWidget {
  ViewServiceProvider serviceProvider;

  ServiceCompoment(this.serviceProvider);

  @override
  Widget build(BuildContext context) {
    var serviceCost = serviceProvider.viewServiceList.data!.currency! +
        ' ' +
        serviceProvider.viewServiceList.data!.serviceCost.toString();
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 14),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                capitalize(serviceProvider.viewServiceList.data!.serviceName
                    .toString()),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Heading('Service cost', serviceCost),
            Heading(
              'Phone Number',
              '+1' +
                  ' ' +
                  serviceProvider.numbers,
            ),
            Heading('Location',
                serviceProvider.viewServiceList.data!.address.toString()),
            Heading("Description", ''),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                  serviceProvider.viewServiceList.data!.description.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.normal,
                  )),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
          BoxShadow(
            color: Color(0xFFD9D8D8),
            offset: Offset(5.0, 5.0),
            blurRadius: 7,
          ),
          BoxShadow(
            color: Color(0xFFD9D8D8),
            offset: Offset(-1.0, -1.0),
            blurRadius: 7,
          ),
        ]),
      ),
    );
  }

  Heading(String head, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 120,
              child: Text(
                AppLocalizations.instance.text(head),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )),
          SizedBox(
            width: 10,
          ),
          Flexible(child: Text(value))
        ],
      ),
    );
  }
}
