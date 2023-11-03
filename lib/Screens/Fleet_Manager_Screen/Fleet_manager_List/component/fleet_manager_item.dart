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
  FleetManagerProvider proData;

  int index;
  List<Datum> fleetMangerList;

  FeetManagerItem(this.fleetMangerList, this.proData, this.index);

  @override
  Widget build(BuildContext context) {
    print(index);
    print(Base_Url_Fleet_truck + fleetMangerList[index].image.toString());
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            fleetMangerList[index] == null
                ? SizedBox()
                : fleetMangerList[index].vehicleType == "TRAILER"
                    ? Container(
                        width: 120,
                        height: 100,
                        child: Image.network(
                            Base_Url_Fleet_truck +
                                fleetMangerList[index].image.toString(),
                            fit: BoxFit.fill,
                            errorBuilder: (a, b, c) => Image.asset(
                                  'assets/default.png',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 160,
                                )),
                        decoration: BoxDecoration(shape: BoxShape.rectangle),
                      )
                    : Container(
                        width: 120,
                        height: 100,
                        child: Image.network(
                            Base_Url_Fleet_truck +
                                fleetMangerList[index].image.toString(),
                            fit: BoxFit.fill,
                            errorBuilder: (a, b, c) => Image.asset(
                                  'assets/default.png',
                                  fit: BoxFit.fill,
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
                    proData.roleName == "ENDUSER"
                        ? Align(
                            alignment: Alignment.topRight,
                            child: PopMenuBar(
                                iconsName: Icons.more_vert,
                                val: 1,
                                userMenuItems: fleetMangerList[index]
                                                .isActive ==
                                            true &&
                                        fleetMangerList[index].isDeleted == true
                                    ? actionArchiveList
                                    : fleetMangerList[index].isActive == true &&
                                            fleetMangerList[index].isDeleted ==
                                                false
                                        ? activeAction
                                        : fleetMangerList[index].isActive ==
                                                    false &&
                                                fleetMangerList[index]
                                                        .isDeleted ==
                                                    true
                                            ? actionArchiveList
                                            : activeAction,
                                containerDecoration: 3,
                                onDoneFunction: (value) {
                                  switch (value) {
                                    case 1:
                                      fleetMangerList[index].vehicleType ==
                                              "TRAILER"
                                          ? Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider(
                                                        create: (_) =>
                                                            EditTruckManagerProvider(
                                                                fleetMangerList[
                                                                        index]
                                                                    .id!),
                                                        child:
                                                            EditTrailerManager()),
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
                                                                fleetMangerList[
                                                                        index]
                                                                    .id!),
                                                        child:
                                                            EditTruckManager()),
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
                                              proData, fleetMangerList[index]);
                                        },
                                        oncancelFunction: () =>
                                            Navigator.pop(context),
                                        title:
                                            fleetMangerList[index].isDeleted ==
                                                    false
                                                ? "Archive"
                                                : "Unarchived",
                                        alertTitle:
                                            fleetMangerList[index].isDeleted ==
                                                    false
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
                                              fleetMangerList[index],
                                              fleetMangerList[index].isActive ==
                                                      true
                                                  ? true
                                                  : false);
                                        },
                                        oncancelFunction: () =>
                                            Navigator.pop(context),
                                        title:
                                            fleetMangerList[index].isActive ==
                                                    false
                                                ? "Active"
                                                : "In-Active",
                                        alertTitle:
                                            fleetMangerList[index].isActive ==
                                                    false
                                                ? "fleet_manager_active"
                                                : "fleet_manager_InActive",
                                        btnText: "Done",
                                      );
                                      break;
                                  }
                                }),
                          )
                        : SizedBox(),
                    displayText(
                        AppLocalizations.instance.text('Name'),
                        showCapitalize(fleetMangerList[index].name.toString()),
                        AppLocalizations.instance.text('Vehicle Type'),
                        fleetMangerList[index].vehicleType.toString()),
                    SizedBox(
                      height: 10,
                    ),
                    displayText(
                        AppLocalizations.instance.text('Weight') +
                            ' ' +
                            "(lbs)",
                        fleetMangerList[index].weight.toString(),
                        AppLocalizations.instance.text('Height') +
                            ' ' +
                            "(lbs)",
                        fleetMangerList[index].height.toString()),
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
