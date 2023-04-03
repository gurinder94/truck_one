import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/company_leave_model.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/drop_down_box.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/Dispatcher_Screen/Provider/Dispatcher_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

late Widget child;

Future<dynamic> TripCancelAlertBox(BuildContext context,
    String description,
    DispatcherProvider listProvider,
    String driverId,
    String tripid,
    String typeReason,) async {
  return await showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Color(0xFFEEEEEE),
              shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              title: Text(typeReason == "CANCELLED"
                  ? AppLocalizations.instance.text('Cancel')
                  : typeReason == "ACTIVE"
                  ? AppLocalizations.instance.text('Active')
                  : typeReason == "COMPLETED"
                  ?AppLocalizations.instance.text('Completed')
                  : ''),
              content: Column(
                children: [
                  Text(AppLocalizations.instance.text("Trip Cancel Message")),
                  SizedBox(
                    height: 10,
                  ),
                  typeReason == "CANCELLED"
                      ? Consumer<DispatcherProvider>(
                      builder: (context, notif, __) {
                        if (notif.reasonLeaveLoad) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        return DropDownBox(
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 10, right: 5),
                            child: DropdownButton<String>(
                              value: notif.reasonType,
                              isExpanded: true,
                              hint: Text(
                                AppLocalizations.instance
                                    .text("Select Trip Cancel"),
                                style: TextStyle(fontSize: 16),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                              ),
                              iconSize: 24,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(),
                              onChanged: (String? newValue) {
                                var id = indexState(newValue!, notif);
                                notif.setSelectedItem(newValue, id);
                              },
                              items: notif.reasonLeaveListModel.data!
                                  .map((ReasonLeaveModel value) {
                                return new DropdownMenuItem<String>(
                                  value: value.reasonTitle,
                                  child: new Text(
                                      value.reasonTitle.toString(),
                                      style:
                                      new TextStyle(color: Colors.black)),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      })
                      : SizedBox()
                ],
              ),
              scrollable: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: PrimaryColor,
                    highlightColor: Colors.white,
                    child: Text(AppLocalizations.instance.text('No'),
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    onTap: () async {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(),
                Consumer<DispatcherProvider>(builder: (context, notif, __) {
                  return notif.reasonLeaveButton
                      ? CircularProgressIndicator()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      splashColor: PrimaryColor,
                      highlightColor: Colors.white,
                      child: Text(AppLocalizations.instance.text('Yes'),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16)),
                      onTap: () async {
                        if (notif.reasonType != null) {
                          listProvider.hitReasonCancel(
                              listProvider, driverId, tripid, typeReason);
                        }
                        else {
                          showMessage("Please select reason");
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
        );
      });
}

indexState(String s, DispatcherProvider notif) {
  final index = notif.reasonLeaveListModel.data!
      .indexWhere((element) => element.reasonTitle == s);
  return notif.reasonLeaveListModel.data![index].id;
}
