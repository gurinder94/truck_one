import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

import '../../../../Language_Screen/application_localizations.dart';
import 'ViewApplicants.dart';

class JobItem extends StatelessWidget {
  @override
  var getId;
  late JobListProvider _jobListProvider;

  Widget build(BuildContext context) {
    _jobListProvider = Provider.of<JobListProvider>(context, listen: false);
    var data = context.watch<JobModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: Row(
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
                children: [
                  SizedBox(height: 4,),
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
                      fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data.postedAt.toString(),
                        style:
                        TextStyle(color: PrimaryColor, fontSize: 14),
                      ),
                      GestureDetector(
                        child: Text(AppLocalizations.instance.text("View Applicants"),
                            style: TextStyle(
                                color: PrimaryColor, fontSize: 14)),
                        onTap: () {
                          getViewApplicants(context, data.id);
                        },

                        // hitJobSaveApi()
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),

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
          ],
        ),
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
            ]),
      ),
    );


  }

  getViewApplicants(BuildContext context, String? id) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewApplicants(id)));
  }
}
