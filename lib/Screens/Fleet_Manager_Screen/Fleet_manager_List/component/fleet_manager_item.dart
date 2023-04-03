import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/Fleet_manager_model/fleet_manager_list_model.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Edit_fleet_manager_screen/edit_truck_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Edit_fleet_manager_screen/edit_truck_manager_screen.dart';
import 'package:my_truck_dot_one/Screens/Fleet_Manager_Screen/Provider/fleet_manager_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import '../../Edit_fleet_manager_screen/edit_trailer_manager.dart';

class FeetManagerItem extends StatelessWidget {
  Datum fleetMangerList;
  FleetManagerProvider proData;

  FeetManagerItem(this.fleetMangerList, this.proData);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            fleetMangerList.vehicleType == "TRAILER"
                ? Container(
                    width: 120,
                    height: 100,
                    child: Image.network(
                        Base_Url_Fleet_trailer +
                            fleetMangerList.image.toString(),
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt()));
                        },
                        errorBuilder: (a, b, c) => Image.asset(
                              'icons/defaultImage.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 160,
                            )),
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                  )
                : Container(
                    width: 120,
                    height: 100,
                    child: Image.network(
                        Base_Url_Fleet_truck + fleetMangerList.image.toString(),
                        fit: BoxFit.fill,
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt()));
                        },
                        errorBuilder: (a, b, c) => Image.asset(
                              'icons/defaultImage.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 160,
                            )),
                    decoration: BoxDecoration(shape: BoxShape.rectangle),
                  ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    proData.roleName=="ENDUSER"?  Align(
                      alignment: Alignment.topRight,
                      child: PopMenuBar(
                          iconsName: Icons.more_vert,
                          val: 1,
                          userMenuItems: fleetMangerList.isActive == true &&
                                  fleetMangerList.isDeleted == true
                              ? actionArchiveList
                              : fleetMangerList.isActive == true &&
                                      fleetMangerList.isDeleted == false
                                  ? activeAction
                                  : fleetMangerList.isActive == false &&
                                          fleetMangerList.isDeleted == true
                                      ?  actionArchiveList
                                      : activeAction,
                          containerDecoration: 3,
                          onDoneFunction: (value) {
                            switch (value) {
                              case 1:
                                fleetMangerList.vehicleType == "TRAILER"
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      EditTruckManagerProvider(
                                                          fleetMangerList.id!),
                                                  child: EditTrailerManager()),
                                        )).then((value) {
                                        proData.refresh();
                                        proData.hitFLeetList(context);
                                      })
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      EditTruckManagerProvider(
                                                          fleetMangerList.id!),
                                                  child: EditTruckManager()),
                                        )).then((value) {
                                        proData.refresh();
                                        proData.hitFLeetList(context);
                                      });
                                break;
                              case 2:
                                DialogUtils.showMyDialog(
                                  context,
                                  onDoneFunction: () async {
                                    proData.hitDeleteFleetManager(
                                        proData, fleetMangerList);
                                  },
                                  oncancelFunction: () =>
                                      Navigator.pop(context),
                                  title: fleetMangerList.isDeleted == false
                                      ? "Archive"
                                      : "Unarchived",
                                  alertTitle: fleetMangerList.isDeleted == false
                                      ? "fleet_manager_archive"
                                      : "fleet_manager_UnArchive",
                                  btnText: "Done",
                                );
                                break;
                              case 3:
                                DialogUtils.showMyDialog(
                                  context,
                                  onDoneFunction: () async {
                                    proData.hitAtive(
                                        proData,
                                        fleetMangerList,
                                        fleetMangerList.isActive == true
                                            ? true
                                            : false);
                                  },
                                  oncancelFunction: () =>
                                      Navigator.pop(context),
                                  title: fleetMangerList.isActive == false
                                      ? "Active"
                                      : "In-Active",
                                  alertTitle: fleetMangerList.isActive == false
                                      ? "fleet_manager_active"
                                      : "fleet_manager_InActive",
                                  btnText: "Done",
                                );
                                break;
                            }
                          }),
                    ):SizedBox(),
                    displayText(
                        AppLocalizations.instance.text('Name'),
                        showCapitalize(fleetMangerList.name.toString()),
                        AppLocalizations.instance.text('Vehicle Type'),
                        fleetMangerList.vehicleType.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    displayText(
                        AppLocalizations.instance.text('Weight') +
                            ' ' +
                            "(lbs)",
                        fleetMangerList.weight.toString(),
                        AppLocalizations.instance.text('Height') +
                            ' ' +
                            "(lbs)",
                        fleetMangerList.height.toString()),
                  ],
                ))
          ],
        ),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
      ),
    );
  }

  displayText(String name, String value, String name2, String value2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '$value',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$name2',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              '$value2',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        )),
      ],
    );
  }
}
