import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';

import '../../../Language_Screen/application_localizations.dart';

class Direction extends StatelessWidget {

  @override
  var size;
  var calculateDistance;
  var  getPolyline;
  RouteMarkerProvider?provider;


  Direction(this.getPolyline, this. provider);

  Widget build(BuildContext context) {


    size = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomAppBar(
          title:AppLocalizations.instance.text('Direction') ,
          visual: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
SizedBox(height: 90,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    children: [
                      Text(
                        provider!.calculateTime[getPolyline]
                         .toString(),
                        style: TextStyle(color: PrimaryColor, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "(" +
                               provider!.calculateDistance[getPolyline]
                                  .toString() +
                              "  " +
                              "Miles" +
                              ")",
                          style: TextStyle(fontSize: 16),
                        ),
                     ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.3),
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
                child: Text(
                  "Directions",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: size.height * 00.005,
              ),
              Expanded(

                child: ListView.builder(
                    itemCount: provider!.routeModel.routes![getPolyline].guidance!.instructions!.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      methodname(
                                          // provider.
                                          // routeModel!
                                          // .routes![getPolyline]
                                          // .guidance!
                                          // .instructions![index]
                                          // .maneuver
                                          // .toString()),
                                provider!.routeModel.routes![getPolyline].guidance!.instructions![index].maneuver.toString()
                                      ),
                                      width: 35,
                                      height: 35,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                      provider!.routeModel.routes![getPolyline].guidance!.instructions![index].maneuver.toString().replaceAll("\_", "  "),


                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: size.height * 00.008,
                                          ),
                                          Text(
                                            provider!.routeModel.routes![getPolyline].guidance!.instructions![index].street.toString().replaceAll("\_", "  "),

                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            height: size.height * 00.008,
                                          ),
                                          Text(
                                            provider!.routeModel.routes![getPolyline].guidance!.instructions![index].routeOffsetInMeters.toString()
                                               + "m",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                // _mapProvider.getDirectionMarker(
                                //   _mapProvider
                                //       .routeModel!
                                //       .routes![int.parse(getPolyline)]
                                //       .guidance!
                                //       .instructions![index]
                                //       .point!
                                //       .latitude!
                                //       .toDouble(),
                                //   _mapProvider
                                //       .routeModel!
                                //       .routes![int.parse(getPolyline)]
                                //       .guidance!
                                //       .instructions![index]
                                //       .point!
                                //       .longitude!
                                //       .toDouble(),
                                //   _mapProvider
                                //       .routeModel!
                                //       .routes![int.parse(getPolyline)]
                                //       .guidance!
                                //       .instructions![index]
                                //       .maneuver
                                //       .toString(),
                                //   _mapProvider
                                //       .routeModel!
                                //       .routes![int.parse(getPolyline)]
                                //       .guidance!
                                //       .instructions![index]
                                //       .routeOffsetInMeters
                                //       .toString() +

                                Navigator.pop(context);
                                print("object");
                              },
                            ),
                            Divider(
                              color: Colors.black.withOpacity(0.3),
                              height: 1,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              Row(
                children: [
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin:
                        EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                        decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFD9D8D8),
                                offset: Offset(5.0, 5.0),
                                blurRadius: 7,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(.4),
                                offset: Offset(-5.0, -5.0),
                                blurRadius: 10,
                              ),
                            ]),
                        child: Center(
                            child: Text(
                              "Start",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )),
                      )),
                  Flexible(
                      child: Container(
                        width: double.infinity,
                        height: 45,
                        margin:
                        EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
                        decoration: BoxDecoration(
                            color: PrimaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFD9D8D8),
                                offset: Offset(5.0, 5.0),
                                blurRadius: 7,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(.4),
                                offset: Offset(-5.0, -5.0),
                                blurRadius: 10,
                              ),
                            ]),
                        child: Center(
                            child: GestureDetector(
                              child: Text(
                                "Show Map",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                      )),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ));
  }
}

methodname(String maneuver) {
  switch (maneuver) {
    case "TURN_LEFT":
      return "directionIcon/turnleft.png";
    case "TURN_RIGHT":
      return "directionIcon/turnright.png";
    case "KEEP_LEFT":
      return "directionIcon/keepleft.gif";
    case "KEEP_RIGHT":
      return "directionIcon/keepright.png";
    case "BEAR_LEFT":
      return "directionIcon/bearleft.png";
    case "BEAR_RIGHT":
      return "directionIcon/bearright.png";
    case "SHARP_LEFT":
      return "directionIcon/sharpleft.png";
    case "SWITCH_PARALLEL_ROAD":
      return "directionIcon/Switchparllelroad.png";
    case "MOTORWAY_EXIT_RIGHT":
      return "directionIcon/MotorwayexitRight.png";
    case "MOTORWAY_EXIT_LEFT":
      return "directionIcon/Motorwayexitleft.png";
    case "MOTORWAY_EXIT_LEFT":
      return "directionIcon/Motorwayexitleft.png";
    case "ROUNDABOUT_CROSS":
      return "directionIcon/Roundboutcross.png";
    case "ROUNDABOUT_RIGHT":
      return "directionIcon/Roundboutright.png";
    case "SWITCH_PARALLEL_ROAD":
      return "directionIcon/Switchparllelroad.png";
    case "TAKE_EXIT":
      return "directionIcon/takeexit.png";
    case "MAKE_UTURN":
      return "directionIcon/UTurn.png";
    case "ENTER_FREEWAY":
      return "directionIcon/Enterfreeway.png";
    case "ENTER_HIGHWAY":
      return "directionIcon/enterhighway.png";
    case "STRAIGHT":
      return "directionIcon/Follow.png";
    case "FOLLOW":
      return "directionIcon/Follow.png";
    case "ENTER_MOTORWAY":
      return "directionIcon/EnterMotorway.png";
    case "DEPART":
      return "directionIcon/leave.png";
    case "ARRIVE":
      return "directionIcon/finishedDestination.png";
    case "ARRIVE_LEFT":
      return "directionIcon/finishedDestination.png";
    case "ARRIVE_RIGHT":
      return "directionIcon/finishedDestination.png";
    case "TAKE_FERRY":
      return "directionIcon/Takeferry.png";
    case "TAKE_FERRY":
      return "directionIcon/Takeferry.png";
    case "TRY_MAKE_UTURN":
      return "TrymakeUTurn.png";
    default:
      return "directionIcon/question-mark.png";
  }
}