import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

final String IMG_URL = SERVER_URL + '/uploads/enduser/';
// final String IMG_URL = SERVER_URL + '/uploads/post/image';
final String Event_logo_Url = SERVER_URL + "/uploads/event/brand_logo/";

final String Resume_Pdf_URl = SERVER_URL + '/uploads/resume/';
final String Base_Url_Image_Group = SERVER_URL + '/uploads/group/';
final String document_Pdf_URl = SERVER_URL + '/uploads/docs/';
final String Base_Url_Image_Service =
    SERVER_URL + '/uploads/service/thumbnail/';
// final String Base_Url_event_banner = SERVER_URL + '/uploads/company/banner/';
bool CHAT_PAGE_OPEN = false;
bool Language_PAGE_OPEN = false;
String languagecode = 'en';
final String Base_Url_event_banner = SERVER_URL + '/uploads/event/image/';
final String profile_banner_url = SERVER_URL + '/uploads/company/banner/';
final String Base_Url_Fleet_truck = SERVER_URL + '/uploads/truck/';
final String Base_Url_Fleet_trailer = SERVER_URL + '/uploads/truck/trailer/';
final String Base_Url_group = SERVER_URL + '/uploads/group/';

final Color PrimaryColor = Color(0xFF044a87);
var AppversionName = "1.1.9";
// final String SERVER_URL = "http://192.168.1.140:1339";
final String SERVER_URL = "https://mytruck.one:1337";

// final String SERVER_URL = 'https://zimotechnologies.in:4000';
final Color IconColor = Colors.black.withOpacity(0.5);
String Base_URL_image = SERVER_URL + '/api/v1/post/uploadImage';
final String Base_URL_group_image = SERVER_URL + '/uploads/post/image/';
String Base_URL_Image_ThumbNail = SERVER_URL + '/uploads/post/image/thumbnail/';

String Base_URL_video_ThumbNail = SERVER_URL + '/uploads/post/video/';

String Base_URL_video = SERVER_URL + '/api/v1/post/uploadVideo/';
String Base_URL_ProductList = SERVER_URL + '/uploads/product/image/';

String Base_url_Add_Product = "https://mytruck.one/login";
String Base_url_Terms_Conditions = "https://mytruck.one/pages/terms-conditions";

String conversationId = "";

showCapitalize(String value) {
  return value[0].toUpperCase() + value.substring(1).toLowerCase();
}

String capitalize(String s) {
  String result = "";
  for (int i = 0; i < s.length; i++) {
    if (i == 0) {
      result += s[i].toUpperCase();
    } else if (s[i - 1] == " ") {
      result += s[i].toUpperCase();
    } else if (s[i - 1] == "-") {
      result += s[i].toUpperCase();
    } else {
      result += s[i];
    }
  }
  return result;
}

resizeMarker(Uint8List bodyBytes) async {
  final int targetWidth = 100;

  final Codec markerImageCodec = await instantiateImageCodec(
    bodyBytes,
    targetWidth: targetWidth,
  );

  final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
  final ByteData? byteData =
      await (frameInfo.image.toByteData(format: ImageByteFormat.png));

  final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
}

Color APP_BAR_BG = Color(0xFF044a87);
Color APP_BG = Color(0xFFEEEEEE);
final globalScaffoldKey = GlobalKey<ScaffoldState>();

void showMessage(String? s) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
    SnackBar(
      content: Text(
        s.toString(),
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.all(15),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}

// Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
//     BuildContext context, String assetName) async {
//   // Read SVG file as String
//   String svgString = await DefaultAssetBundle.of(context).loadString(assetName);
//   // Create DrawableRoot from SVG String
//   DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "null");
//
//   // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
//   MediaQueryData queryData = MediaQuery.of(context);
//   double devicePixelRatio = queryData.devicePixelRatio;
//   double width = 32 * devicePixelRatio; // where 32 is your SVG's original width
//   double height = 32 * devicePixelRatio; // same thing
//
//   // Convert to ui.Picture
//   ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));
//
//   // Convert to ui.Image. toImage() takes width and height as parameters
//   // you need to find the best size to suit your needs and take into account the
//   // screen DPI
//   ui.Image image = await picture.toImage(width.toInt(), height.toInt());
//   ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
//   return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
// }

Color hexToColor(String code) {
  var p = code.length;
  return new Color(int.parse(code.substring(1, p), radix: 16) + 0xFF000000);
}

var inputFormat = DateFormat('MMM-dd-yyyy');
var timeInputFormat = DateFormat('kk:mm');
var notificationTimeInputFormat = DateFormat('MMM-dd-yyyy kk:mm a');

formatterDate(var s) {
  var formatted = inputFormat.format(s);

  return formatted;
}

formatterTime(var s) {
  var formatted = timeInputFormat.format(s);

  return formatted;
}

notificationDateTime(var DateTime) {
  var formatted = notificationTimeInputFormat.format(DateTime);

  return formatted;
}

convertHtmltoText(var description) {
  return Html(
    data: description.toString(),
    style: {
      "body": Style(fontSize: FontSize(13.0), textAlign: TextAlign.justify),
    },
  );
}

String removeTag(String description) {
  var document = parse(description);
  String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}

var deviceId = '';
var deviceType = '';

var deviceName = "";
var deviceVersion = "";
var deviceModel = "";

late BuildContext contxt;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;

BoxDecoration nMbox =
    BoxDecoration(shape: BoxShape.circle, color: mC, boxShadow: [
  BoxShadow(
    color: mCD,
    offset: Offset(10, 10),
    blurRadius: 10,
  ),
  BoxShadow(
    color: mCL,
    offset: Offset(-10, -10),
    blurRadius: 10,
  ),
]);


// Companies, activists push to speed zero-emission truck