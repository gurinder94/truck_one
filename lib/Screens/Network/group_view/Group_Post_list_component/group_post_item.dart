import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:provider/provider.dart';

import '../../../../Model/NetworkModel/group_model.dart';
import '../../../Home/Component/description_txt.dart';
import '../GroupComponent/media_portion.dart';
import '../GroupComponent/post_options.dart';
import '../GroupComponent/profile_portion.dart';
import '../group_like_Animation.dart';

class GroupPostItem extends StatelessWidget {
  int index;
  String gId;
  GroupProvider provider;


  GroupPostItem(this.index, this. gId,this.provider , {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var  data = context.watch<PostDatum>();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          // decoration: const BoxDecoration(
          //     color: Color(0xFFEEEEEE),
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //     boxShadow: [
          //       BoxShadow(
          //           color: Colors.black12,
          //           blurRadius: 5,
          //           offset: Offset(5, 5)),
          //       BoxShadow(
          //           color: Colors.white,
          //           blurRadius: 5,
          //           offset: Offset(-5, -5))
          //     ]),
          decoration: BoxDecoration(color: Color(0xFFEEEEEE),

              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
            BoxShadow(
              color: Colors.white,
              offset: Offset(-3.0, -3.0),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3.0, 3.0),
              blurRadius: 2,
            ),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfilePortion( index, gId,data),
              DescriptionTxt(
                description: data.caption!,
                isShared: data.type == 'SHARED' ? true : false,
              ),

              data.media!.length == 0
                  ? SizedBox()
                  : MediaPortion(data.media!,data),

              PostOptions(data,provider),
              // SizedBox(
              //   height: 10,
              // ),

            ],
          ),
        ),
        GroupLikeAnimationComponent(data),
      ],
    );
  }
}
