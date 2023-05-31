import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ServiceModel/ServiceListModel.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

class ServiceItem extends StatelessWidget {
  Datum serviceList;

  ServiceItem(this.serviceList);

  @override
  Widget build(BuildContext context) {
    var Size =MediaQuery.of(context).size;
    return Container(
        width: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFFEEEEEE),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFA7A7A7), blurRadius: 5, offset: Offset(0, 1))
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth > 600) {
                return eventImage(300, serviceList.serviceImage.toString());
              } else {
                return eventImage(200, serviceList.serviceImage.toString());
              }
            },
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalize(  serviceList.serviceName.toString(),),

                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                         ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      AppLocalizations.instance.text('Location') +
                          ' : ' +
                        serviceList.address.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                  ]))
        ]));
  }

  eventImage(double hei, String bannerImage) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: Image.network(
        Base_Url_Image_Service + serviceList.serviceImage.toString(),
        height: hei,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              alignment: Alignment.center,
              child: Image.network(
                "https://images.pexels.com/photos/2199293/pexels-photo-2199293.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                fit: BoxFit.cover,
                height: hei,
                width: double.infinity,
              ));
        },
      ),
    );
  }
}
