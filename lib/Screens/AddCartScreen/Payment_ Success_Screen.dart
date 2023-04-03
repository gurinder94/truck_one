// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Model/SubscriptionPlanModel/Cart_model.dart';
// import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
//
// import '../../AppUtils/constants.dart';
// import '../commanWidget/comman_button_widget.dart';
//
// class PaymentSuccessfullyPage extends StatelessWidget {
//   List<CardModelData> cartModelList;
//   String clientSecret,totalPrice ,name;
//   PaymentSuccessfullyPage(this.cartModelList,this.clientSecret, this.totalPrice, this.name, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomAppBarWidget(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back)),
//         title: "Payment Successfully",
//         actions: SizedBox(),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 120,
//             ),
//             Center(
//               child: CircleAvatar(
//                 radius: 45,
//                 backgroundColor: Colors.green,
//                 child: Icon(Icons.check, color: Colors.white, size: 60),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//                 child: Text(
//               "Hi ${name}, Congratulations !",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w300),
//             )),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//                 child: Text(
//               "Payment Successfully",
//               style: TextStyle(
//                   color: Colors.green,
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600),
//             )),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//                 child: Text(
//               "Total :\$${ totalPrice}",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 18,
//               ),
//             )),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.email_outlined,
//                   color: Colors.green,
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text("support@mytruck.one")
//               ],
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 15,right: 15),
//               child: Row(
//                 children: [
//                   Text(
//                     "Payment Id :",
//                     style: TextStyle(
//                         color: Colors.green,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   Text(
//                     clientSecret.toString(),
//                     style: TextStyle(
//                         color: Colors.green,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: ListView.builder(
//                   itemCount: cartModelList.length,
//                   padding: EdgeInsets.zero,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Container(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.only(left: 10),
//                                     height: 1,
//                                     color: Colors.black.withOpacity(0.3),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.all(7.0),
//                                   child: Text(
//                                     cartModelList[index].title.toString(),
//                                     style: TextStyle(
//                                         fontSize: 16, color: Colors.black),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.only(right: 10),
//                                     height: 1,
//                                     color: Colors.black.withOpacity(0.3),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             commonDisplayText(
//                                 "Plan Type",
//                                 cartModelList[index]
//                                     .planName
//                                     .toString()
//                                     .toString()),
//                             Divider(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             commonDisplayText("Date of Purchase",
//                                 formatterDate(DateTime.now())),
//                             Divider(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             commonDisplayText("Validity",
//                                 cartModelList[index].validity.toString()),
//                             Divider(),
//                           ],
//                         ),
//                         decoration: BoxDecoration(
//                             color: Color(0xFFEEEEEE),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.white,
//                                   blurRadius: 5,
//                                   offset: Offset(-5, -5)),
//                               BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 1,
//                                   offset: Offset(5, 5)),
//                             ]),
//                       ),
//                     );
//                   }),
//             ),
//           ],
//         ),
//         floatingActionWidget: SizedBox());
//   }
// }
//
// commonDisplayText(String heading, String value) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(heading,
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//       SizedBox(
//         width: 5,
//       ),
//       Expanded(
//           child: LinearProgressIndicator(
//         minHeight: 1.0,
//       )),
//       SizedBox(
//         width: 5,
//       ),
//       Text(value)
//     ],
//   );
// }
