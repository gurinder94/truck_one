import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/description_txt.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_post_list_component/user_like_Animation.dart';

import 'package:my_truck_dot_one/Screens/profile_post_Screen/profile_post_share.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/constants.dart';

import '../../commanWidget/custom_image_network_profile.dart';
import '../../profile_post_Screen/profile_post_item_header.dart';
import '../../profile_post_Screen/profile_post_item_media.dart';
import '../bottom_widget.dart';
import '../group_view/view_group.dart';



class UserPostItem extends StatelessWidget {
  int position;
  UserDetailProvider userDetailProvider;

  UserPostItem({required this.position, required this.userDetailProvider});

  @override
  Widget build(BuildContext context) {
    var _provider = context.watch<PostDatum>();

    return Container(
      padding: EdgeInsets.all(3),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostItemHeaderPart(_provider,userDetailProvider,position),

              Divider(),
              DescriptionTxt(
                description: _provider.caption ?? '',
                isShared: _provider.type == 'SHARED',
              ),
              _provider.media!.length > 0
                  ? ProfilePostMediaPart(_provider.media!,_provider)
                  : SizedBox(),
              _provider.type == 'JOIN_GROUP'
                  ? GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: CustomImageProfile(
                            image: Base_Url_group +
                                _provider.groupData!.groupImage.toString(),
                            width: 40,
                            boxFit: BoxFit.contain,
                            height: 40),
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              _provider.groupData!.name
                                  .toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                                _provider.groupData!.totalMembers
                                    .toString() +
                                    ' members',
                                softWrap: false,
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider(
                                create: (context) =>
                                    GroupProvider(),
                                child: ViewGroup(
                                  gId: _provider.groupData!.id
                                      .toString(),
                                ),
                              )));
                },
              )
                  : SizedBox(),
              _provider.type == 'SHARED'
                  ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:ProfilePostShareWidget(_provider))
                  : SizedBox(),
              PostBottomWidget(
                _provider,
                userDetailProvider,
                position: position,
              ),
            ],
          ),
          UserPostLikeAnimation(_provider),
        ],
      ),
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
    );
  }
}
