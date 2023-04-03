import 'package:flutter/material.dart';

import 'Attendee_List.dart';

class EventViewAttendee extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "1 Connection",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://googleflutter.com/sample_image.jpg'),
                ),
              ),
            ),
            title: Row(
              children: [
                Text("Amit Kumar"),
                SizedBox(
                  width: 10,
                ),

                // FlatButton(
                //   // splashColor: Colors.red,
                //   color: Colors.grey.withOpacity(0.3),
                //   // textColor: Colors.white,
                //   child: Text("Host"),
                //   onPressed: () {
                //
                //   },
                // ),
              ],
            ),
            subtitle:
            Text("UL/UX Designer at Zimo Infotech"),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "1 Attendee",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                        )),
                  ),  SizedBox(
                    height: 10,
                  ),

                  AttendeeList(),
                ],
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),

    );
  }
}
