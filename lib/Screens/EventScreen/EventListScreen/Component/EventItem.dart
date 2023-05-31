import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventModel 2.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Timebox.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  @override
  String? getid;
  String taber;
   EventItem(this.taber);

  Widget build(BuildContext context) {
    var data = context.watch<EventModel>();
    data.getTime();
    getBookings();

    return Container(
        width: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xFFEEEEEE),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFFA7A7A7), blurRadius: 5, offset: Offset(0, 1))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 600) {
                  return eventImage(300, data.bannerImage.toString());
                } else {
                  return eventImage(200, data.bannerImage.toString());
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            // text: DateFormat('EEEE, MMM d  yyyy,')
                            //     .format(data.startDate!),

                          text: data.changeDateTimeZone( data.startDate.toString()),
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                          TextSpan(
                              text: "  " +
                                  "at"
                                      ""),
                          TextSpan(
                            text: " " +
                                " " +
                                data.changeTimeZone( data.startDate.toString())
                          ),
                        ])),
                    SizedBox(
                      height: 5,
                    ),
                    Text(showCapitalize(data.name.toString(),),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    SizedBox(
                      height: 5,
                    ),
                    Text(data.noOfAttendee.toString() + ' Interested ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                    taber=="Booked"?Text("Booked by  ${data.noOfAttendee.toString()}"):   data.eventTime.toString() == "On-going"
                        ? Center(
                            child: Text(data.eventTime.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700)),
                          )
                        : data.eventTime.toString() == "EXPIRED"
                            ? Center(
                                child: Text(data.eventTime.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text("Days"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TimeBox(
                                        child: Center(
                                            child: Text(
                                          data.days.toString(),
                                          style: TextStyle(fontSize: 18),
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text("Hours"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TimeBox(
                                        child: Center(
                                            child: Text(
                                          data.hour.toString(),
                                          style: TextStyle(fontSize: 18),
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text("min"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TimeBox(
                                        child: Center(
                                            child: Text(
                                          data.min.toString(),
                                          style: TextStyle(fontSize: 18),
                                        )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text("Seconds"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TimeBox(
                                        child: Center(
                                            child: Text(
                                          data.seconds.toString(),
                                          style: TextStyle(fontSize: 18),
                                        )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                    SizedBox(
                      height: 10,
                    ),


                    SizedBox(
                      height: 10,
                    ),
                  ]),
            )
          ],
        ));
  }

  eventImage(double hei, String bannerImage) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: CustomImage(image: bannerImage==null?'': SERVER_URL + '/uploads/event/image/' + bannerImage , width: double.infinity, boxFit:BoxFit.fill, height: hei)


    );
  }

  Future<void> getBookings() async {
    getid = await getUserId();
  }
}
