import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../commanWidget/Custom_App_Bar_Widget.dart';
import '../commanWidget/custom_image_network_profile.dart';
import 'Provider/Activity_log_provider.dart';

class Activity extends StatelessWidget {
  late ActivityLogProvider _activityLogProvider;
  String? endTime;
  late DateTime date;
  ScrollController scrollController = new ScrollController();
  int pagee = 1;

  @override
  Widget build(BuildContext context) {
    pagee = 1;
    _activityLogProvider = context.read<ActivityLogProvider>();
    _activityLogProvider.hitActivityLog(context, pagee);
    _activityLogProvider.restList();

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text('Activity'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Expanded(
                child: Consumer<ActivityLogProvider>(builder: (_, proData, __) {
              if (proData.loading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.listDate.length == 0)
                return Center(
                    child: Text(
                        AppLocalizations.instance.text('No Record Found')));
              else
                return ListView.builder(
                    itemCount: proData.listDate.length,
                    padding: EdgeInsets.zero,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: proData.listDate[index].list!.length,
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          itemBuilder: (BuildContext context, int ind) {
                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                child: ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      child: CustomImageProfile(
                                          image: proData.profileImg == null
                                              ? ''
                                              : IMG_URL + proData.profileImg,
                                          width: 50,
                                          boxFit: BoxFit.contain,
                                          height: 50),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        showDate(context, 'Name', proData.name),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        showDate(
                                            context,
                                            'Login',
                                            getCovert(proData.listDate[index]
                                                .list![ind].loginDate
                                                .toString())),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        showDate(
                                            context,
                                            'Logout',
                                            proData.listDate[index].list![ind]
                                                        .logoutDate ==
                                                    null
                                                ? '_'
                                                : getCovert(proData
                                                    .listDate[index]
                                                    .list![ind]
                                                    .logoutDate
                                                    .toString())),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        showDate(
                                            context,
                                            'IP Address',
                                            proData.listDate[index].list![ind]
                                                .clientIp),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        showDate(
                                            context,
                                            'Device',
                                            proData.listDate[index].list![ind]
                                                .source),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        onlyDate(
                                            context, 'Date', proData, index),
                                        SizedBox(
                                          height: 6,
                                        ),
                                      ],
                                    )),
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFFD9D8D8),
                                        offset: Offset(5.0, 5.0),
                                        blurRadius: 7,
                                      ),
                                      BoxShadow(
                                        color: Colors.white.withOpacity(.5),
                                        offset: Offset(-5.0, -5.0),
                                        blurRadius: 7,
                                      ),
                                    ]),
                              ),
                            );
                          });
                    });
            })),
          ],
        ));
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pagee = pagee + 1;
        if (_activityLogProvider.activityLog.data!.length == 0) {
        } else {
          _activityLogProvider.hitActivityLog(context, pagee);
        }
      }
    });
  }
}

getCovert(String value) {
  DateTime dt = DateTime.parse(value);

  String formattedDate = DateFormat('yyyy-MM-dd hh:mm:a').format(dt.toLocal());

  return formattedDate;
}

getFormatter(var value) {
  DateTime dt = DateFormat('MM-dd-yyyy').parse(value);

  String formattedDate = DateFormat('MMM-dd-yyyy').format(dt.toLocal());

  return formattedDate;
}

showDate(BuildContext context, String? heading, String? value) {
  return RichText(
    text: TextSpan(
      text: AppLocalizations.instance.text(heading!) + '  ',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: value,
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
      ],
    ),
  );
}

onlyDate(
  BuildContext context,
  String? heading,
  ActivityLogProvider proData,
  int index,
) {
  return RichText(
    text: TextSpan(
      text: heading! + '  ',
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text: getFormatter(proData.activityLog.data![index].id.toString()),
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
      ],
    ),
  );
}

showMessageLogin(BuildContext contex, ActivityLogProvider proData, int index) {
  return RichText(
    text: TextSpan(
      text: "${proData.name} ",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      children: <TextSpan>[
        TextSpan(
            text:
                "was Logged  in on ${proData.activityLog.data![index].list![0].source}  at  ${getCovert(proData.activityLog.data![index].list![0].loginDate.toString())} and Logged out at   ${proData.activityLog.data![index].list![0].logoutDate == null ? 'N/A' : getCovert(proData.activityLog.data![index].list![0].logoutDate.toString())} ",
            style:
                TextStyle(fontWeight: FontWeight.normal, color: Colors.black)),
      ],
    ),
  );
}
