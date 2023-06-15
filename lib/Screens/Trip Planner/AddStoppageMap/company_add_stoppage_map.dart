import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/TripPlannerModel/TripPlannerListModel.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import 'Component/Add_Marker_List.dart';
import 'Component/Add_Stoppage_Route_List_Widget.dart';
import 'Provider/route_add_marker_provider.dart';

class AddStoppageMap extends StatefulWidget {
  TripPlannerModel data;

  AddStoppageMap(this.data);

  @override
  _AddStoppageMapState createState() => _AddStoppageMapState(data);
}

class _AddStoppageMapState extends State<AddStoppageMap> {
  static final CameraPosition intialPos = CameraPosition(
    target: LatLng(37.6, -95.665),
    zoom: 1,
  );
  TripPlannerModel data;

  _AddStoppageMapState(this.data);

  late RouteMarkerProvider _provider;

  @override
  void initState() {
    var _routeMarkerProvider =
        Provider.of<RouteMarkerProvider>(context, listen: false);
    _routeMarkerProvider.resetRoute();
  }

  @override
  Widget build(BuildContext context) {
    _provider = context.read<RouteMarkerProvider>();
    var _routeMarkerProvider =
        Provider.of<RouteMarkerProvider>(context, listen: false);
    _routeMarkerProvider.setContext(context);

    getData(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: APP_BAR_BG,
          title: Text(AppLocalizations.instance.text('Add Stoppage')),
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
                child: Consumer<RouteMarkerProvider>(
                  builder: (context, noti, child) => GoogleMap(
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: intialPos,
                    polylines: Set<Polyline>.of(noti.polyline.values),
                    markers: Set<Marker>.of(noti.markers.values),
                    onMapCreated: (GoogleMapController controller) {
                      noti.controller.complete(controller);
                    },
                    onTap: (latLng) {
                      showDialog(
                        context: context,
                        builder: (context) => AddMarkerList(
                            latLng, data.id, _routeMarkerProvider),
                      );
                    },
                  ),
                )),
            Expanded(
              flex: 2,
              child: AddStoppageRouteList(data),
            )
          ],
        ));
  }

  void getData(BuildContext context) {
    _provider.getMarkerRouteList(data, context);
  }
}
