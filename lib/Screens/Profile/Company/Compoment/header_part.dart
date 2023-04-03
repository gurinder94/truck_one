import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/Company_form.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../LoginScreen/LoginScreen.dart';
import '../../../commanWidget/Comman_Alert_box.dart';

class HeaderPart extends StatelessWidget {
  String? type;

  var bannerImage;
  var logoImage;
  late ProfileProvider _profileProvider;
  bool profileComplete;

  HeaderPart(this.profileComplete);

  Widget build(BuildContext context) {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var profileProvider = context.watch<ProfileProvider>();
    bannerImage = profileProvider.companyModel == null
        ? ''
        : profileProvider.companyModel!.bannerImage.toString();

    logoImage = profileProvider.companyModel == null
        ? ''
        : profileProvider.companyModel!.companyLogo.toString();

    // TODO: implement build
    return Stack(
      children: [
        SizedBox(
            height: 300,
            width: double.infinity,
            child: CustomImage(
                image: profile_banner_url + bannerImage,
                width: double.infinity,
                boxFit: BoxFit.cover,
                height: 280)),

        Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  profileComplete == false
                      ? SizedBox()
                      : SizedBox(
                    width: 35,
                    height: 35,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                  Text(
                    AppLocalizations.instance.text('Profile'),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  profileComplete == false
                      ? PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 1:
                          DialogUtils.showMyDialog(
                            context,
                            onDoneFunction: () async {
                              final pref =
                              await SharedPreferences.getInstance();
                              await pref.clear();

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                      (Route<dynamic> route) => false);
                            },
                            oncancelFunction: () => Navigator.pop(context),
                            title: 'Logout!',
                            alertTitle: "'Are you sure want to logout ?",
                            btnText: "Done",
                          );
                          break;
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text("Logout"),
                        value: 1,
                      ),
                    ],
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )
                      : SizedBox()
                ],
              ),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Color(0x4B525050),
                  Colors.transparent,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
        CompanyForm(),
        Positioned(
          left: 0,
          right: 0,
          top: 200,
          child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.all(3),
            clipBehavior: Clip.antiAlias,
            alignment: Alignment.bottomCenter,
            child: Container(
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.bottomCenter,
              child: CustomImageProfile(
                  image: logoImage == '' ? '' : IMG_URL + logoImage,
                  width: 100,
                  boxFit: BoxFit.fitHeight,
                  height: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEEEEEE),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFD9D8D8),
                    offset: Offset(5.0, 5.0),
                    blurRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(.5),
                    blurRadius: 4,
                  ),
                ]),
          ),
        ),

        Positioned(
          top: 250,
          right: 0,
          left: 80,
          child: GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1A62A9),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            onTap: () {
              type = "COMPANYLOGO";
              _profileProvider.getFromGallery(type!, context);
              _profileProvider.getImageUploadLogoShow(true);
            },
          ),
        ),
        Positioned(
          top: 210,
          right: 30,
          child: GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1A62A9),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            onTap: () {
              type = "COMPANYBANNER";

              _profileProvider.getFromGallery(type!, context);
            },
          ),
        ),

        // Positioned(
        //           left: 10,
        //           top: 0,
        //  right: 10,
        //  child:  Container(
        //    width: MediaQuery.of(context).size.width,
        //    height: 80,
        //    child: Row(
        //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //      children: [
        //        profileComplete == true
        //                         ?     IconButton(
        //            onPressed: () => Navigator.pop(context),
        //            icon: Icon(
        //              Icons.arrow_back,
        //              color: Colors.white,
        //            )):SizedBox(),
        //        Text(
        //          'Profile',
        //          style: TextStyle(
        //              color: Colors.white,
        //              fontSize: 20,
        //              fontWeight: FontWeight.w600),
        //        ),
        //        profileComplete == true
        //            ?  SizedBox():              PopupMenuButton(
        //                       onSelected: (value) {
        //                         switch (value) {
        //                           case 1:
        //                             DialogUtils.showMyDialog(
        //                               context,
        //                               onDoneFunction: () async {
        //                                 final pref = await SharedPreferences.getInstance();
        //                                 await pref.clear();
        //
        //                                 Navigator.of(context).pushAndRemoveUntil(
        //                                     MaterialPageRoute(
        //                                         builder: (context) => LoginScreen()),
        //                                         (Route<dynamic> route) => false);
        //                               },
        //                               oncancelFunction: () =>
        //                                   Navigator.pop(context),
        //                               title: 'Logout!',
        //                               alertTitle:
        //                               "Are you sure want to logout ?",
        //                               btnText: "Done",
        //                             );
        //                             break;
        //                         }
        //                       },
        //                       itemBuilder: (context) => [
        //                         PopupMenuItem(
        //                           child: Text("LogOut"),
        //                           value: 1,
        //                         ),
        //                       ],
        //                       child: Icon(
        //                         Icons.more_vert,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //    decoration: BoxDecoration(
        //        gradient: LinearGradient(
        //          begin: Alignment.topRight,
        //          end: Alignment.bottomLeft,
        //          colors: [
        //            Colors.black45,
        //            Colors.black45,
        //          ],
        //        )
        //    ),
        //               )
        //
        //
        // )
      ],
    );
  }
}
