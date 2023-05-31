import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/constants.dart';
import '../../Model/TripPlannerModel/RouteModel.dart';
import 'UserLiveMap/Provider/user_navigation_provider.dart';

class TrackingSystem extends StatefulWidget {
  Map<PolylineId, Polyline> polyline;
  late UserNavigationProvider _provider;
  List<LatLng> turns;
  RoutePath routePath;
  LatLng routePoint;
  Map<MarkerId, Marker> markers;
  List<LatLng> weatherMarkers;

  TrackingSystem(this.polyline, this.turns, this.routePath, this.markers,
      this.weatherMarkers, this.routePoint);

  @override
  State<TrackingSystem> createState() =>
      _TrackingSystemState(polyline, turns, routePath, markers, weatherMarkers);
}

class _TrackingSystemState extends State<TrackingSystem> {
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

  _TrackingSystemState(this.polyline, this.turns, this.routePath, this.markers,
      this.weatherMarkers);

  @override
  void initState() {
    _provider = context.read<UserNavigationProvider>();

    _provider.savePath(
        polyline, turns, routePath, markers, weatherMarkers, widget.routePoint);
    _provider.setContext(context);

    _provider.setWeatherMarkers(weatherMarkers);
    _provider.hitgetWazeList();
    _provider.getMarkerWazeMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Consumer<UserNavigationProvider>(
          builder: (context, noti, child) {
            return SizedBox();
          },
        ),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: APP_BAR_BG,
          title: Text(AppLocalizations.instance.text("Tracking")),
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
                    onCameraMove: (pos) {
                      _provider.animateMaker(pos);
                    },
                    polylines: Set<Polyline>.of(polyline.values),
                    markers: Set<Marker>.of(
                      _provider.markers.values,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _provider.controller.complete(controller);
                      setState(() {});
                    }
                    // mapType: _provider.mapType,
                    // myLocationButtonEnabled: false,
                    //
                    // zoomControlsEnabled: false,
                    // initialCameraPosition: intialPos,
                    // trafficEnabled: true,
                    //
                    // polylines: Set<Polyline>.of(polyline.values),
                    // markers: Set<Marker>.of(_provider.markers.values,),
                    // onMapCreated: (GoogleMapController controller) {
                    //   _provider.controller.complete(controller);
                    // },
                    ),
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
}
