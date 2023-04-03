import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:provider/provider.dart';

import 'Compoment/UserHeaderPart.dart';
import 'Provider/UserProfileProvider.dart';

class ProfileUser extends StatelessWidget {
  String? userId;
  UserProfileProvider? _profileProvider;
  bool profileComplete;

  ProfileUser(this.profileComplete);

  @override
  Widget build(BuildContext context) {
    _profileProvider = Provider.of<UserProfileProvider>(context, listen: false);
    getId();
    _profileProvider!.documentArray=[];
    _profileProvider!.checkRoleName();
    Future.delayed(Duration(microseconds: 50),
        () => _profileProvider!.hitUserProfileDetails(userId, context));

    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Selector<UserProfileProvider, bool>(
            selector: (_, provider) => provider.loading,
            builder: (context, loder, child) {
              return loder == true
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                    child: Column(
                        children: [
                          UserHeadPart(profileComplete),
                          // Expanded(child: UserForm()),
                        ],
                      ),
                  );
            }));
  }

  getId() async {
    userId = await getUserId();
  }
}
