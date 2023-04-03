import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Compoment/header_part.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/provider/ProfileProvider.dart';
import 'package:provider/provider.dart';


class CompanyProfile extends StatelessWidget {
  ProfileProvider? _profileProvider;
  ProfileProvider? _profile;
  String? getId;
  bool  ?profileComplete;

  CompanyProfile(this.profileComplete);

  @override
  Widget build(BuildContext context) {
    getIdUser();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
_profileProvider!.imageLogo=null;
_profileProvider!.imagebackground=null;
    Future.delayed(Duration(microseconds: 100),
        () => _profileProvider!.hitCompanyProfile(getId, context));

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body:
      Selector<ProfileProvider, bool>(
          selector: (_, provider) => provider.loading,
          builder: (context, loder, child) {
            return loder == true
                ? Center(child: CircularProgressIndicator())
                :   SingleChildScrollView(
                  child: Column(
              children: [
                  HeaderPart(profileComplete!),

              ],
            ),
                );
          }));

  }

  getIdUser() async {
    getId = await getUserId();
  }
}
