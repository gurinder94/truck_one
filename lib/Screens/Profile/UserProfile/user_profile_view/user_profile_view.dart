import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/UserProfile/user_profile_view/provider/user_profile_provider.dart';
import 'package:provider/provider.dart';

import 'User_head_Part.dart';

class UserProfileView extends StatelessWidget {
  late UserProfileViewProvider _userProfileProvider;

  @override
  Widget build(BuildContext context) {
    _userProfileProvider =
        Provider.of<UserProfileViewProvider>(context, listen: false);

    _userProfileProvider.hitUserProfileDetails(context);
    _userProfileProvider.hitCompanyList();
    _userProfileProvider.getroleName();

    return Scaffold(
        backgroundColor: APP_BG,
        body: SingleChildScrollView(
          child: Consumer<UserProfileViewProvider>(builder: (_, proData, __) {
            if (proData.loading) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350,
                  ),
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ],
              );
            } else if (proData.userModel == null)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 350,
                  ),
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ],
              );
            else
              return UserHeadPart(proData);
          }),
        ));
  }
}
