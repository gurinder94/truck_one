// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Screens/AddCartScreen/promo_code_page.dart';
// import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/add_cart_provider.dart';
// import 'package:my_truck_dot_one/Screens/AddCartScreen/provider/promo_code_provider.dart';
// import 'package:provider/provider.dart';
//
// import '../../AppUtils/constants.dart';
// import '../commanWidget/comman_button_widget.dart';
// import 'Payment_ Success_Screen.dart';
//
// class AddCartLowerPart extends StatelessWidget {
//   AddCartProvider proData;
//   AddCartProvider provider;
//
//   AddCartLowerPart(this.proData, this.provider);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: proData.cartModelList.length < 2
//           ? MediaQuery.of(context).size.height / 1.7
//           : MediaQuery.of(context).size.height / 2.7,
//       child: Column(children: [
//         Container(
//             margin: EdgeInsets.only(left: 10, right: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListTile(
//                   leading: Icon(Icons.discount),
//                   title: proData.value == null
//                       ? Text("Use Coupons")
//                       : Text(proData.value.code.toString()),
//                   trailing: Icon(Icons.arrow_forward_ios_rounded),
//                   onTap: () {
//                     Navigator.of(context)
//                         .push(
//                       MaterialPageRoute(
//                         builder: (context) => ChangeNotifierProvider(
//                             create: (_) => PromoCodeProvider(),
//                             child: PromoCodePage(proData.value)),
//                       ),
//                     )
//                         .then((value) {
//                       provider.cartModelList = [];
//                       provider.hitAddToCart();
//                       if (value != null)
//                         proData.SelectValuePromoCode(value);
//                        else
//                         proData.SelectValuePromoCode(null);
//                     });
//                   },
//                 ),
//                 // proData.value == null
//                 //     ? SizedBox()
//                 //     : Padding(
//                 //   padding: const EdgeInsets.only(
//                 //       left: 20, right: 10, bottom: 5),
//                 //   child: Text(
//                 //       proData.value.code.toString()),
//                 // )
//               ],
//             ),
//             decoration: BoxDecoration(
//                 color: Color(0xFFEEEEEE),
//                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 5,
//                       offset: Offset(5, 5)),
//                   BoxShadow(
//                       color: Colors.white,
//                       blurRadius: 2,
//                       offset: Offset(-3, -3))
//                 ])),
//         SizedBox(
//           height: 20,
//         ),
//         displayBill("Item total", proData.TotalPrice.floorToDouble().toString(),
//             "Coupon", proData, "Grand Total"),
//         SizedBox(
//           height: 20,
//         ),
//         Selector<AddCartProvider, bool>(
//             selector: (_, provider) => provider.markePaymentLoder,
//             builder: (context, paginationLoading, child) {
//               return CommanButtonWidget(
//                 title: "CheckOut",
//                 buttonColor: PrimaryColor,
//                 titleColor: APP_BG,
//                 onDoneFuction: () async {
//                   //
//                   proData.grandTotalPrice.floor() == 0
//                       ? provider.hitFreePlan()
//                       : provider.makePayment();
//                 },
//                 loder: paginationLoading,
//               );
//             }),
//       ]),
//     );
//   }
//
//   displayBill(String name, String value, String coupon, AddCartProvider proData,
//       String GrandTotal) {
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
