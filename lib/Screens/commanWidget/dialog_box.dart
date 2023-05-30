import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ProfileModel/company_leave_model.dart';

import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';

import 'package:provider/provider.dart';

import 'drop_down_box.dart';

late Widget child;
var valueItemSelected;

UserProfileViewProvider _profileViewProvider = UserProfileViewProvider();

Future<dynamic> someDialog(BuildContext context, String description) async {
  _profileViewProvider =
      Provider.of<UserProfileViewProvider>(context, listen: false);
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
              title: Text('Leave'),
              content: Column(
                children: [
                  Text(description.toString()),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<UserProfileViewProvider>(
                      builder: (context, notif, __) {
                    return notif.companyLeaveModel.data == null
                        ? SizedBox()
                        : DropDownBox(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 5),
                              child: DropdownButton<String>(
                                value: notif.valueItemSelected,
                                isExpanded: true,
                                hint: Text(
                                  'Select Company Leave',
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
                                  notif.setSelectedItem(newValue!);
                                },
                                items: notif.companyLeaveModel.data!
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
                ],
              ),
              scrollable: true,
              actions: <Widget>[
                InkWell(
                  splashColor: PrimaryColor,
                  highlightColor: Colors.white,
                  child: new Text('No'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                Selector<UserProfileViewProvider, bool>(
                    selector: (_, provider) => provider.companyLeft,
                    builder: (context, paginationLoading, child) {
                      return paginationLoading == true
                          ? CircularProgressIndicator()
                          : IgnorePointer(
                              ignoring:
                                  _profileViewProvider.valueItemSelected == null
                                      ? true
                                      : false,
                              child: InkWell(
                                splashColor: PrimaryColor,
                                highlightColor: Colors.white,
                                child: Text('Yes'),
                                onTap: () async {
                                  _profileViewProvider.hitCompanyLeave(context);
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
