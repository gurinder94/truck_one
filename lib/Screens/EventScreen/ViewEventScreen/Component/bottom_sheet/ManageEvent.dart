// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/Provider/EditProvider.dart';
// import 'package:my_truck_dot_one/Screens/EventScreen/EditEventScreen/editEventScreen.dart';
// import 'package:provider/provider.dart';
//
// class ManageEvent extends StatefulWidget {
//   @override
//   _ManageEventState createState() => _ManageEventState();
// }
//
// class _ManageEventState extends State<ManageEvent> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(child:Column(
//       children: [
//         SizedBox(
//           height: 20,
//         ),
//         Container(
//           width: 100,
//           height: 4,
//           color: Color(0xFF1A62A9),
//         ),
//         Padding(
//             padding:
//             const EdgeInsets.only(left: 25, right: 10, bottom: 10, top: 30),
//             child: Row(
//               children: [
//                 Text(
//                   "Manage event",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.w800,
//                       fontSize: 20),
//                 )
//               ],
//             )),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             child: Row(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 15),
//                     child: Image.asset(
//                       "icons/edit.jpg",
//                       scale: (1.2),
//
//                     )),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15,right: 15),
//                   child: Text(
//                     "Edit event",
//                     style: TextStyle(color: Colors.black, fontSize: 16),
//                   ),
//                 )
//               ],
//             ),
//             onTap: () {
//               print("hello");
//               openeditevent(context);
//
//             },
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           height: 1,
//           color: Colors.black26,
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             child: Row(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 15),
//                     child: Image.asset(
//                       "icons/team-management.jpg",
//                       scale: (1.2),
//
//                     )),
//                 Padding(
//                     padding: const EdgeInsets.only(left: 10,right: 15),
//                     child: Text(
//                       "Manage attendees",
//                       style: TextStyle(color: Colors.black, fontSize: 16),
//                     )),
//               ],
//             ),
//             onTap: () {
//               openmanageattendee(context);
//             },
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           height: 1,
//           color: Colors.black26,
//         ),
//         // Padding(
//         //   padding: const EdgeInsets.all(8.0),
//         //   child: InkWell(
//         //     child: Row(
//         //       children: [
//         //         Padding(
//         //             padding: const EdgeInsets.only(left: 25, right: 20),
//         //             child: Image.asset(
//         //               "icons/trash.jpg",
//         //               scale: (1.2),
//         //
//         //             )),
//         //         Padding(
//         //           padding: const EdgeInsets.only(left: 10,right: 15),
//         //           child: Text("Delete event"),
//         //         )
//         //       ],
//         //     ),
//         //     onTap: ()
//         //     {
//         //       setState(() {
//         //
//         //         showAlertDialog(context);
//         //
//         //
//         //       });
//         //
//         //     },
//         //   ),
//         // ),
//       ],
//
//     )
//     );
//   }
//   openeditevent(BuildContext context) {
//
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) =>  ChangeNotifierProvider(
//         create: (_) => EditEventProvider(
//
//         ),
//         child: EditEvent())));
//   }
//
//   openmanageattendee(BuildContext context) {
//
//     // Navigator.push(
//     //
//     //     context,
//     //     MaterialPageRoute(builder: (context) => ManageAttendeeEvent()));
//
//   }
//
//
// }
