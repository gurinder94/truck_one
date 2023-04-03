import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/Provider/UserProfileProvider.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/user_profile_view.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../Language_Screen/application_localizations.dart';

class UserTopProfileWidget extends StatelessWidget {
  @override
  String? name;
  String? getId;
  String  roleName;
  UserTopProfileWidget(this.roleName);

  Widget build(BuildContext context) {
    getName();
    var profileProvider = Provider.of<UserProfileProvider>(context);
    profileProvider.getvalueSharedPreferences();
    profileProvider.getProfileImageSharedPreferences();

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
           CustomImageProfile(
                  image:IMG_URL + profileProvider.getProfileImage.toString(),
                  width: 60,
                  boxFit: BoxFit.contain,
                  height: 66),
              profileProvider.getName == ''
                  ? SizedBox(
                      width: 50, height: 40, child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170.0,
                            child: profileProvider.getName == ''
                                ? CircularProgressIndicator()
                                : Text(
                              profileProvider.getName==""?'': capitalize(profileProvider.getName.toString()),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),

                          SizedBox(
                            height: 2,
                          ),
                          Text("${AppLocalizations.instance.text('Logged in as')} ${roleName}",style: TextStyle(fontSize: 12
                              ,fontStyle: FontStyle.italic),),
                          SizedBox(
                            height: 2,
                          ),
                          GestureDetector(
                            child: Text(
                              AppLocalizations.instance.text('profileText'),
                              style: TextStyle(
                                color: Color(0xFF044a87),
                                  fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>ChangeNotifierProvider(create: (_) => UserProfileViewProvider(),child: UserProfileView())));
                            },
                          ),
                          SizedBox(
                            height: 2,
                          ),
                        ],
                      ),
                    ),
            ],
          ),

          Container(
            padding: EdgeInsets.all(5),
            child: CircularPercentIndicator(
              radius: 30.0,
              lineWidth: 5.0,
              percent: profileProvider.precentindicate!.toDouble(),
              animation: true,
              backgroundWidth: 8,
              backgroundColor: Colors.blue.shade400,
              center: new Text(
                profileProvider.ProgressBar.toString() + "%",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
              ),
              progressColor: PrimaryColor,
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
                    offset: Offset(-5.0, -5.0),
                    blurRadius: 4,
                  ),
                ]),
          ),

          // Container(
          //   height: 50,
          //   width: 50,
          //   child: Image.asset(
          //     "assets/message_ic.png",
          //     color: Color(0xFF044a87),
          //     height: 50,
          //     width: 50,
          //   ),
          //   decoration: BoxDecoration(
          //       color: Color(0xFFEEEEEE),
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Color(0xFFD9D9D9),
          //           offset: Offset(5.0, 5.0),
          //           blurRadius: 7,
          //         ),
          //         BoxShadow(
          //           color: Colors.white.withOpacity(.5),
          //           offset: Offset(-5.0, -5.0),
          //           blurRadius: 10,
          //         ),
          //       ]),
          // ),
          // SizedBox(
          //   width: 5,
          // ),
          // Container(
          //     height: 50,
          //     width: 50,
          //     child: Image.asset(
          //       "assets/language_ic.png",
          //       color: Color(0xFF044a87),
          //       scale: 1.2,
          //     ),
          //     decoration: BoxDecoration(
          //         color: Color(0xFFEEEEEE),
          //         shape: BoxShape.circle,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Color(0xFFD9D9D9),
          //             offset: Offset(5.0, 5.0),
          //             blurRadius: 7,
          //           ),
          //           BoxShadow(
          //             color: Colors.white.withOpacity(.5),
          //             offset: Offset(-5.0, -5.0),
          //             blurRadius: 10,
          //           ),
          //         ])),
          // SizedBox(
          //   width: 5,
          // ),
        ],
      ),
    );
  }

  getName() async {
    name = await getNameInfo();
  }
}
