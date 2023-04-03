//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/EventScreen/EventListScreen/EventList.dart';
// import 'package:my_truck_dot_one/Screens/EventScreen/UserEventScreen/EventListScreen/Provider/UserEventTabBarProvider.dart';
// import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/ViewEventProvider.dart';
// import 'package:provider/provider.dart';
//
// import '../../../AppUtils/constants.dart';
// late EventViewProvider  _eventViewProvider;
// showAlertDialog(BuildContext context) {
//   // Create button
//   _eventViewProvider = Provider.of<EventViewProvider>(context,listen: false);
//   Widget okButton = InkWell(
//     splashColor: PrimaryColor,
//     highlightColor: Colors.white,
//     child:Text("Delete event"),
//     onTap: () {
//       Navigator.pop(context);
//       Navigator.pop(context);   _eventViewProvider.hitDeleteEvent(context);
//
//
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MultiProvider(providers: [
//                 ChangeNotifierProvider(
//                     create: (_) => UserEventTabBarProvider()),
//               ], child: EventList())));
//     },
//
//
//
//   );
//
//
//   Widget ok =  InkWell(
//     splashColor: PrimaryColor,
//     highlightColor: Colors.white,
//     child: Text("Keep event"),
//     onTap: () {
//       Navigator.pop(context);  Navigator.pop(context);
//     },
//
//
//
//   );
//   AlertDialog alert = AlertDialog(
//     title: Text("Delete event"),
//     content: Text("When you delete this event,the event page will no longer be accessible  to anyone.This is a permanemt and  irreversible action.",style: TextStyle(height: 1.5),),
//     actions: [
//       Column(
//         children: [
//           okButton,
//           ok,
//         ],
//       ),
//
//     ],
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }