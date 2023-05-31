import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/InterestedEventListScreen/Interested_list_provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/ViewEvent.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import 'InterestedItem_Component.dart';


class InterestedList extends StatelessWidget {
  @override
  late InterestedListProvider _eventListProvider;


  Widget build(BuildContext context) {
    _eventListProvider = context.read<InterestedListProvider>();
    SizeConfig().init(context);

    return CustomAppBarWidget(
      title: AppLocalizations.instance.text("Interested"),
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
          SizeConfig.screenHeight! < 1010
              ? SizedBox(
            height: Platform.isIOS
                ? SizeConfig.safeBlockVertical! * 15
                : SizeConfig.safeBlockVertical! * 12, //10 for example
          )
              : SizedBox(
            height: Platform.isIOS
                ? SizeConfig.safeBlockVertical! * 9
                : SizeConfig.safeBlockVertical! * 9, //10 for example
          ),
          Consumer<InterestedListProvider>(builder: (_, proData, __) {
            if (proData.eventListLoad) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (proData.eventListModel == null ||
                proData.interestedEvent.length == 0)
              return Center(
                  child: Text(
                      AppLocalizations.instance.text("No Record Found")));
            else
              return Expanded(
                child: Column(
                    children: [
                Expanded(
                child: ListView.builder(
                itemCount: proData.interestedEvent.length,
                    padding: EdgeInsets.zero,
                    controller: proData.scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider<EventModel>.value(
                          value: proData.interestedEvent[index],
                          child: GestureDetector(
                            child: InteredtedItem(index, proData),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangeNotifierProvider(
                                              create: (_) =>
                                                  UserEventViewProvider(),
                                              child: UserViewEvent(proData
                                                  .interestedEvent[index].id
                                                  .toString()))));
                            },
                          ));
                    }),
              ),
            PaginationWidget(proData.paginationLoading)
            ],
            ),
            );
          }),
        ],
      ),
    );
  }
}
