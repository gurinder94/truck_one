import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/InsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

class UserJobItem extends StatelessWidget {
  @override
  String? getId;
  String? roleName;
  int index;
  UserJobProvider proData;

  UserJobItem(this.index, this.proData);

  Widget build(BuildContext context) {
    getID();
    var data = context.watch<JobModel>();
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(5),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment,
                children: [
                  CustomImageProfile(
                    width: 50,
                    height: 50,
                    image: IMG_URL + data.companyImg.toString(),
                    boxFit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(data.title.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 3,
                          ),
                          Text(data.companyName.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  wordSpacing: 1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            data.fullAddress!.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .fontSize,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.postedAt.toString(),
                                    style: TextStyle(
                                        color: PrimaryColor, fontSize: 16),
                                  ),
                                  GestureDetector(
                                    child: data.isSaved == true
                                        ? InsiderButton(
                                            Icon: Icon(
                                              Icons.save,
                                              color: PrimaryColor,
                                              size: 20,
                                            ),
                                          )
                                        : OutsideButton(
                                            Icon: Icon(
                                              Icons.save,
                                              size: 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                    onTap: () async {
                                      print(data.isSaved);

                                      data.isSaved == true
                                          ? data.removeSave(
                                              data.id.toString(),
                                              false,
                                              getId.toString(),
                                              context,
                                              index,
                                              proData)
                                          : data.addSave(data.id.toString(),
                                              true, getId.toString(), context);
                                    },
                                  )
                                ],
                              ))
                          // Flexible(
                          //   child: Container(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         SizedBox(
                          //           height: 20,
                          //         ),
                          //         Text(data.title.toString(),
                          //             style: TextStyle(
                          //                 fontSize:17,
                          //                 color: Colors.black,
                          //                 fontWeight: FontWeight.w400)),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Text(data.companyName.toString(),
                          //             style: TextStyle(
                          //                 fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                          //                 color: Colors.black,
                          //                 wordSpacing: 1,
                          //                 fontWeight: FontWeight.w500)),
                          //         SizedBox(
                          //           height: 5,
                          //         ),
                          //         Text(
                          //           data.fullAddress!.toString(),
                          //           overflow: TextOverflow.ellipsis,
                          //           maxLines: 2,
                          //           style: TextStyle(
                          //             fontStyle: FontStyle.italic,
                          //             fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                          //           ),
                          //         ),
                          //         SizedBox(
                          //           height: 10,
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 10, right: 10),
                          //           child: Row(
                          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //             children: [
                          //               Text(
                          //                 data.postedAt.toString(),
                          //                 style:
                          //                     TextStyle(color: PrimaryColor, fontSize: 14),
                          //               ),
                          //               GestureDetector(
                          //                 child: Text(AppLocalizations.instance.text("View Applicants"),
                          //                     style: TextStyle(
                          //                         color: PrimaryColor, fontSize: 14)),
                          //                 onTap: () {
                          //                   getViewApplicants(context, data.id);
                          //                 },
                          //
                          //                 // hitJobSaveApi()
                          //               )
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ),
                ]),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD9D8D8),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.4),
                    offset: Offset(-5.0, -5.0),
                    blurRadius: 10,
                  ),
                ])));
  }

  getID() async {
    getId = await getUserId();
    roleName = await getRoleInfo();
  }
}
