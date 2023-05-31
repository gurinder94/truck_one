import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/RouteModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Provider/user_navigation_provider.dart';
import 'package:provider/provider.dart';
import 'Component/instruction_widget.dart';
import 'Component/speed_widget.dart';

class UserMapNavigation extends StatefulWidget {
  Map<PolylineId, Polyline> polyline;
  late UserNavigationProvider _provider;
  List<LatLng> turns;
  RoutePath routePath;
  Map<MarkerId, Marker> markers;
  List<LatLng> weatherMarkers;
  LatLng routePoint;

  UserMapNavigation(this.polyline, this.turns, this.routePath, this.markers,
      this.weatherMarkers, this. routePoint);

  @override
  _UserMapNavigationState createState() => _UserMapNavigationState(
      polyline, turns, routePath, markers, weatherMarkers);
}

class _UserMapNavigationState extends State<UserMapNavigation> {
  LatLng weatherPos = LatLng(37.6, -95.665);
  static final CameraPosition intialPos = CameraPosition(
    target: LatLng(37.6, -95.665),
    zoom: 1,
  );
  Map<PolylineId, Polyline> polyline;
  late UserNavigationProvider _provider;
  List<LatLng> turns;
  RoutePath routePath;
  Map<MarkerId, Marker> markers;
  List<LatLng> weatherMarkers;

  _UserMapNavigationState(this.polyline, this.turns, this.routePath,
      this.markers, this.weatherMarkers);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.read<UserNavigationProvider>();
    _provider.savePath(polyline, turns, routePath, markers, weatherMarkers,widget.routePoint);
    _provider.setContext(context);
    _provider.hitgetWazeList();
    _provider.getMarkerWazeMap();
    _provider.listenWaze(context);
_provider. setWeatherMarkers(weatherMarkers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Consumer<UserNavigationProvider>(
          builder: (context, noti, child) {
            return FloatingActionButton(
                backgroundColor: APP_BAR_BG,
                onPressed: () {
                  if (noti.routingStart)
                    noti.stopRouting();
                  else
                    noti.getLocation();
                },
                child: Text(noti.routingStart == false ? 'Start' : 'Stop'));
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: APP_BAR_BG,
          title: Text('Navigation'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(1),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _provider.setCamera();
                },
                icon: Icon(FontAwesomeIcons.mapMarkerAlt)),
            PopupMenuButton(
                onSelected: (val) {
                  switch (val) {
                    case 1:
                      _provider.setMapType(MapType.satellite);
                      break;
                    case 2:
                      _provider.setMapType(MapType.normal);
                      break;
                    case 3:
                      _provider.setMapType(MapType.terrain);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 1,
                        child: Text('Satellite'),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Text('Normal'),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Text('Terrain'),
                      ),
                    ])
          ],
        ),
        body: Consumer<UserNavigationProvider>(
          builder: (context, noti, child) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                GoogleMap(
                  mapType: _provider.mapType,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: intialPos,
                  trafficEnabled: true,
                  onCameraMove: (pos){
                    _provider.animateMaker(pos);
                  },
                  polylines: Set<Polyline>.of(polyline.values),
                  markers: Set<Marker>.of(_provider.markers.values,),
                  onMapCreated: (GoogleMapController controller) {
                    _provider.controller.complete(controller);
                  },
                ),
                Positioned(
                    top: 10,
                    right: 20,
                    child: SpeedWidget(speed: _provider.speed)),
                Positioned(
                  top: 80,
                  right: 20,
                  child: InstructionWidget(
                    inst: _provider.instruction,
                  ),
                ),
                Positioned(
                    top: 160,
                    right: 20,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: GestureDetector(
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.black,
                        ),
                        onTap: () {
                          showReportMarkerList(context);
                        },
                      ),
                    ))
              ],
            );
          },
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_provider.routingStart) _provider.stopRouting();
    super.dispose();
  }

  showReportMarkerList(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Add a report",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.3,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                    children: List.generate(_provider.wazeModel.data!.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: CircleAvatar(
                                  radius: 25,
                                  foregroundColor: Colors.blue.withOpacity(0.3),
                                  child: Image.network(
                                    SERVER_URL +
                                        "/uploads/wazeicon/thumbnail/" +
                                        _provider.wazeModel.data![index].image
                                            .toString(),
                                    width: 35,
                                    height: 35,
                                  )),
                              onTap: () {

                                _provider.setReportMarkers(
                                  _provider.wazeModel.data![index].iconName
                                      .toString(),
                                  _provider.wazeModel.data![index].id
                                      .toString(),
                                );
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(_provider.wazeModel.data![index].iconName
                                .toString()),
                          ],
                        ),
                      );
                    })),
              ),
            ],
          );
        });
  }
}
