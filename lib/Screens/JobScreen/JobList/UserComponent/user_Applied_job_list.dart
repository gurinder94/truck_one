

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/ViewJob.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Menubar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import 'Component/Applied_job_item.dart';
import 'Provider/UserJobProvider.dart';

class AppliedJobList extends StatefulWidget {



  @override
  State<AppliedJobList> createState() => _AppliedJobListState();
}

class _AppliedJobListState extends State<AppliedJobList> {
  late UserJobProvider _jobListProvider;
  initState() {
    _jobListProvider = Provider.of<UserJobProvider>(context, listen: false);

    _jobListProvider.jobAppliedList=[];
    _jobListProvider.hitAppliedJobList(context, );
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        title:    AppLocalizations.instance.text('Applied Job'),
        visual: false,
        showModalWidget: Menubar(),
        backvisual: true,

        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),
            Expanded(
              child: Consumer<UserJobProvider>(builder: (_, proData, __) {
                if (proData.jobListLoad) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (proData.jobListModel == null ||
                    proData.jobAppliedList.length == 0)
                  return Center(child: Text(AppLocalizations.instance.text("No Record Found")));
                else
                  return ListView.builder(
                    itemCount: proData.jobAppliedList.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) =>
                    ChangeNotifierProvider<JobModel>.value(
                        value: proData.jobAppliedList[index],
                        child: GestureDetector(
                          child:  AppliedJobItem(index,proData),
                          onTap: () async {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>   ChangeNotifierProvider(create: (_) => JobViewProvider(),child: ViewJob(proData.jobAppliedList[index].id.toString(),true))));

                          },
                        )),
                  );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
