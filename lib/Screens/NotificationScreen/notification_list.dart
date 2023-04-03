import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../Model/NotificationModel/NotificationModel.dart';
import '../Home/Component/pagination_widget.dart';
import 'Provider/notificationProvider.dart';
import 'notification_item.dart';

class NotificationList extends StatefulWidget {
  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late NotificationProvider _notificationProvider;



  @override
  void initState() {
    // TODO: implement initState
    _notificationProvider = context.read<NotificationProvider>();
    _notificationProvider.notficationList = [];
    _notificationProvider.hitNotificationApi(context,  false);
    _notificationProvider.hitReadallNotification();

    _notificationProvider.addScrollListener( context);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text(AppLocalizations.instance.text("Notification")),
        centerTitle: true,
        actions: [],
      ),
      body: Consumer<NotificationProvider>(builder: (_, proData, __) {
        if (proData.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (proData.notficationList.length == 0)
          return Center(child: Text(AppLocalizations.instance.text("No Record Found")));
        else
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    controller: proData.scrollController,
                    itemCount: proData.notficationList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ChangeNotifierProvider<Datum>.value(
                          value: proData.notficationList[index],
                          child: NotificationItem(_notificationProvider),
                        ),
                      );
                    }),
              ),
              proData.pagenationLoder?LinearProgressIndicator():SizedBox(),

            ],
          );
      }),
    );
  }






}