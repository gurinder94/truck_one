import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/BookedEventListScreen/booked_event_list_provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/ViewEvent.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:provider/provider.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'BookedItem_Component.dart';

class BookedList extends StatelessWidget {


  @override
  late BookedEventListProvider _bookedEventListProvider;

  Widget build(BuildContext context) {
    _bookedEventListProvider = context.read<BookedEventListProvider>();
    SizeConfig().init(context);




    return CustomAppBarWidget(
      title:AppLocalizations.instance.text("Booked"),
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
          Consumer<BookedEventListProvider>(builder: (_, proData, __) {

            if (proData.eventListLoad) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (proData.eventListModel == null || proData.bookedEvent == 0)
              return Center(child:Text(AppLocalizations.instance.text("No Record Found")));
            else {
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: proData.bookedEvent.length,
                          padding: EdgeInsets.zero,
                          controller: proData.scrollController,
                          itemBuilder: (BuildContext context, int index) {
                            return ChangeNotifierProvider<EventModel>.value(
                                value: proData.bookedEvent[index],
                                child: GestureDetector(
                                  child: BookedItem(),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>   ChangeNotifierProvider(create: (_) => UserEventViewProvider(),
                                              child: UserViewEvent(
                                                  proData.bookedEvent[index].eventId
                                                      .toString()),
                                            )));
                                  },
                                ));
                          }),
                    ),
                    PaginationWidget(proData.paginationLoading),

                  ],
                ),
              );
            }
          }),

        ],
      ),
    );
  }
}
