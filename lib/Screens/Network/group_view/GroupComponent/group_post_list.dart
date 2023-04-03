// import 'package:flutter/material.dart';
// import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
// import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
// import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/post_options.dart';
// import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/profile_portion.dart';
// import 'package:provider/provider.dart';
// import 'description_portion.dart';
// import 'media_portion.dart';
//
// class GroupPostList extends StatelessWidget {
//   @override
//   String gId;
//
//   GroupPostList(this.gId);
//
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Consumer<GroupProvider>(
//         builder: (context, noti, child) {
//           return RefreshIndicator(
//             onRefresh: _refresh,
//             child: ListView.builder(
//                 itemCount: noti.list.length,
//                 shrinkWrap: false,
//                  physics: NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.zero,
//                 itemBuilder: (context, index) {
//                   PostDatum _data = noti.list[index];
//                   return ChangeNotifierProvider<PostDatum>.value(
//                     value: _data,
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 25),
//                       child: Container(
//                         margin: EdgeInsets.all(10),
//                         padding: EdgeInsets.all(10),
//                         decoration: const BoxDecoration(
//                             color: Color(0xFFEEEEEE),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Colors.black12,
//                                   blurRadius: 5,
//                                   offset: Offset(5, 5)),
//                               BoxShadow(
//                                   color: Colors.white,
//                                   blurRadius: 5,
//                                   offset: Offset(-5, -5))
//                             ]),
//                         child: Column(
//                           children: [
//                             ProfilePortion( index, gId,),
//
//                             DescriptionPortion(_data.caption.toString()),
//                             _data.media!.length == 0
//                                 ? SizedBox()
//                                 : MediaPortion(),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             PostOptions(),
//                             SizedBox(
//                               height: 10,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//           );
//         },
//       ),
//     );
//   }
//
//   Future<void> _refresh() async {}
// }
