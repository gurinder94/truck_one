// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Model/plan_upgrade_model.dart';
// import 'package:my_truck_dot_one/Screens/PlanUpgradeScreen/Provider/plan_upgrade_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../AppUtils/constants.dart';
// import '../commanWidget/commanButton.dart';
//
// class PlanUpgradeItem extends StatelessWidget {
//
//   PlanUpgradeProvider proData;
//   String previousPlanId;
//   PlanUpgradeItem( this.proData,this.previousPlanId , {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var data= context.watch<Datum>();
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Text(
//               data.heading.toString() + "(${data.planName.toString()})",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ListView.builder(
//               shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: data.features!.length,
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         CircleAvatar(
//                             radius: 10,
//                             backgroundColor: Colors.green,
//                             child: Center(
//                               child: Icon(
//                                 Icons.check,
//                                 size: 17,
//                                 color: Colors.white,
//                               ),
//                             )),
//                         Text(
//                           data.features![index].keyName.toString(),
//                         ),
//                         Text(
//                           data.features![index].keyValue.toString(),
//                         ),
//                       ],
//                     ),
//                   );
//                 }),
//             Divider(),
//             Platform.isIOS == true
//                 ? displayText("Validity", data.validity.toString(), "Price",
//                     "\$${data.iphonePrice!.floorToDouble().toString()}")
//                 : displayText("Validity", data.validity.toString(), "Price",
//                     "\$${data.androidPrice!.floorToDouble().toString()}"),
//             Divider(),
//             SizedBox(
//               width: MediaQuery.of(context).size.width / 1.0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Spacer(),
//                   CommanButton(
//                     title: "Upgrade",
//                     buttonColor: PrimaryColor,
//                     titleColor: APP_BG,
//                     onDoneFuction: () {
//                       data.makePayment(
//                         Platform.isIOS == true
//                             ? data.iphonePrice!.floorToDouble()
//                             : data.androidPrice!.floorToDouble(),
//                         data.id!,previousPlanId,proData);
//                       // subscriptionModel.makePayment( Platform.isIOS==true?subscriptionModel.iphone_price.floorToDouble():subscriptionModel.android_price.floorToDouble());
//                     },
//                     loder: data.markePaymentLoder,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//         padding: const EdgeInsets.all(8.0),
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
//
//   displayText(String name, String value, String name2, String value2) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '$name',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 '$value',
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             ],
//           )),
//           SizedBox(
//             width: 20,
//           ),
//           Expanded(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '$name2',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 '$value2',
//                 style: TextStyle(
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }
