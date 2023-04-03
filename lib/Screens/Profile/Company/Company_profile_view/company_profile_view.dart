import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Profile/Company/Company_profile_view/head_part.dart';
import 'package:provider/provider.dart';

import 'Provider/company_profile_view_provider.dart';


class CompanyViewDetail extends StatelessWidget {


  late CompanyViewProvider _companyViewProvider;
bool check=true;
  @override
  Widget build(BuildContext context) {
    _companyViewProvider=  Provider.of<CompanyViewProvider>(context, listen: false);
    _companyViewProvider.hitCompanyProfile(context);
    return Scaffold(
      backgroundColor: APP_BG,
      body: SingleChildScrollView(child:

        Consumer<CompanyViewProvider>(builder: (_, proData, __) {
          if (proData.loading) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 350,),
                Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            );
          }
          if (proData.companyDetail==null) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 350,),
                Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            );
          }

          else
            return HeadPart(proData);
        }
           )),
    );
  }
}
