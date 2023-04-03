// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/add_cart_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../Model/SubscriptionPlanModel/Cart_model.dart';
//
// class AddCartItem extends StatelessWidget {
//   int index;
//   AddCartProvider proData;
//
//   AddCartItem(this.index, this.proData, {Key? key}) : super(key: key);
//
//   Widget build(BuildContext context) {
//     var provider = context.watch<CardModelData>();
//
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10, bottom: 10),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.only(left: 10),
//                       height: 1,
//                       color: Colors.black.withOpacity(0.3),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(7.0),
//                     child: Text(
//                       "Plan Cart",
//                       style: TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: EdgeInsets.only(right: 10),
//                       height: 1,
//                       color: Colors.black.withOpacity(0.3),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             displayText("Title", provider.title.toString(), "Type",
//                 provider.planName.toString()),
//             SizedBox(
//               height: 10,
//             ),
//             displayText("Duration", provider.validity.toString(),
//                 "Final Price( \$ )",Platform.isAndroid==true? provider.android_price.floorToDouble().toString():provider.iphone_price.floorToDouble().toString()),
//             Align(
//                 alignment: Alignment.bottomRight,
//                 child: GestureDetector(
//                     onTap: () {
//                       provider.hitRemoveToCart(
//                           provider.id.toString(), index, proData);
//                       // proData.hitRemoveToCart(
//                       //     provider.id.toString(),
//                       //     1,provider.isDelete,provider,);
//                     },
//                     child: provider.removeLoding == true
//                         ? SizedBox(
//                             width: 25,
//                             height: 25,
//                             child: CircularProgressIndicator())
//                         : Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ))),
//
//           ],
//         ),
//         decoration: BoxDecoration(
//             color: Color(0xFFEEEEEE),
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.white, blurRadius: 5, offset: Offset(-5, -5)),
//               BoxShadow(
//                   color: Colors.black12, blurRadius: 1, offset: Offset(5, 5)),
//             ]),
//       ),
//     );
//   }
// }
//
// displayText(String name, String value, String name2, String value2) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Expanded(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$name',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           Text(
//             '$value',
//             style: TextStyle(
//               overflow: TextOverflow.ellipsis,
//             ),
//           )
//         ],
//       )),
//       SizedBox(
//         width: 20,
//       ),
//       Expanded(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             '$name2',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           SizedBox(
//             height: 4,
//           ),
//           Text(
//             '$value2',
//             style: TextStyle(
//               overflow: TextOverflow.ellipsis,
//             ),
//           )
//         ],
//       )),
//     ],
//   );
// }
//
// displayBill(String name, String value, String coupon, AddCartProvider proData,
//     String GrandTotal) {
//   print(value);
//   return Padding(
//     padding: const EdgeInsets.only(left: 10, right: 10),
//     child: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   '$name',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   '$value',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             Divider(),
//             proData.value == null
//                 ? SizedBox()
//                 : Row(
//                     children: [
//                       Text(
//                         '$coupon',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Spacer(),
//                       Text(
//                         '${proData.value.code}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//             proData.value == null ? SizedBox() : Divider(),
//             Row(
//               children: [
//                 Text(
//                   '$GrandTotal',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Spacer(),
//                 Text(
//                   '$value',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         decoration: BoxDecoration(
//             color: Color(0xFFEEEEEE),
//             borderRadius: BorderRadius.all(Radius.circular(16)),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
//               BoxShadow(
//                   color: Colors.white, blurRadius: 2, offset: Offset(-3, -3))
//             ])),
//   );
// }
