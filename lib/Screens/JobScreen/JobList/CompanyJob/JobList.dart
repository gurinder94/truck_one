import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/ViewJob.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../../commanWidget/SizeConfig.dart';
import '../../../commanWidget/comman_bottom_sheet.dart';
import 'Component/JobItem.dart';
import 'Component/fliter_job.dart';
import 'Provider/JobListProvider.dart';

class JobList extends StatelessWidget {
  @override
  var Size;
  String? getId;
  late JobListProvider _jobListProvider;

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _jobListProvider = Provider.of<JobListProvider>(context, listen: false);
    _jobListProvider.activeType = 'Active';
    _jobListProvider.valueSelected = 'UnArchived';
    Size = MediaQuery.of(context).size;

    getJobList(context, _jobListProvider.activeType.toString(),
        _jobListProvider.valueSelected.toString());

    return  CustomAppBarWidget(
        title: AppLocalizations.instance.text('Jobs'),
        leading: SizedBox(),
        // floatingActionWidget: FloatingActionButton(
        //   // isExtended: true,
        //   child: Icon(Icons.add),
        //   backgroundColor: PrimaryColor,
        //   onPressed: () {
        //     DialogUtils.showMyDialog(
        //       context,
        //       onDoneFunction: () async {
        //         _launchURL();
        //         Navigator.pop(context);
        //       },
        //       oncancelFunction: () => Navigator.pop(context),
        //       title: 'Add Job',
        //       alertTitle: "Add Job Message",
        //       btnText: "Done",
        //     );
        //   },
        // ),
      floatingActionWidget:SizedBox(),
        actions: GestureDetector(
          child: Container(
            width: 45,
            height: 45,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: 30, bottom: 10, top: 5),
            child: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 1,
                    spreadRadius: 2,
                    offset: Offset(-5, -5)),
                BoxShadow(
                    color: APP_BAR_BG,
                    blurRadius: 1,
                    spreadRadius: 2,
                    offset: Offset(5, 5)),
              ],
              shape: BoxShape.circle,
            ),
          ),
          onTap: () {
            CommanBottomSheet.ShowBottomSheet(context,
                child: FliterJob(_jobListProvider));
          },
        ),
        child: Column(
          children: [
            SizeConfig.screenHeight! < 1010?
            SizedBox(
              height: Platform.isIOS? SizeConfig.safeBlockVertical! *15:SizeConfig.safeBlockVertical! * 10, //10 for example
            ):  SizedBox(
              height: Platform.isIOS? SizeConfig.safeBlockVertical! *9:SizeConfig.safeBlockVertical! * 9, //10 for example
            ),
            Expanded(
              child: Consumer<JobListProvider>(builder: (_, proData, __) {
                if (proData.jobListLoad) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (proData.jobListModel == null ||
                    proData.jobListModel!.data!.length == 0)
                  return Center(child: Text(AppLocalizations.instance.text('No Record Found'),));
                else
                  return ListView.builder(
                    itemCount: proData.jobListModel!.data!.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) =>
                        ChangeNotifierProvider<JobModel>.value(
                            value: proData.jobListModel!.data![index],
                            child: GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: JobItem(),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>   ChangeNotifierProvider(create: (_) => JobViewProvider(),
                                          child: ViewJob(
                                              proData
                                                  .jobListModel!.data![index].id
                                                  .toString(),
                                              true),
                                        )));
                              },
                            )),
                  );
              }),
            ),
          ],
        ),
      );

  }

  _launchURL() async {
    String url = Base_url_Add_Product;
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  getJobList(BuildContext context, String filter1, String filter2) async {
    getId = await getUserId();
    var roleName = await getRoleInfo();

    _jobListProvider.hitGetJobList(context, getId, roleName);
  }
}
