import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/EventModel.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventListProvider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/InsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/OutsideButton.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Timebox.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  @override
  String? getid;
  late UserEventListProvider _eventListProvider;

  Widget build(BuildContext context) {
    var data = context.watch<EventModel>();

    data.getTime();
    getId();


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
                    data.eventTime.toString() == "On-going"
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                            child: data.isInterested == true
                                ? InsiderButton(
                              Icon: Icon(
                                Icons.star,
                                color: Colors.yellowAccent.shade700,
                                size: 25,
                              ),
                            )
                                : OutsideButton(
                                Icon: Icon(
                                  Icons.star_border,
                                  color: Colors.yellowAccent.shade700,
                                  size: 25,
                                )),
                            onTap: () {
                              if (data.isInterested == true) {
                                data.removeInterested(
                                    data.id.toString(),
                                    false,
                                    getid.toString(),
                                    context);
                              } else {
                                data.addInterested(data.id.toString(),
                                    true, getid.toString(), context);
                              }

                              print(data.isInterested);
                            }),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              boxShadow:  data.isBooked == true?[
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 5,
                                    offset: Offset(0, 5)),
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 3,
                                    offset: Offset(-3, -3))
                              ]:[

                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                    offset: Offset(4, 4)),
                                BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    offset: Offset(-3, -3))

                              ]),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              GestureDetector(
                                  child: data.isBooked == true
                                      ? Center(
                                        child: Text(
                                            'BOOKED',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: PrimaryColor,
                                                fontWeight: FontWeight.w800),
                                          ),
                                      )
                                      : Center(
                                        child: Text(
                                            'BOOK NOW',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800),
                                          ),
                                      ),
                                  onTap: () {
                                    data.addBookEvent(
                                         data.id,getid, context);

                                    // _eventListProvider.hitAddBookEventList(context,data.id,getid);
                                  }),

                            ],
                          ),
                        ),
                        GestureDetector(
                            child: data.isfavourite == true
                                ? InsiderButton(
                              Icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 25,
                              ),
                            )
                                : OutsideButton(
                              Icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 25,
                              ),
                            ),
                            onTap: () {
                              print(data.isfavourite);
                              if (data.isfavourite == true) {
                                data.removeFavourite(data.id.toString(),
                                    false, getid.toString(), context);
                              } else {
                                data.addFavourite(data.id.toString(),
                                    true, getid.toString(), context);
                              }
                            }),

                        // Expanded(
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Container(
                        //       height: 45,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10),
                        //           color: Color(0xFFEEEEEE),
                        //           boxShadow: [
                        //             BoxShadow(
                        //               color: Color(0xFFD9D8D8),
                        //               offset: Offset(5.0, 5.0),
                        //               blurRadius: 2,
                        //             ),
                        //             BoxShadow(
                        //               color: Colors.white.withOpacity(.4),
                        //               offset: Offset(-5.0, -5.0),
                        //               blurRadius: 10,
                        //             ),
                        //           ]),
                        //       child: Image.asset(
                        //         'assets/gray_share_ic.png',
                        //         scale: 3,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
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
      child:  CustomImage(image:  SERVER_URL + '/uploads/event/image/' + bannerImage , width: double.infinity, boxFit:BoxFit.cover, height: hei)
    );
  }

  Future<void> getId() async {
    getid = await getUserId();
  }
}
