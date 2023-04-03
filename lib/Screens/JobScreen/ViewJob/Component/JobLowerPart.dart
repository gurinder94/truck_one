import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ApplyForm/ApplyAlertForm.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Component/JobTabBar.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Button.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';
import '../../../Language_Screen/application_localizations.dart';
import 'AboutCompany.dart';
import 'JobMenu.dart';
import 'Requirement.dart';

class JobLowerPart extends StatelessWidget {
  @override
   JobViewProvider jobViewProvider;
  var roleName;
  var userId;
  bool isAppiled;
  JobLowerPart(this.jobViewProvider,this.isAppiled );

  Widget build(BuildContext context) {
    getId();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: CommonRichText(
            richText1: AppLocalizations.instance.text('Job Title')+' : ',
            style1: TextStyle(
                fontWeight: FontWeight.w800,
                height: 1.4,
                color: Colors.black,
                fontSize:   Theme.of(context).textTheme.bodyText1!.fontSize),
            richText2: jobViewProvider.jobModel.data![0].title,
            style2: TextStyle(  fontSize:   Theme.of(context).textTheme.bodyText1!.fontSize,fontWeight: FontWeight.normal),
          ),
        ),

        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            JobTabBar(
              pos: 0,
              title: 'Company Details',
            ),
            // JobTabBar(
            //   pos: 1,
            //   title: 'Job Details',
            // ),
            JobTabBar(
              pos: 2,
              title: 'Job Details',
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: menuWidget(context),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        jobViewProvider.roleName == "COMPANY"
            ? Container()
            :isAppiled==true?SizedBox():

        jobViewProvider.jobModel.data![0].alreadyApplied==true?Button(
            Textcolor: Colors.white,
            colorcode: PrimaryColor,
            text: AppLocalizations.instance.text('Applied'),
            ): Container(
                child: GestureDetector(
                  child: Button(
                    Textcolor: Colors.white,
                    colorcode: PrimaryColor,
                    text: AppLocalizations.instance.text('Apply'),
                  ),
                  onTap: () {

                    showApplyJobDialog(context,
                        jobViewProvider.jobModel.data![0].id, userId,roleName,jobViewProvider.jobModel.data![0].companyId.toString(),
                    jobViewProvider.jobModel.data![0].title.toString());
                  },
                ),
              ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  menuWidget(BuildContext context) {
    switch (Provider.of<JobViewProvider>(context, listen: true).signUp) {
      case 0:
        return AboutCompany(jobViewProvider);
      // case 1:
      //   return JobDetails();
      case 2:
        return Requirements(jobViewProvider);
    }
  }

  showmanageButtonPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            child: SingleChildScrollView(
              child: Container(
                  child: JobMenu(context),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  )),
            ),
          );
        });
  }

  getId() async {
    userId = await getUserId();
  }
}
