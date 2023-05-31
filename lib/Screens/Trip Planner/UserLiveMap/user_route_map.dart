import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Component/route_list_widget.dart';
import 'package:my_truck_dot_one/Screens/Trip%20Planner/UserLiveMap/Provider/route_marker_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

class UserRouteMap extends StatefulWidget {

  ///TripPlannerModel
  TripPlannerModel data;
  String roleType;

  UserRouteMap(
    this.data,
    this.roleType, {
    Key? key,
  });

  @override
  State<UserRouteMap> createState() => _UserRouteMapState();
}

class _UserRouteMapState extends State<UserRouteMap> {
  ///Map Intial Location
  static final CameraPosition intialPos = CameraPosition(
    target: LatLng(37.6, -95.665),
    zoom: 1,
  );
  late RouteMarkerListProvider _provider;

  @override
  void initState() {
    // TODO: implement initState
    _provider = context.read<RouteMarkerListProvider>();
    _provider.RemovePolygonline();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: APP_BAR_BG,
          title: Text(AppLocalizations.instance.text("Choose Route")),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(1),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Consumer<RouteMarkerListProvider>(
                  builder: (context, noti, child) => GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: intialPos,
                    polygons: Set<Polygon>.of(noti.polygon.values),
                    polylines: Set<Polyline>.of(noti.polyline.values),
                    markers: Set<Marker>.of(noti.markers.values),
                    onMapCreated: (GoogleMapController controller) {
                      noti.controller.complete(controller);
                      setState(() {});
                    },
                  ),
                )),
            Expanded(
              flex: 2,
              child: RouteListWidget(widget.roleType),
            )
          ],
        ));
  }

  void getData() {
    _provider.getMarkerRouteList(widget.data);
  }
}
