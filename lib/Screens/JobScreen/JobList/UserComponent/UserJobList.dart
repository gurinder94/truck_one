import 'dart:io';
import 'package:my_truck_dot_one/Model/JobModel/JobModel 2.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/ViewJob.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Menubar.dart';
import 'package:provider/provider.dart';
import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../../commanWidget/SizeConfig.dart';
import '../../../commanWidget/comman_bottom_sheet.dart';
import '../../../commanWidget/comman_cirle_widget.dart';
import 'Provider/UserJobProvider.dart';
import 'Component/UserJobItem.dart';
import 'job_fliter.dart';

class UserJobList extends StatefulWidget {
  const UserJobList({Key? key}) : super(key: key);

  @override
  _UserJobListState createState() => _UserJobListState();
}

class _UserJobListState extends State<UserJobList> {
  String? getId;
  late UserJobProvider _jobListProvider;

  ScrollController _scrollController = new ScrollController();
  int pagee = 1;

  initState() {
    _jobListProvider = Provider.of<UserJobProvider>(context, listen: false);
    _jobListProvider.resetList();
    _jobListProvider.hitgetQualification();
    _jobListProvider.hitgetIndustry();
    getJobList(context);

    addScrollListener(context);
  }

  List search = ['Search', 'Education', 'Industry', 'Location'];

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomAppBarWidget(
      title: AppLocalizations.instance.text('Jobs'),
      leading: SizedBox(),
      floatingActionWidget: SizedBox(),
      actions: Row(
        children: [
          CommanCirleWidget(
            icons: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            onDone: () {
              show();
            },
          ),
          SizedBox(
            width: 20,
          ),
          CommanCirleWidget(
            icons: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onDone: () {
              CommanBottomSheet.ShowBottomSheet(context, child: Menubar());
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
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
            child: Consumer<UserJobProvider>(builder: (_, proData, __) {
              if (proData.jobListLoad) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.jobList.length == 0)
                return Center(
                    child: Text(
                        AppLocalizations.instance.text("No Record Found")));
              else
                return ListView.builder(
                  itemCount: proData.jobList.length,
                  padding: EdgeInsets.zero,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) =>
                      ChangeNotifierProvider<JobModel>.value(
                          value: proData.jobList[index],
                          child: GestureDetector(
                            child: UserJobItem(index, proData),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>   ChangeNotifierProvider(create: (_) => JobViewProvider(),
                                        child: ViewJob(
                                            proData.jobList[index].id.toString(),
                                            false),
                                      )));
                            },
                          )),
                );
            }),
          ),
          Selector<UserJobProvider, bool>(
              selector: (_, provider) => provider.paginationLoading,
              builder: (context, paginationLoading, child) {
                return PaginationWidget(paginationLoading);
              }),
        ],
      ),
    );
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();
    _jobListProvider.hitUserGetJobList(context, '', true, pagee);
  }

  addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        pagee = pagee + 1;

        if (_jobListProvider.jobListModel!.data!.length == 0) {
        } else {
          pagnationList(context, pagee);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }

  getJobList(
    BuildContext context,
  ) async {
    _jobListProvider.hitUserGetJobList(context, '', false, pagee);
  }

  // show() {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => Container(
  //         width: double.infinity,
  //     height: MediaQuery.of(context).size.height < 700
  //         ? MediaQuery.of(context).size.height* 0.90
  //         : MediaQuery.of(context).size.height * 0.75,
  //
  //         decoration: new BoxDecoration(
  //           color: APP_BG,
  //           borderRadius: new BorderRadius.only(
  //             topLeft: const Radius.circular(25.0),
  //             topRight: const Radius.circular(25.0),
  //           ),
  //         ),
  //         child: Column(
  //           children: [
  //             SizedBox(
  //               height: 20,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Center(
  //                 child: Text(
  //                   "Filter Jobs",
  //                   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
  //                 ),
  //               ),
  //             ),
  //             Divider(),
  //             SizedBox(
  //               height: 2,
  //             ),
  //             Row(
  //               children: [
  //                 Container(
  //                   width: 110,
  //                   height: 500,
  //                   child: ListView.builder(
  //                       itemCount: search.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return GestureDetector(
  //                           child: ListTile(
  //                             leading: Text(search[index]),
  //                           ),
  //                           onTap: () {
  //                             _jobListProvider.setMenuClick(index);
  //                           },
  //                         );
  //                       }),
  //                 ),
  //                 Flexible(
  //                   child: Container(
  //                     height: 500,
  //                     child: Column(children: [
  //                       Container(
  //                         width: MediaQuery.of(context).size.width * 0.9,
  //                         height: 380,
  //                         child: menuWidget(context),
  //                         decoration: BoxDecoration(
  //                             border: Border(
  //                           left: BorderSide(
  //                             //                   <--- left side
  //                             color: Colors.black38.withOpacity(0.1),
  //                           ),
  //                         )),
  //                       ),
  //                       Divider(),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           Expanded(
  //                             child: CommanButtonWidget(
  //                               title: "Clear",
  //                               buttonColor: PrimaryColor,
  //                               titleColor: APP_BG,
  //                               onDoneFuction: () {
  //                                 _jobListProvider.resetvalue();
  //                               },
  //                               loder: false,
  //                             ),
  //                           ),
  //                           Expanded(
  //                             child: CommanButtonWidget(
  //                               title: "Apply",
  //                               buttonColor:PrimaryColor ,
  //                               titleColor: APP_BG,
  //                               onDoneFuction: () {
  //                                 _jobListProvider.jobList = [];
  //                                 _jobListProvider.hitUserGetJobList(
  //                                     context,
  //                                     _jobListProvider
  //                                         .searchEditingController.text,
  //                                     false,
  //                                     1);
  //
  //                                 Navigator.pop(context);
  //                               },
  //                               loder: false,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ]),
  //                   ),
  //                 )
  //               ],
  //             )
  //           ],
  //         )),
  //   );
  // }
  //
  //
  // menuWidget(
  //   BuildContext context,
  // ) {
  //   print(Provider.of<UserJobProvider>(context, listen: true).menuClick);
  //   switch (Provider.of<UserJobProvider>(context, listen: true).menuClick) {
  //     case 0:
  //       return SearchFliter(_jobListProvider);
  //
  //     case 1:
  //       return EducationFliter(_jobListProvider);
  //
  //     case 2:
  //       return IndutryListFliter(_jobListProvider);
  //     case 3:
  //       return LocationFliter(_jobListProvider);
  //   }
  // }
  show() {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              child: JobFliter(
                _jobListProvider,
              ));
        });
  }
}
