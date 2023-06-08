import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/Component/choose_destination_dart.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/add_Trip_Provider.dart';
import 'package:my_truck_dot_one/Screens/Gps_Screen/provider/choose_Source_Provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/constants.dart';
import '../commanWidget/input_shape.dart';
import 'Component/Add_Hazmat_load.dart';
import 'Component/Add_Trailer_Detail.dart';
import 'Component/Add_Truck_Detail.dart';
import 'Component/Basic_Trip_detail.dart';
import 'Component/Gps_route_list.dart';
import 'Component/choose_source.dart';
import 'Component/myLocation.dart';

class GpsScreen extends StatefulWidget {
  static final CameraPosition intialPos = CameraPosition(
    target: LatLng(37.6, -95.665),
    zoom: 1,
  );

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  @override
  var List = [
    'Add Location',
    'Add Truck',
    "Add Trailer",
    'Hazmat Load',
    "Basic Detail"
  ];

  late AddTripProvider _addTripProvider;
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  initState() {
    super.initState();
    _addTripProvider = context.read<AddTripProvider>();
    _addTripProvider.resetValue();
    _addTripProvider.hitTripHistry();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: APP_BG,
        body: Stack(
          children: [
            Consumer<AddTripProvider>(
              builder: (context, noti, child) => GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(noti.polyline.values),
                markers: Set<Marker>.of(noti.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  noti.controller.complete(controller);
                  if (mounted) setState(() {});
                },
                initialCameraPosition: GpsScreen.intialPos,
              ),
            ),
            Positioned(
              child: Consumer<AddTripProvider>(
                builder: (context, noti, child) => Container(
                  color: APP_BG,
                  height: MediaQuery.of(context).size.height / 7,
                  child: SafeArea(
                    minimum: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.arrow_back),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 1,
                              height: 60,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: List.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(List[index]),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              index == 3
                                                  ? Tooltip(
                                                      key: tooltipkey,
                                                      message:
                                                          'Hazmat stands for hazardous materialsand can include a wide range of substances such as explosives, flammable gases and liquids, poisons, radioactive materials, infectious substances, and other dangerous goods.',
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          tooltipkey
                                                              .currentState!
                                                              .ensureTooltipVisible();
                                                        },
                                                        child: Icon(
                                                            Icons.info_rounded),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          switch (index) {
                                            case 0:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyLocation()));
                                              break;
                                            case 1:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddTruckDetails()));
                                              break;
                                            case 2:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddTrailerDetail()));
                                              break;

                                            case 3:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddHazmatLoad()));
                                              break;
                                            case 4:
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BasicTripDetail()));
                                              break;
                                          }
                                        });
                                  })),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(bottom: 0, child: BottomButton(_addTripProvider))
          ],
        ));
  }
}

class BottomButton extends StatelessWidget {
  AddTripProvider addTripProvider;

  BottomButton(this.addTripProvider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AddTripProvider>(builder: (context, noti, child) {
      if (noti.addAddressData.isNotEmpty && noti.chooseSource.text.isNotEmpty) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: noti.model.routes == null
                ? Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.instance.text('Start Trip'),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: PrimaryColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Starting point' + " : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),

                              // Text(

                              Expanded(
                                  child: Text(noti.chooseSource.text,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500)))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          /* Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.instance.text('Destination') +
                                    " : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(noti.chooseDestination.text,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),*/
                          noti.addAddressData.length == 0
                              ? SizedBox()
                              : SizedBox(
                                  height: noti.addAddressData.length == 1
                                      ? 20
                                      : noti.addAddressData.length == 1
                                          ? 50
                                          : 80,
                                  child: ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: noti.addAddressData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.instance
                                                      .text('Destination') +
                                                  " : ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Text(
                                                  noti.addAddressData[index]
                                                      ['address']!,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          noti.hazmatName == ""
                              ? SizedBox()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Hazmat Load :",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Text(
                                    //   noti.chooseDestination.text,
                                    //   style: TextStyle(
                                    //       fontSize: 14, fontWeight: FontWeight.w500),
                                    Expanded(
                                        child: Text(noti.hazmatName,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)))
                                  ],
                                ),
                          noti.hazmatName == ""
                              ? SizedBox()
                              : SizedBox(
                                  height: 10,
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              noti.truckName == ""
                                  ? SizedBox()
                                  : Expanded(
                                      child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.truck),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(
                                                ": " +
                                                    noti.truckName.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    )),
                              noti.trailerName == ""
                                  ? SizedBox()
                                  : Expanded(
                                      child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.trailer),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        // Text(
                                        //   noti.chooseDestination.text,
                                        //   style: TextStyle(
                                        //       fontSize: 14, fontWeight: FontWeight.w500),
                                        Expanded(
                                            child: Text(
                                                ": " +
                                                    noti.trailerName.toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)))
                                      ],
                                    ))
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          noti.routeStart == true
                              ? CircularProgressIndicator()
                              : GestureDetector(
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.instance
                                            .text('Direction'),
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: PrimaryColor,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                  onTap: () {
                                    // DateTime tempDate = new DateFormat("H:mm").parse(noti.endTime.text.toString());
                                    // var startTime =
                                    //     DateFormat.Hm().format(tempDate);

                                    var date = noti.startDate.text +
                                        ' ' +
                                        noti.endTime.text.toString();

                                    final to12hours =
                                        DateFormat('yyyy-MM-dd hh:mm aa')
                                            .format(DateTime.now());
                                    DateTime now =
                                        DateFormat("yyyy-MM-dd hh:mm aa")
                                            .parse(to12hours);
                                    DateTime now5 =
                                        new DateFormat("yyyy-MM-dd hh:mm aa")
                                            .parse(date.toString());

                                    //
                                    if (noti.chooseSource.text == "")
                                      showMessage('Please select source ');
                                    else if (noti.truckId.toString() == "null")
                                      showMessage('Please add Truck');
                                    else if (noti.trailerId.toString() ==
                                        "null")
                                      showMessage('Please add Trailer');
                                    else if (noti.startDate.text == '' &&
                                        noti.endTime.text == '' &&
                                        noti.grossWeight.text == '')
                                      showMessage("Please Basic Detail");
                                    else if (now5.compareTo(now) == 0 ||
                                        now5.compareTo(now) < 0)
                                      showMessage("Please check Time");
                                    else {
                                      addTripProvider.hitTripCreate();
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: APP_BG,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))))
                : GpsRouteListWidget());
      } else
        return SizedBox();
    });
  }
}
