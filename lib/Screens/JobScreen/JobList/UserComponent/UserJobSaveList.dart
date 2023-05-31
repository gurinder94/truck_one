import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/ViewJob.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Menubar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';

import '../../../Language_Screen/application_localizations.dart';
import 'Component/save_job_item.dart';
import 'Provider/UserJobProvider.dart';

class SaveJobList extends StatefulWidget {
  const SaveJobList({Key? key}) : super(key: key);

  @override
  _SaveJobListState createState() => _SaveJobListState();
}

class _SaveJobListState extends State<SaveJobList> {
  String? getId;

  late UserJobProvider _jobListProvider;

  initState() {
    _jobListProvider = Provider.of<UserJobProvider>(context, listen: false);

    _jobListProvider.SaveJoblist = [];
    _jobListProvider.hitSaveJobList(
      context,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        title: AppLocalizations.instance.text('Favorite Job'),
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
                    proData.SaveJoblist.length == 0)
                  return Center(
                      child: Text(
                          AppLocalizations.instance.text('No Record Found')));
                else
                  return ListView.builder(
                    itemCount: proData.SaveJoblist.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) =>
                        ChangeNotifierProvider<JobModel>.value(
                            value: proData.SaveJoblist[index],
                            child: GestureDetector(
                              child: JobSaveItem(index, proData),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    JobViewProvider(),
                                                child: ViewJob(
                                                    proData
                                                        .SaveJoblist[index].id
                                                        .toString(),
                                                    false))));
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
