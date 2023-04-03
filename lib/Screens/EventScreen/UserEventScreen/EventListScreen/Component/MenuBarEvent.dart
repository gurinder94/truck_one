import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/BookedEventListScreen/booked_event_list_provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/FavouriteListScreen/favourite_list_provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/InterestedEventListScreen/Interested_list_provider.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventListProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../../../../Language_Screen/application_localizations.dart';
import '../../../BookedEventListScreen/BookedList.dart';
import '../../../FavouriteListScreen/FavouriteList.dart';
import '../../../InterestedEventListScreen/InterestedList.dart';

class MenuBarEvent extends StatelessWidget {
  late UserEventListProvider eventListProvider;

  MenuBarEvent(this.eventListProvider);



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: 100,
              height: 4,
              color: Color(0xFF1A62A9),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(AppLocalizations.instance.text("My Events"),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
              Text(AppLocalizations.instance.text("Favorite")),
                ],
              ),
              onTap: () {
                Navigator.pop(context);
                getEventFavouriteList(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellowAccent.shade700,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(AppLocalizations.instance.text("Interested")),

                ],
              ),
              onTap: () {

                getEventInterested(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            GestureDetector(
              child: Row(
                children: [
                  Image.asset(
                    "icons/bookevent.png",
                    width: 30,
                    height: 30,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(AppLocalizations.instance.text("Booked")),
                ],
              ),
              onTap: ()
              {
                getEventBooked(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  getEventFavouriteList(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => FavouriteListProvider(),
                child: FavouriteList()))).then((_) {

      eventListProvider.Event = [];
      eventListProvider.hitGetEventsList(context, "TOP", 1, false, "",0);
    });
  }

  getEventInterested(BuildContext context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => InterestedListProvider(),
                child: InterestedList()))).then((_) {
      // This block runs when you have come back to the 1st Page from 2nd.

      eventListProvider.Event = [];
      eventListProvider.hitGetEventsList(context, "TOP", 1, false, "",0);
    });
  }

  getEventBooked(BuildContext context) async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => BookedEventListProvider(), child: BookedList()),
        ));
  }
}
