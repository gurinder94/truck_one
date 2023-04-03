import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/group_comment_screen/group_comment.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../Home/Provider/like_provider.dart';
import '../../../Home/like_component/like_list.dart';

class PostOptions extends StatelessWidget {
  late PostDatum data;
  GroupProvider provider;

  PostOptions(this.data, this.provider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 3,
        ),
        GestureDetector(
          child: Row(
            children: [
              Image.asset(
                'assets/like_ic.png',
                scale: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data.totalLike.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600, color: Colors.grey[600]),
              ),
              SizedBox(
                width: 10,
              ),
              // Image.asset(
              //   'assets/dislike_ic.png',
              //   scale: 30,
              // ),
              // SizedBox(
              //   width: 5,
              // ),
              // Text(
              //   data.totalDislike.toString(),
              //   style: TextStyle(
              //       fontWeight: FontWeight.w600, color: Colors.grey[600]),
              // ),
              Expanded(
                  child: GestureDetector(
                child: Text(
                  '${data.totalComment}   ${ AppLocalizations.instance.text("Comments")}',
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
                              child: GroupCommentPage(
                                data,
                              ))))
                    ..then((_) {
                      provider.refresh();
                    });
                },
              ))
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (_) => LikeProvider(),
                        child: LikeScreen(data.id.toString()))));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             ChangeNotifierProvider(
            //                 create: (_) =>
            //                     GroupLikeProvider(),
            //                 child: GroupLikePage(data))));
          },
        ),
        Divider(
          height: 10,
          thickness: .5,
          color: Colors.grey,
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          children: [
            GestureDetector(
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.thumb_up,
                      size: 18,
                      color: data.isLiked! ? Colors.blue : Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.instance.text("Likes"),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
              onTap: () {
                onLikeTap(true);
              },
            ),

            // Row(
            //   children: [
            //     IconButton(
            //         onPressed: () {
            //           onLikeTap(true);
            //         },
            //         icon: Icon(
            //           Icons.thumb_up,
            //           color: data.isLiked!?Colors.blue:Colors.grey,
            //         )),
            //     Text(
            //       'Like',
            //       style: TextStyle(fontSize: 13),
            //     )
            //   ],
            // ),

            // Spacer(),
            // IconButton(
            //     onPressed: () {
            //       onLikeTap(false);
            //     },
            //     icon: Icon(
            //       Icons.thumb_down,
            //       color: data.isDislike!?Colors.redAccent:Colors.grey,
            //     )),
            Spacer(),
            GestureDetector(
              child: Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.comment,
                      size: 18,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      AppLocalizations.instance.text("Comments"),
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                            create: (context) => CommentsProvider(),
                            child: GroupCommentPage(
                              data,
                            ))))
                  ..then((_) {
                    provider.refresh();
                  });
              },
            )

            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => ChangeNotifierProvider(
            //                 create: (context) => CommentsProvider(),
            //                 child: GroupCommentPage(data ),
            //               )));
            //     },
            //     icon: Icon(
            //       Icons.comment,
            //       color: Colors.black.withOpacity(.6),
            //     )),
          ],
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  Future<void> onLikeTap(bool bool) async {
    var getid = await getUserId();
    var name = await getNameInfo();
    data.makePostLike({
      "userId": getid,
      "postId": data.id!,
      "liked": bool,
      "isActive": bool
          ? data.isLiked!
              ? false
              : true
          : data.isDislike!
              ? false
              : true,
      "userName": name
    });
    if (bool) {
      data.listener!.GroupLikeHit();
    } else {
      data.listener!.GroupDislikeHit();
    }
  }

  DisplayIcon(var iconName, String value) {
    return Row(
      children: [
        Icon(
          iconName,
          size: 18,
          color: data.isDislike! ? Colors.redAccent : Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13),
        )
      ],
    );
  }
}
