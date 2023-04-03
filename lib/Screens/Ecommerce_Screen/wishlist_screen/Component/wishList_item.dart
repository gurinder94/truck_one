// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Model/E_commerce_Model/wish_list_model.dart';
// import 'package:my_truck_dot_one/Screens/Ecommerce_Screen/wishlist_screen/Provider/wishList_Provider.dart';
//
// class WishListItem extends StatelessWidget {
//   Datum wishList;
//    WishListItem(this.wishList);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: EdgeInsets.all(10),
//         padding: EdgeInsets.all(10),
//         decoration: const BoxDecoration(
//             color: Color(0xFFEEEEEE),
//             borderRadius:
//             BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 4,
//                   offset: Offset(5, 5)),
//               BoxShadow(
//                   color: Colors.white,
//                   blurRadius: 4,
//                   offset: Offset(-5, -5))
//             ]),
//         child: Column(children: [
//           LayoutBuilder(
//             builder: (BuildContext context,
//                 BoxConstraints constraints) {
//               if (constraints.maxWidth > 400) {
//                 return eventImage(350, wishList,);
//               } else {
//                 return eventImage(
//                     150,
//                     '',_wishListProvider,noti,index
//                 );
//               }
//             },
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             wishList.productName
//                 .toString(),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 25,
//                 fontWeight: FontWeight.w800,
//                 shadows: [
//                   Shadow(
//                       color: Colors.black12,
//                       offset: Offset(3.0, 3.0),
//                       blurRadius: 3.0),
//                   Shadow(
//                       color: Colors.white10,
//                       offset: Offset(-2.0, -2.0),
//                       blurRadius: 3.0),
//                 ]),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             wishList.price.toString(),
//             overflow: TextOverflow.ellipsis,
//             maxLines: 1,
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//                 shadows: [
//                   Shadow(
//                       color: Colors.black12,
//                       offset: Offset(3.0, 3.0),
//                       blurRadius: 3.0),
//                   Shadow(
//                       color: Colors.white10,
//                       offset: Offset(-2.0, -2.0),
//                       blurRadius: 3.0),
//                 ]),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             wishList.price.toString(),
//             style: TextStyle(
//                 color: Colors.black26,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w800,
//                 shadows: [
//                   Shadow(
//                       color: Colors.black12,
//                       offset: Offset(3.0, 3.0),
//                       blurRadius: 3.0),
//                   Shadow(
//                       color: Colors.white10,
//                       offset: Offset(-2.0, -2.0),
//                       blurRadius: 3.0),
//                 ]),
//           ),
//         ]));
//   }
//   eventImage(
//       double hei, Datum wishList,
//
//       ) {
//     return Stack(
//       children: [
//         Container(
//           height: hei,
//           child: Image.network(
//             "http://74.208.25.43:4000/uploads/product/image/3df4efff-e3f4-45ea-93cf-dc04f6400338-1642065432883_keyshot-icon-256.png",
//             height: hei,
//             width: double.infinity,
//             fit: BoxFit.cover,
//           ),
//         ),
//         Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SizedBox(
//                 height: 2,
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     wishListProvider.removeWishlist(wishListProvider.wishListModel.data![index].productId.toString(),index,wishListProvider)  ;
//
//                   },
//                   child: InsiderButton(
//                       Icon: Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                         size: 25,
//                       )),
//                 ),
//               )
//             ],
//           ),
//           decoration: BoxDecoration(),
//         )
//       ],
//     );
//   }
// }
