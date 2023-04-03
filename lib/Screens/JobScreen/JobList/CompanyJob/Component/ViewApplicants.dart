import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/JobList/CompanyJob/Provider/JobListProvider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';

import 'ApplicantsItem.dart';

class ViewApplicants extends StatelessWidget {
  late JobListProvider _jobListProvider;
  String? jobId;

  ViewApplicants(this.jobId);

  @override
  Widget build(BuildContext context) {
    _jobListProvider = Provider.of<JobListProvider>(context, listen: false);
    getApplicants(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: CustomAppBar(
            visual: false,
            title:AppLocalizations.instance.text("View Applicants"),
            child: Column(
              children: [

                SizedBox(height: 100,),
                ApplicantsItem()
              ],
            )));
  }

  Future<void> getApplicants(BuildContext context) async {
    var getId = await getUserId();
    _jobListProvider.hitViewApplicants(context, getId, jobId);
  }
}
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Text(user.personName.toString()),
// Text(user.mobileNumber.toString()),
// Flexible(child: Text(user.email.toString())),
// Flexible(child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: resmue==""?Icon(Icons.close):Icon(Icons.upload_file)
// ))
//
// ],
// ),
