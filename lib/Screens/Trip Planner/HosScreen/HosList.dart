import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/AddStoppageMap/Provider/route_add_marker_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/customapp.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Search_bar.dart';
import 'Component/Search_Component.dart';

class HosList extends StatefulWidget {
  TripPlannerModel data;
   int  index;
  String txt;
  HosList(
  this.data, this. index,this.txt , {
        Key? key,
      });

  @override
  State<HosList> createState() => _HosListState();
}

class _HosListState extends State<HosList> {


   late  RouteMarkerProvider providerread;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    providerread=Provider.of<RouteMarkerProvider>(context, listen: false);
    providerread.hitHos(providerread.speed.text.toString(), widget.index);
    providerread.speedController.text=widget.txt;
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: CustomAppBar(
        visual: false,
        title: AppLocalizations.instance.text("Hours Of Service"),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SearchAppBar(widget.index,
                    providerread,widget.txt
                ),
              ),

              Container(

                child:   Consumer<RouteMarkerProvider>(builder: (context, noti, child) {
                  if(noti.hosLoder)
                    return  CircularProgressIndicator();
                  else

                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        AddressSource(),
                        ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: noti.days.length,
                            itemBuilder: (BuildContext context, int index) {

                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        child: Icon(
                                          FontAwesomeIcons.arrowDown,
                                          size: 20,
                                        ),
                                        decoration: const BoxDecoration(
                                            color: Color(0xFFEEEEEE),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 5,
                                                  offset: Offset(5, 5)),
                                              BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 2,
                                                  offset: Offset(-5, -5))
                                            ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Contextt(index, noti),


                                  ],
                                ),

                              );
                            }
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 30,
                            height: 30,
                            child: Icon(
                              FontAwesomeIcons.arrowDown,
                              size: 20,
                            ),
                            decoration: const BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5,
                                      offset: Offset(5, 5)),
                                  BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 2,
                                      offset: Offset(-5, -5))
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AddressDestination(noti),

                        SizedBox(
                          height: 30,
                        ),
                      ],
                    );
                }
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  AddressSource() {
    var  startdate=widget.data.startDate;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        child: ListTile(
        leading: Icon(Icons.location_on),
          trailing: Container(
            width: 70,
            height: 30,
            child: Center(
              child: Text("Origin",
                style: TextStyle(
                    color: Colors.white,fontSize: 18),),
            ),
            decoration: BoxDecoration(
              color: Colors.blue
            ),
          ),
          title:Text(widget.data.source!.address.toString()),
          subtitle: Text(DateFormat('EEEE, d MMM, yyyy').format(startdate!)),
      ),
        decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
            ]),
      ),
    );
  }

  AddressDestination(RouteMarkerProvider noti) {
    var datee=widget.data.endDate;

    print(datee);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          leading: Icon(Icons.location_on),
          trailing: Container(
            width: 70,
            height: 30,
            child: Center(
              child: Text("Arrive",
                style: TextStyle(
                    color: Colors.white,fontSize: 18),),
            ),
            decoration: BoxDecoration(
                color: Colors.green
            ),
          ),
          title:Text(widget.data.destination![0].address.toString()),
          subtitle:
         Text(DateFormat('EEEE, d MMM, yyyy').format(datee!.add( Duration(days:noti.days.length-1, hours: 0))),
          ),
        ),
    decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
            ]),
      ),
    );
  }

  Contextt(int index, RouteMarkerProvider providertrue) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Icon(
                  Icons.alarm,
                  color: Colors.black45,
                ),
                SizedBox(
                  height: 10,
                ),
                Icon(
                  FontAwesomeIcons.truck,
                  color: Colors.black45,
                  size: 20,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("30 min (Rest Break)"),
                SizedBox(
                  height: 10,
                ),
                Text("11 hours (Complete Duty Time)"),
              ],
            ),
            Column(
              children: [
                Text(providertrue.days[index].toString()+" "+"Days"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: const BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.white, blurRadius: 2, offset: Offset(-5, -5))
          ]),
    );
  }
}
