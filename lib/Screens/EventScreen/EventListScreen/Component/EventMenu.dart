import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/Provider/EventListProvider.dart';
import 'package:provider/provider.dart';

class EventMenu extends StatelessWidget {
  late EventListProvider _eventListProvider;
  String? getId;

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    _eventListProvider = context.watch<EventListProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: Column(
          children: <Widget>[
            Text(
              "My Events",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height * 0.02,
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
                  Text("Favorite"),
                ],
              ),
              onTap: () {
                getEventList(context);
                Navigator.pop(context);
              },
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: Colors.black,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text("Interested"),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Image.asset(
                  "icons/bookevent.png",
                  width: 30,
                  height: 30,
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                Text("BookEvent"),
              ],
            ),
          ],
        ),
      ),
    );
  }
  getEventList(BuildContext context) async {
    getId = await getUserId();

    _eventListProvider.hitEventsFavoutite(context, "FAVOURITE", getId, 1);
  }

}
