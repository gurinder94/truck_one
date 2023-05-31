import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../../Model/NetworkModel/post_list_model.dart';
import '../../Network/Provider/user_detail_provider.dart';
import '../../Network/user_profile.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/Comman_Alert_box.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import '../../commanWidget/pop_menu_Widget.dart';
import '../Component/bottom_widget.dart';
import '../Component/description_txt.dart';
import '../Component/image_video_component.dart';
import '../Component/like_dislike_animation.dart';
import '../Component/shared_widget.dart';
import '../Edit_post_Component/edit_post.dart';
import '../Provider/post_edit_provider.dart';

class MyPostItemWidget extends StatelessWidget {
  HomePageListProvider listProvider;
  int i;

  MyPostItemWidget(this.listProvider, this.i);

  Widget build(BuildContext context) {
    var data = context.watch<PostItem>();

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Row(
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CustomImageProfile(
                            image: data.userData!.image == null
                                ? ' '
                                : IMG_URL + data.userData!.image!,
                            width: 50,
                            boxFit: BoxFit.cover,
                            height: 50),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => UserDetailProvider(),
                                  child: UserProfile(
                                    userId: data.userData!.id!,
                                  ),
                                )));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          capitalize(
                            data.userData!.personName.toString(),
                          ),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          data.postedAt.toString(),
                          style: TextStyle(
                              fontStyle: FontStyle.italic, color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                )),
                data.isMyPost == true
                    ? data.type == "JOIN_GROUP"
                        ? PopMenuBar(
                            iconsName: Icons.more_vert,
                            val: 0,
                            userMenuItems: [
                              [AppLocalizations.instance.text("Delete"), 1]
                            ],
                            containerDecoration: 3,
                            onDoneFunction: (value) {
                              switch (value) {
                                case 1:
                                  postDelete(data.id, context);
                                  break;
                              }
                            })
                        : PopMenuBar(
                            val: 0,
                            userMenuItems: [
                              [AppLocalizations.instance.text("Edit"), 1],
                              [AppLocalizations.instance.text("Delete"), 2]
                            ],
                            containerDecoration: 3,
                            onDoneFunction: (value) {
                              switch (value) {
                                case 1:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                create: (context) =>
                                                    PostEditProvider(),
                                                child: EditPost(
                                                  data,
                                                  listProvider,
                                                  data.type.toString(),
                                                ),
                                              )))
                                    ..then((_) {
                                      listProvider.refresh();
                                    });

                                  break;
                                case 2:
                                  postDelete(data.id, context);
                                  break;
                              }
                            },
                            iconsName: Icons.more_vert,
                          )
                    : PopMenuBar(
                        val: 0,
                        iconsName: Icons.more_vert,
                        userMenuItems: [
                          [AppLocalizations.instance.text("Report"), 1],
                        ],
                        containerDecoration: 3,
                        onDoneFunction: (value) {
                          switch (value) {
                            case 1:
                              showMenu(
                                  context: context,
                                  position:
                                      RelativeRect.fromLTRB(100, 100, 0.0, 0.0),
                                  items: [
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Spam")),
                                      value: 1,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Violence")),
                                      value: 2,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Harassment")),
                                      value: 3,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Inappropriate Content")),
                                      value: 4,
                                    ),
                                    PopupMenuItem(
                                      child: Text(AppLocalizations.instance
                                          .text("Other")),
                                      value: 5,
                                    )
                                  ]).then((value) async {
                                var getid = await getUserId();
                                switch (value) {
                                  case 1:
                                    listProvider.postReport(
                                      {
                                        'postId': data.id,
                                        'userId': getid,
                                        'reason': 'Spam'
                                      },
                                      i,
                                      listProvider,
                                    );
                                    break;
                                  case 2:
                                    listProvider.postReport({
                                      'postId': data.id,
                                      'userId': getid,
                                      'reason': 'Violence'
                                    }, i, listProvider);
                                    break;
                                  case 3:
                                    listProvider.postReport({
                                      'postId': data.id,
                                      'userId': getid,
                                      'reason': 'Harassment'
                                    }, i, listProvider);
                                    break;
                                  case 4:
                                    listProvider.postReport({
                                      'postId': data.id,
                                      'userId': getid,
                                      'reason': 'Inappropriate Content'
                                    }, i, listProvider);
                                    break;
                                  case 5:
                                    listProvider.postReport({
                                      'postId': data.id,
                                      'userId': getid,
                                      'reason': 'Other'
                                    }, i, listProvider);
                                    break;
                                }
                              });
                              break;
                          }
                        })
              ],
            ),
            Divider(),
            DescriptionTxt(
              description: data.caption ?? '',
              isShared: data.type == 'SHARED',
            ),
            data.media!.length > 0
                ? ImageVideoComponent(data.media!, data)
                : SizedBox(),
            data.type == 'JOIN_GROUP'
                ? GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      padding: EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: CustomImageProfile(
                                image: Base_Url_group +
                                    data.groupData!.groupImage.toString(),
                                width: 40,
                                boxFit: BoxFit.contain,
                                height: 40),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.groupData!.name.toString(),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    data.groupData!.totalMembers.toString() +
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
                    },
                  )
                : SizedBox(),
            data.type == 'SHARED'
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SharedWidget(data, listProvider))
                : SizedBox(),
            BottomWidget(list: data, homeProvider: listProvider)
          ]),
          LikeDislikeAnimation(),
        ],
      ),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
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

  void postDelete(String? id, BuildContext context) {
    DialogUtils.showMyDialog(
      context,
      onDoneFunction: () async {
        var getid = await getUserId();

        listProvider
            .postDelete({"postId": id, "userId": getid}, i, listProvider);
        Navigator.pop(context);
      },
      oncancelFunction: () => Navigator.pop(context),
      title: 'Delete',
      alertTitle: "Delete Post",
      btnText: "Done",
    );
  }
}
