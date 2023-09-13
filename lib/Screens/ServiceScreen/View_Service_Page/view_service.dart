import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/ServiceScreen/View_Service_Page/provider/view_service_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';
import 'Compoment/service_detail_compoment.dart';

class ViewServiceScreen extends StatelessWidget {
  String id;

  ViewServiceScreen(this.id);

  late ViewServiceProvider _serviceProvider;

  @override
  Widget build(BuildContext context) {
    _serviceProvider = context.read<ViewServiceProvider>();
    _serviceProvider.hitViewService(context, id);

    return CustomAppBar(
      visual: false,
      title: AppLocalizations.instance.text("Service Details"),
      child: SingleChildScrollView(
        child: Consumer<ViewServiceProvider>(builder: (_, proData, __) {
          return proData.loading == true
              ? Column(
                  children: [
                    SizedBox(
                      height: 300,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 78,
                    ),
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth > 600) {
                          return eventImage(
                              300,
                              proData.viewServiceList.data!.serviceImage
                                  .toString());
                        } else {
                          return eventImage(
                              250,
                              proData.viewServiceList.data!.serviceImage
                                  .toString());
                        }
                      },
                    ),
                    ServiceCompoment(proData)
                  ],
                );
        }),
      ),
    );
  }

  eventImage(double hei, String bannerImage) {
    return ClipRRect(
      child: Image.network(
        Base_Url_Image_Service + bannerImage,
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
