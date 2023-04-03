// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/add_cart_provider.dart';
// import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
// import 'package:provider/provider.dart';
// import '../../Model/SubscriptionPlanModel/Cart_model.dart';
// import '../application_localizations.dart';
// import 'Add_cart_item.dart';
// import 'Add_cart_lower.dart';
//
// class AddCartScreen extends StatefulWidget {
//   @override
//   State<AddCartScreen> createState() => _AddCartScreenState();
// }
//
// class _AddCartScreenState extends State<AddCartScreen> {
//   late AddCartProvider _provider;
//
//   @override
//   void initState() {
//     _provider = context.read<AddCartProvider>();
//     // TODO: implement initState
//     _provider.cartModelList = [];
//     _provider.hitAddToCart();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return CustomAppBarWidget(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back)),
//         title: "Plan Cart",
//         actions: SizedBox(),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 110,
//             ),
//             Expanded(
//               child: Consumer<AddCartProvider>(builder: (_, proData, __) {
//                 if (proData.loading) {
//                   return Center(
//                     child: CircularProgressIndicator.adaptive(),
//                   );
//                 }
//                 if (proData.cartModel == null)
//                   return Center(
//                       child: Text(
//                           AppLocalizations.instance.text("No Record Found")));
//                 else if (proData.cartModelList.length == 0)
//                   return Center(
//                       child: Text(
//                           AppLocalizations.instance.text("No Record Found")));
//                 else {
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                             itemCount: proData.cartModelList.length,
//                             padding: EdgeInsets.zero,
//                             itemBuilder: (BuildContext context, int index) {
//                               var planData = proData.cartModelList[index];
//                               return ChangeNotifierProvider<
//                                       CardModelData>.value(
//                                   value: proData.cartModelList[index],
//                                   child: AddCartItem(index, proData));
//                             }),
//                       ),
//                       AddCartLowerPart(proData,_provider)
//
//                     ],
//                   );
//                 }
//               }),
//             ),
//           ],
//         ),
//         floatingActionWidget: SizedBox());
//   }
//
//   displayText(String name, String value, String name2, String value2) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$name',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(
//               height: 4,
//             ),
//             Text(
//               '$value',
//               style: TextStyle(
//                 overflow: TextOverflow.ellipsis,
//               ),
//             )
//           ],
//         )),
//         SizedBox(
//           width: 20,
//         ),
//         Expanded(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '$name2',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             SizedBox(
//               height: 4,
//             ),
//             Text(
//               '$value2',
//               style: TextStyle(
//                 overflow: TextOverflow.ellipsis,
//               ),
//             )
//           ],
//         )),
//       ],
//     );
//   }
//
//   displayBill(String name, String value, String coupon, AddCartProvider proData,
//       String GrandTotal) {
//
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: Container(
//           padding: EdgeInsets.all(10),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     '$name',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Spacer(),
//                   Text(
//                     '$value',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//               Divider(),
//               proData.value == null
//                   ? SizedBox()
//                   : Row(
//                       children: [
//                         Text(
//                           '$coupon',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         Spacer(),
//                         Text(
//                           '${proData.value.code}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//               proData.value == null ? SizedBox() : Divider(),
//               Row(
//                 children: [
//                   Text(
//                     '$GrandTotal',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Spacer(),
//                   Text(
//                     proData.grandTotalPrice.floorToDouble().toString(),
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           decoration: BoxDecoration(
//               color: Color(0xFFEEEEEE),
//               borderRadius: BorderRadius.all(Radius.circular(16)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
//                 BoxShadow(
//                     color: Colors.white, blurRadius: 2, offset: Offset(-3, -3))
//               ])),
//     );
//   }
// }
