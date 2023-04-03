import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/share_post_component/share_post_dialog.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/like_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:provider/provider.dart';

import '../comment_page.dart';
import '../like_component/like_list.dart';

class BottomWidget extends StatelessWidget {
  PostItem list;
  HomePageListProvider homeProvider;

  BottomWidget({required this.list, required this.homeProvider});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Image.asset(
                    'assets/like_ic.png',
                    scale: 30,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => LikeProvider(),
                                child: LikeScreen(list.id.toString()))));
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  list.totalLike.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey[600]),
                ),
                Expanded(
                    child: GestureDetector(
                  child: Text(
                    '${list.totalComment} ${AppLocalizations.instance.text('Comments')}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => CommentsProvider(),
                                  child: CommentPage(list.id.toString(),
                                      list.postId.toString(), list.isMyPost!),
                                )));
                  },
                ))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey[300],
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: list.isLiked!
                            ? Colors.blue
                            : Colors.black.withOpacity(.6),
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.instance.text('like'),
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  onTap: () {
                    list.isLiked!?   onLikeTap(true,false):onLikeTap(true,true);
                  },
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Icon(
                        Icons.comment,
                        color: Colors.black.withOpacity(.6),
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        AppLocalizations.instance.text('comment'),
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => CommentsProvider(),
                                  child: CommentPage(list.id.toString(),
                                      list.postId.toString(), list.isMyPost!),
                                )));
                  },
                ),
                list.type == "JOIN_GROUP"
                    ? SizedBox()
                    : GestureDetector(
                        child: Row(
                          children: [
                            Icon(
                              Icons.share,
                              color: Colors.black.withOpacity(.6),
                              size: 18,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              AppLocalizations.instance.text('share'),
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        ),
                        onTap: () {
                          sharePost(
                            context,
                            list,
                          );
                        },
                      ),
              ],
            ),
          ],
        ),
      ),
      // decoration: const BoxDecoration(
      //     color: Color(0xFFEEEEEE),
      //
      //     boxShadow: [
      //       BoxShadow(
      //           color: Colors.black12,
      //           blurRadius: 5,
      //           offset: Offset(5, 5)),
      //
      //     ]),
    );
  }

  void sharePost(BuildContext context, PostItem list) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SharePost(list, homeProvider)));
  }

  Future<void> onLikeTap(bool bool, bool animation) async {
    var getid = await getUserId();
    var name = await getNameInfo();
    var image = await getprofileInfo();
    list.makePostLike({
      "userId": getid,
      "postId": list.id!,
      "liked": bool,
      "isActive": bool
          ? list.isLiked!
              ? false
              : true
          : list.isDislike!
              ? false
              : true,
      "userName": name,
      "userImage": image == null ? null : image,
    });
    if (animation) {
      print(animation);
      list.listener!.LikeEventHit();
    }
    // } else {
    //   list.listener!.DislikeEventHit();
    // }
  }
}
