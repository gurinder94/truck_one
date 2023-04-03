import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

LatLng calculateIntermediatePoint(LatLng point1, LatLng point2, double perc) {
//const φ1 = this.lat.toRadians(), λ1 = this.lon.toRadians();
//const φ2 = point.lat.toRadians(), λ2 = point.lon.toRadians();
  double lat1 = degreesToRadians(point1.latitude);
  double lng1 = degreesToRadians(point1.longitude);
  double lat2 = degreesToRadians(point2.latitude);
  double lng2 = degreesToRadians(point2.longitude);

//const Δφ = φ2 - φ1;
//const Δλ = λ2 - λ1;
  double deltaLat = lat2 - lat1;
  double deltaLng = lng2 - lng1;

//const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) + Math.cos(φ1) * Math.cos(φ2) * Math.sin(Δλ/2) * Math.sin(Δλ/2);
//const δ = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  double calcA = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1) * cos(lat2) * sin(deltaLng / 2) * sin(deltaLng / 2);
  double calcB = 2 * atan2(sqrt(calcA), sqrt(1 - calcA));

//const A = Math.sin((1-fraction)δ) / Math.sin(δ);
//const B = Math.sin(fractionδ) / Math.sin(δ);
  double A = sin((1 - perc) * calcB) / sin(calcB);
  double B = sin(perc * calcB) / sin(calcB);

//const x = A * Math.cos(φ1) * Math.cos(λ1) + B * Math.cos(φ2) * Math.cos(λ2);
//const y = A * Math.cos(φ1) * Math.sin(λ1) + B * Math.cos(φ2) * Math.sin(λ2);
//const z = A * Math.sin(φ1) + B * Math.sin(φ2);
  double x = A * cos(lat1) * cos(lng1) + B * cos(lat2) * cos(lng2);
  double y = A * cos(lat1) * sin(lng1) + B * cos(lat2) * sin(lng2);
  double z = A * sin(lat1) + B * sin(lat2);

//const φ3 = Math.atan2(z, Math.sqrt(xx + yy));
//const λ3 = Math.atan2(y, x);
  double lat3 = atan2(z, sqrt(x * x + y * y));
  double lng3 = atan2(y, x);

//const lat = φ3.toDegrees();
//const lon = λ3.toDegrees();
  return LatLng(radiansToDegrees(lat3), radiansToDegrees(lng3));
}

double degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

double radiansToDegrees(double radians) {
  return radians * (180 / pi);
}

double calculateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}