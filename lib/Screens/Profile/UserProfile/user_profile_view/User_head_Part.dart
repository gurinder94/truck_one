import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/lower_part.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/dialog_box.dart';

import '../Userprofile.dart';

class UserHeadPart extends StatelessWidget {
  late UserProfileViewProvider proData;

  UserHeadPart(this.proData);

  @override
  Widget build(BuildContext context) {


    return Stack(

      children: [

        Container(
            width: double.infinity,
            height: 300,
            child:CustomImage(image: proData.userModel!.data!.bannerImage==null?'':
            profile_banner_url  + proData.userModel!.data!.bannerImage.toString(), width: double.infinity, boxFit:BoxFit.cover, height:300)),
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   height: 90,
        //     padding: EdgeInsets.all(10),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //           onPressed: () => Navigator.pop(context),
        //           icon: Icon(
        //             Icons.arrow_back,
        //             color: Colors.white,
        //           )),
        //       Text(
        //         'Profile',
        //         style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 20,
        //             fontWeight: FontWeight.w600),
        //       ),
        //       proData.checkRole=="DRIVER"?  PopupMenuButton(
        //         padding: EdgeInsets.all(10),
        //
        //         onSelected: (value) {
        //           switch (value) {
        //             case 1:
        //               Navigator.pushReplacement(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => ProfileUser(true)));
        //               break;
        //             case 2:
        //               proData.valueItemSelected=null;
        //               someDialog(
        //                 context,
        //                 "You will not be able to work as a driver for this company anymore. Please select a reason to leave.",
        //               );
        //               break;
        //           }
        //         },
        //         itemBuilder: (context) => [
        //           PopupMenuItem(
        //             child: Text("Edit"),
        //             value: 1,
        //           ),
        //           PopupMenuItem(
        //             child: Text("Leave company"),
        //             value: 2,
        //           ),
        //         ],
        //         child: Icon(
        //           Icons.more_vert,
        //           color: Colors.white,
        //         ),
        //       ): PopupMenuButton(
        //         padding: EdgeInsets.all(10),
        //         onSelected: (value) {
        //           switch (value) {
        //             case 1:
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => ProfileUser(true)));
        //               break;
        //
        //           }
        //         },
        //         itemBuilder: (context) => [
        //           PopupMenuItem(
        //             child: Text("Edit"),
        //             value: 1,
        //           ),
        //
        //         ],
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Icon(
        //             Icons.more_vert,
        //             color: Colors.white,
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        //     decoration: BoxDecoration(
        //         gradient: LinearGradient(colors: [
        //           Colors.transparent,
        //           Color(0x4B525050),
        //           Colors.transparent,
        //         ], begin: Alignment.topCenter, end: Alignment.bottomCenter))
        // ),
        Padding(
          padding: EdgeInsets.only(top: 20),


          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 80,
            padding: EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(

                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Text(
                  AppLocalizations.instance.text("Profile"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                      proData.checkRole=="DRIVER"?  PopupMenuButton(
                        padding: EdgeInsets.all(10),

                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileUser(true)));
                              break;
                            case 2:
                              proData.valueItemSelected=null;
                              someDialog(
                                context,
                                "You will not be able to work as a driver for this company anymore. Please select a reason to leave.",
                              );
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Edit")),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Leave company")),
                            value: 2,
                          ),
                        ],
                        child: Icon(
                          Icons.more_vert,
                          color: Colors.white,
                        ),
                      ): PopupMenuButton(
                        padding: EdgeInsets.all(10),
                        onSelected: (value) {
                          switch (value) {
                            case 1:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileUser(true)));
                              break;

                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Edit")),
                            value: 1,
                          ),

                        ],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Color(0x4B525050),
                  Colors.transparent,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),),
        ),
        LowerPart(proData),
        Positioned(
          left: 0,
          right: 0,
          top: 200,
          child: CustomImageProfile(image:proData.userModel!.data!.image==null? '':
          IMG_URL + proData.userModel!.data!.image.toString(),width: 90, boxFit: BoxFit.contain, height: 90),
        ),
      ],
    );
  }
}
