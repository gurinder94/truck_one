import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/LoginScreen/LoginScreen.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserForm.dart';

class UserHeadPart extends StatelessWidget {
  // UserProfileProvider ?profileProvider;
  var profileData;
  var image;
  var bannerimage;
  var loading;

  var imagelogo;
  var uploadbanner;
  bool profileComplete;
  String roleName;

  UserHeadPart(this.profileComplete, this.roleName);

  Widget build(BuildContext context) {
    var profileProvider = Provider.of<UserProfileProvider>(context);
    var profile = context.watch<UserProfileProvider>();

    String? type;

    image = profileData = profile.userModel == null
        ? ''
        : profile.userModel!.data!.proImage.toString();
    imagelogo = profile.imageLogo == null ? '' : profile.imageLogo;
    bannerimage = profileData = profile.userModel == null
        ? ''
        : profile.userModel!.data!.bannerImage.toString();

    // TODO: implement build
    return Stack(
      children: [
        SizedBox(
            height: 300,
            child: profile.imagebanner == null
                ? CustomImage(
                    image: profile_banner_url + bannerimage,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
                    height: 280)
                : CustomImage(
                    image: profile_banner_url + profile.imagebanner,
                    width: double.infinity,
                    boxFit: BoxFit.fill,
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
                                            builder: (context) =>
                                                LoginScreen()),
                                        (Route<dynamic> route) => false);
                                  },
                                  oncancelFunction: () =>
                                      Navigator.pop(context),
                                  title: 'Logout!',
                                  alertTitle: "'Are you sure want to logout ?",
                                  btnText: "Done",
                                );
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text(
                                  AppLocalizations.instance.text('Logout')),
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
        UserForm(roleName),
        Positioned(
          left: 0,
          right: 0,
          top: 200,
          child: profile.imageLogo == null
              ? CustomImageProfile(
                  image: IMG_URL + image,
                  width: 90,
                  boxFit: BoxFit.contain,
                  height: 90)
              : CustomImageProfile(
                  image: IMG_URL + profile.imageLogo,
                  width: 90,
                  boxFit: BoxFit.contain,
                  height: 90),
        ),
        Positioned(
          top: 260,
          right: 0,
          left: 70,
          child: GestureDetector(
            child: Container(
              height: 35,
              width: 35,
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
              profileProvider.getFromGallery(type!, context);
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
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 10)],
              ),
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
            ),
            onTap: () {
              type = "COMPANYBANNER";
              profileProvider.getFromGallery(type!, context);
            },
          ),
        ),
      ],
    );
  }
}
