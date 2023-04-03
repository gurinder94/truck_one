import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/like_component/like_list.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_post_comment_list/user_comment_page.dart';
import 'package:my_truck_dot_one/Screens/Network/user_post_list_component/User_SharePost.dart';
import 'package:provider/provider.dart';
import '../Home/Provider/like_provider.dart';
import '../Language_Screen/application_localizations.dart';

class PostBottomWidget extends StatelessWidget {
  int position;
  PostDatum userModel;
  UserDetailProvider userDetail;

  PostBottomWidget(this.userModel, this.userDetail, {required this.position});

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
                                child: LikeScreen(userModel.id.toString()))));
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  userModel.totalLike.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey[600]),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                  '${userModel.totalComment} ${AppLocalizations.instance.text('Comments')}',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey[600]),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          userModel.isLiked!?   onLikeTap(true,false):onLikeTap(true,true);
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: userModel.isLiked!
                              ? Colors.blue
                              : Colors.black.withOpacity(.6),
                          size: 18,
                        )),
                    Text(
                      AppLocalizations.instance.text("Likes"),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        create: (context) => CommentsProvider(),
                                        child: UserCommentPage(userModel),
                                      )))..then((_) {
                          userDetail.refreshList();
                          });

                        },
                        icon: Icon(
                          Icons.comment,
                          color: Colors.black.withOpacity(.6),
                          size: 18,
                        )),
                    Text(
                      AppLocalizations.instance.text("Comments"),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                userModel.type == "JOIN_GROUP"
                    ? SizedBox()
                    : Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserSharPost(userModel)));
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.black.withOpacity(.6),
                                size: 18,
                              )),
                          Text(
                            AppLocalizations.instance.text("share"),
                            style: TextStyle(fontSize: 13),
                          )
                        ],
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

  Future<void> onLikeTap(bool bool, bool animation) async {
    var getid = await getUserId();
    var name = await getNameInfo();

    userModel.makePostLike(
      {
        "userId": getid,
        "postId": userModel.id.toString(),
        "liked": bool,
        "isActive": bool
            ? userModel.isLiked!
                ? false
                : true
            : userModel.isDislike!
                ? false
                : true,
        "userName": name,
      },
    );
    if (animation) {
      userModel.listener.LikeEventHit();
      userDetail.refresh();
    }
    // else {
    //   userDetail.refresh();
    // }
  }
}
