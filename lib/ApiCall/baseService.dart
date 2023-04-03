import 'dart:convert';

import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:http/http.dart' as http;

baseServicePost(String url, Map<String, dynamic> map) async {
  print("SERVER_URL + url${SERVER_URL + url}");
  var res = await http
      .post(Uri.parse(SERVER_URL + url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(map))
      .timeout(Duration(seconds: 40));

  return res;
}

baseServiceGet(String url) async {
  print("SERVER_URL + url${SERVER_URL + url}");
  var res = await http.post(
    Uri.parse(SERVER_URL + url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  ).timeout(Duration(seconds: 40));
  return res;
}

baseStripPost(String url, Map<String, dynamic> map) async {
  var res = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      "Content-Type": "application/x-www-form-urlencoded",
      "Authorization":
          " Bearer sk_test_51HFJPzAbeKm8NUzZNTFa1o89kCpBk5Ngy3QKiF4LBqfhun0hE4xx5f0aIEJWQPyCV4pJdACv3ApYBusrAAWyqsPS00dWbPDx3P",
    },
    body: map,
  );
  return res;
}

TomServiceGet(String url, Map<String, dynamic> map) async {
  var res = await http
      .post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(map))
      .timeout(Duration(seconds: 40));
  return res;
}

baseItunesPost(String url, Map<String, dynamic> map) async {
  var res = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(map),
  )     .timeout(Duration(seconds: 40));
  return res;
}
