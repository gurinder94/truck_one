// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/AppUtils/constants.dart';
// import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
// import 'package:provider/provider.dart';
// import '../PlanUpgradeScreen/Plan_upgrade_page.dart';
// import '../PlanUpgradeScreen/Provider/plan_upgrade_provider.dart';
// import '../application_localizations.dart';
// import '../commanWidget/Comman_Alert_box.dart';
// import '../commanWidget/comman_button_widget.dart';
// import '../commanWidget/comman_rich_text.dart';
// import '../commanWidget/pop_menu_Widget.dart';
// import 'my_plan_provider.dart';
//
// class MyPlanScreen extends StatefulWidget {
//   @override
//   State<MyPlanScreen> createState() => _MyPlanScreenState();
// }
//
// class _MyPlanScreenState extends State<MyPlanScreen> {
//   late MyPlanProvider _provider;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _provider = context.read<MyPlanProvider>();
//     _provider.hitMyPlan();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomAppBarWidget(
//         leading: GestureDetector(
//             child: Icon(Icons.arrow_back),
//             onTap: () {
//               Navigator.pop(context);
//             }),
//         title: "My Plan",
//         actions: SizedBox(),
//         child: Consumer<MyPlanProvider>(builder: (_, proData, __) {
//           if (proData.loading) {
//             return Center(
//               child: CircularProgressIndicator.adaptive(),
//             );
//           }
//           if (proData.myPlanModel == null)
//             return Center(
//                 child: Text(AppLocalizations.instance.text("No Record Found")));
//           else if (proData.myPlanModel!.group!.length == 0)
//             return Center(
//                 child: Text(AppLocalizations.instance.text("No Record Found")));
//           else
//             return Column(
//               children: [
//                 SizedBox(
//                   height: 120,
//                 ),
//                 Expanded(
//                     child: Consumer<MyPlanProvider>(builder: (_, proData, __) {
//                   if (proData.loading) {
//                     return Center(
//                       child: CircularProgressIndicator.adaptive(),
//                     );
//                   }
//                   if (proData.myPlanModel == null)
//                     return Center(
//                         child: Text(
//                             AppLocalizations.instance.text("No Record Found")));
//                   else if (proData.myPlanModel!.group!.length == 0)
//                     return Center(
//                         child: Text(
//                             AppLocalizations.instance.text("No Record Found")));
//                   else
//                     return ListView.builder(
//                         itemCount: proData.myPlanModel!.group!.length,
//                         padding: EdgeInsets.zero,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: Container(
//                               padding: const EdgeInsets.all(20.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       proData.myPlanModel!.group![index]
//                                                   .isActive ==
//                                               false
//                                           ? SizedBox()
//                                           : Checkbox(
//                                               value: proData.myPlanModel!
//                                                   .group![index].isChecked,
//                                               onChanged: (bool? value) {
//                                                 proData
//                                                     .myPlanModel!
//                                                     .group![index]
//                                                     .isChecked = value!;
//
//                                                 if (proData
//                                                         .myPlanModel!
//                                                         .group![index]
//                                                         .isChecked ==
//                                                     true) {
//                                                   proData.setPlanDataValue(
//                                                       proData.myPlanModel!
//                                                           .group![index]);
//                                                 } else {
//                                                   proData.setPlanRemoveValue();
//                                                 }
//
//                                                 setState(() {});
//                                               },
//                                             ),
//                                       CommonRichText(
//                                         richText1: proData.myPlanModel!
//                                             .group![index].data!.title
//                                             .toString(),
//                                         style1: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             height: 1.4,
//                                             fontSize: 14,
//                                             color: Colors.black),
//                                         richText2: '  ' +
//                                             '(${proData.myPlanModel!.group![index].data!.planName.toString()})',
//                                         style2: TextStyle(
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       proData.myPlanModel!.group![index]
//                                                   .isActive ==
//                                               false
//                                           ? PopMenuBar(
//                                               val: 0,
//                                               iconsName: Icons.more_vert,
//                                               userMenuItems: [
//                                                 [
//                                                   AppLocalizations.instance
//                                                       .text("Upgrade"),
//                                                   1
//                                                 ],
//                                                 [
//                                                   AppLocalizations.instance
//                                                       .text("cancel"),
//                                                   2
//                                                 ],
//                                               ],
//                                               containerDecoration: 3,
//                                               onDoneFunction: (value) {
//                                                 switch (value) {
//                                                   case 1:
//                                                     Navigator.push(
//                                                         navigatorKey
//                                                             .currentState!
//                                                             .context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) => ChangeNotifierProvider(
//                                                                 create: (_) =>
//                                                                     PlanUpgradeProvider(),
//                                                                 child: PlanUpgradePage(
//                                                                     proData
//                                                                         .myPlanModel!
//                                                                         .group![
//                                                                             index]
//                                                                         .data!
//                                                                         .id
//                                                                         .toString(),
//                                                                     proData
//                                                                         .myPlanModel!
//                                                                         .group![
//                                                                             index]
//                                                                         .data!
//                                                                         .validity
//                                                                         .toString()))));
//
//                                                     break;
//
//                                                   case 2:
//                                                     _provider.reset();
//                                                     _provider.setPlanDataValue(
//                                                         proData.myPlanModel!
//                                                             .group![index]);
//                                                     _provider
//                                                         .SetSinglePricePlan(
//                                                             proData.myPlanModel!
//                                                                 .group![index]);
//                                                     cancelAlertBox(
//                                                         "300", _provider);
//                                                 }
//                                               })
//                                           : PopMenuBar(
//                                               val: 0,
//                                               iconsName: Icons.more_vert,
//                                               userMenuItems: [
//                                                 [
//                                                   AppLocalizations.instance
//                                                       .text("Upgrade"),
//                                                   1
//                                                 ],
//                                               ],
//                                               containerDecoration: 3,
//                                               onDoneFunction: (value) {
//                                                 switch (value) {
//                                                   case 1:
//                                                     Navigator.push(
//                                                         navigatorKey
//                                                             .currentState!
//                                                             .context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) => ChangeNotifierProvider(
//                                                                 create: (_) =>
//                                                                     PlanUpgradeProvider(),
//                                                                 child: PlanUpgradePage(
//                                                                     proData
//                                                                         .myPlanModel!
//                                                                         .group![
//                                                                             index]
//                                                                         .data!
//                                                                         .id
//                                                                         .toString(),
//                                                                     proData
//                                                                         .myPlanModel!
//                                                                         .group![
//                                                                             index]
//                                                                         .data!
//                                                                         .validity
//                                                                         .toString()))));
//
//                                                     break;
//                                                 }
//                                               })
//                                     ],
//                                   ),
//                                   Divider(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Center(
//                                       child: Text(
//                                     "Plan Features",
//                                     style: TextStyle(
//                                         fontSize: 16,
//                                         fontWeight: FontWeight.w600),
//                                   )),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   ListView.builder(
//                                       shrinkWrap: true,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       itemCount: proData.myPlanModel!
//                                           .group![index].data!.features!.length,
//                                       padding: EdgeInsets.zero,
//                                       itemBuilder:
//                                           (BuildContext context, int i) {
//                                         return Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               // CircleAvatar(
//                                               //     radius: 10,
//                                               //     backgroundColor: Colors.green,
//                                               //     child: Center(
//                                               //       child: Icon(
//                                               //         Icons.check,
//                                               //         size: 17,
//                                               //         color: Colors.white,
//                                               //       ),
//                                               //     )),
//                                               Text(
//                                                 proData
//                                                     .myPlanModel!
//                                                     .group![index]
//                                                     .data!
//                                                     .features![i]
//                                                     .keyName
//                                                     .toString(),
//                                               ),
//                                               Text(proData
//                                                   .myPlanModel!
//                                                   .group![index]
//                                                   .data!
//                                                   .features![i]
//                                                   .keyValue
//                                                   .toString()),
//                                             ],
//                                           ),
//                                         );
//                                       }),
//                                   Divider(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Platform.isIOS == true
//                                       ? commonDisplayText(
//                                           "Price",
//                                           '\$' +
//                                               proData.myPlanModel!.group![index]
//                                                   .data!.iphone_price
//                                                   . floorToDouble()
//                                                   .toString())
//                                       : commonDisplayText(
//                                           "Price",
//                                           '\$' +
//                                               proData.myPlanModel!.group![index]
//                                                   .data!.android_price
//                                                   .floorToDouble()
//                                                   .toString()),
//                                   Divider(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   commonDisplayText(
//                                       "Date of Purchase",
//                                       proData
//                                           .myPlanModel!.group![index].startDate
//                                           .toString()),
//                                   Divider(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   commonDisplayText(
//                                       "Expiry Date",
//                                       proData.myPlanModel!.group![index].endDate
//                                           .toString()),
//                                   Divider(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   commonDisplayText(
//                                       "Validity",
//                                       proData.myPlanModel!.group![index].data!
//                                           .validity
//                                           .toString()),
//                                   Divider(),
//                                 ],
//                               ),
//                               decoration: BoxDecoration(
//                                   color: Color(0xFFEEEEEE),
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.white,
//                                         blurRadius: 5,
//                                         offset: Offset(-5, -5)),
//                                     BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 1,
//                                         offset: Offset(5, 5)),
//                                   ]),
//                             ),
//                           );
//                         });
//                 })),
//                 proData.myPlanModel!.group![0].isActive == true
//                     ? Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CommanButtonWidget(
//                             title: AppLocalizations.instance
//                                 .text("Cancel Subscription"),
//                             buttonColor: PrimaryColor,
//                             titleColor: APP_BG,
//                             onDoneFuction: () {
//                               proData.refundPrice == 0.0
//                                   ? showMessage("Please select Plan")
//                                   : cancelAlertBox(
//                                       "300",
//                                       proData,
//                                     );
//                             },
//                             loder: false,
//                           )
//                         ],
//                       )
//                     : SizedBox(),
//               ],
//             );
//         }),
//         floatingActionWidget: SizedBox());
//   }
//
//   commonDisplayText(String heading, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(heading,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//         SizedBox(
//           width: 5,
//         ),
//         Expanded(
//             child: LinearProgressIndicator(
//           minHeight: 1.0,
//         )),
//         SizedBox(
//           width: 5,
//         ),
//         Text(value)
//       ],
//     );
//   }
// }
//
// cancelAlertBox(String refundPrice, MyPlanProvider provider) {
//   return showGeneralDialog(
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionBuilder: (context, a1, a2, widget) {
//         final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
//         return Transform(
//             transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//             child: Opacity(
//                 opacity: a1.value,
//                 child: AlertDialog(
//                   shape: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(16.0)),
//                   title: Text("Plan Cancel !"),
//                   content: Text(
//                     "The refund amount of \$ ${provider.refundPrice} will be credited to your account within 15 working days.Would you like to proceed?",
//                     textAlign: TextAlign.justify,
//                   ),
//                   actions: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: InkWell(
//                         splashColor: PrimaryColor,
//                         highlightColor: Colors.white,
//                         child: Text(AppLocalizations.instance.text('No'),
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w700, fontSize: 16)),
//                         onTap: () async {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                     SizedBox(),
//                     provider.loderCancel == true
//                         ? CircularProgressIndicator()
//                         : Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: InkWell(
//                               splashColor: PrimaryColor,
//                               highlightColor: Colors.white,
//                               child: Text(
//                                 AppLocalizations.instance.text('Yes'),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w700, fontSize: 16),
//                               ),
//                               onTap: () async {
//                                 provider.hitMyPlanCancel();
//                               },
//                             ),
//                         ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                   ],
//                 )));
//       },
//       transitionDuration: Duration(milliseconds: 200),
//       barrierDismissible: true,
//       barrierLabel: '',
//       context: navigatorKey.currentState!.context,
//       pageBuilder: (context, animation1, animation2) {
//         return SlideTransition(
//           position: Tween(
//             begin: const Offset(0, 1),
//             end: const Offset(0, 0),
//           ).animate(animation1),
//         );
//       });
// }
// // Padding(
// //   padding: const EdgeInsets.all(8.0),
// //   child: GestureDetector(
// //     child: Text(
// //       'Cancel Subscription',
// //       style:
// //       TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //     ),
// //     onTap: () {
// //    proData.refundPrice==0.0?SizedBox():   cancelAlertBox("300", proData);
// //     },
// //   ),
// // )
