// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/JobScreen/JobList/UserComponent/Provider/UserJobProvider.dart';
// import 'package:provider/provider.dart';
// import 'Menubar.dart';
//
// class CustomAppBar extends StatelessWidget {
//   Widget child;
//   String title;
//   bool visual = false;
//
//   CustomAppBar(
//       {required this.child, required this.title, required this.visual});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height,
//               child: child,
//               color: Color(0xFFEEEEEE),
//             ),
//             Positioned(
//               top: 0,
//               child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 90,
//                 child: Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 30, top: 20),
//                         child: GestureDetector(
//                           child: Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 80,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 20,
//                           right: 70,
//                         ),
//                         child: Text(
//                           title,
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                       ),
//                       Spacer(),
//                       Expanded(child: Container()),
//                       visual == false
//                           ? Expanded(child: Container())
//                           : Padding(
//                               padding:
//                                   const EdgeInsets.only(top: 20, right: 20),
//                               child: Container(
//                                 child: GestureDetector(
//                                   child: Icon(
//                                     Icons.more_vert,
//                                     size: 25,
//                                     color: Colors.white,
//                                   ),
//                                   onTap: () {
//                                     _showmanageButtonPressed(context);
//                                     // showModalBottomSheet<void>(
//                                     //   context: context,
//                                     //   builder: (BuildContext context) {
//                                     //     return
//                                     //
//                                     //
//                                     //   },
//                                     // );
//                                   },
//                                 ),
//                               ),
//                             ),
//                     ],
//                   ),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF044a87),
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(30),
//                       bottomLeft: Radius.circular(30)),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
//
//   _showmanageButtonPressed(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (context) {
//           return Container(
//               color: Color(0xFF737373),
//               child: SingleChildScrollView(
//                 child: Container(
//                     child: Menubar(),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).canvasColor,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20)),
//                     )),
//               ));
//         });
//   }
// }
