import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/CommentComponent/reply_recommentList.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/CommentEditProvider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/custom_image_network_profile.dart';
import 'Edit_comment.dart';

class orginalCommentItem extends StatefulWidget {
  List<CommentItemModel> list;
  String postId;
  Function replyClick;
  CommentsProvider provider;
  int index;
  bool isMyPost;

  orginalCommentItem(this.list, this.postId, this.provider, this.index,
      {required this.replyClick, required this.isMyPost});

  @override
  _orginalCommentItemState createState() => _orginalCommentItemState(
        list,
        postId,
        provider,
        index,
        replyClick: replyClick,
      );
}

class _orginalCommentItemState extends State<orginalCommentItem> {
  List<CommentItemModel> list;
  String postId;
  Function replyClick;
  late CommentItemModel data;
  CommentsProvider provider;
  int index;

  _orginalCommentItemState(this.list, this.postId, this.provider, this.index,
      {required this.replyClick});

  var check = false;
  String? firstHalf;
  String? secondHalf;

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    data = context.watch<CommentItemModel>();
    m(data);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Positioned(
            left: 30,
            top: 0,
            bottom: 0,
            width: 1,
            child: Container(color: Colors.black26), // replace with your image
          ),
          Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                              create: (context) => UserDetailProvider(),
                              child: UserProfile(
                                userId: data.userId.toString(),
                              ),
                            )));
                  },
                  child: CustomImageProfile(
                      image: IMG_URL + data.image.toString(),
                      width: 50,
                      boxFit: BoxFit.contain,
                      height: 50),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: Offset(5, 5)),
                              BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                  offset: Offset(-5, -5))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CommonRichText(
                                    richText1: capitalize(
                                      data.personName.toString(),
                                    ),
                                    style1: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: PrimaryColor,
                                    ),
                                    richText2: data.isEdited == true
                                        ? '${'  '}(Edit)'
                                        : '',
                                    style2: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                  data.isMyComment == true
                                      ?SizedBox(
                                    height: 25,
                                    child: PopMenuBar(
                                      val: 0,
                                      userMenuItems: [

                                          [AppLocalizations.instance.text("Edit"), 1],
                                          [AppLocalizations.instance.text("Delete"), 2],


                                      ],
                                      containerDecoration: 3,
                                      onDoneFunction: (value) {
                                        switch (value) {
                                          case 1:
                                            showBottomSheet(
                                                context: context,
                                                builder: (context) =>
                                                    ChangeNotifierProvider(
                                                        create: (context) =>
                                                            CommentEditProvider(),
                                                        child:
                                                        EditComment(
                                                            data,
                                                            provider,
                                                            index)));

                                            break;
                                          case 2:
                                            DialogUtils.showMyDialog(
                                              context,
                                              onDoneFunction: () async {
                                                var getId =
                                                await getUserId();
                                                provider
                                                    .hitDeleteCommnet({
                                                  'userId': getId,
                                                  'postId': postId,
                                                  'commentId': data.id
                                                      .toString(),
                                                }, provider, index);
                                                Navigator.pop(context);
                                              },
                                              oncancelFunction: () =>
                                                  Navigator.pop(
                                                      context),
                                              title: 'Delete',
                                              alertTitle:
                                              "Delete Comment Message",
                                              btnText: "Done",
                                            );
                                            break;
                                        }
                                      },
                                      iconsName: Icons.more_vert,
                                    ),
                                  )


                                      : widget.isMyPost == true
                                          ? SizedBox(
                                              height: 25,
                                              child: PopMenuBar(
                                                val: 0,
                                                userMenuItems: [
                                                  [
                                                    AppLocalizations.instance
                                                        .text("Delete"),
                                                    1
                                                  ],
                                                ],
                                                containerDecoration: 3,
                                                onDoneFunction: (value) {
                                                  switch (value) {
                                                    case 1:
                                                      DialogUtils.showMyDialog(
                                                        context,
                                                        onDoneFunction:
                                                            () async {
                                                          var getId =
                                                              await getUserId();
                                                          provider
                                                              .hitDeleteCommnet(
                                                                  {
                                                                'userId': getId,
                                                                'postId':
                                                                    postId,
                                                                'commentId': data
                                                                    .id
                                                                    .toString(),
                                                              },
                                                                  provider,
                                                                  index);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        oncancelFunction: () =>
                                                            Navigator.pop(
                                                                context),
                                                        title: 'Delete',
                                                        alertTitle:
                                                            "Delete Comment Message",
                                                        btnText: "Done",
                                                      );
                                                      break;
                                                  }
                                                },
                                                iconsName: Icons.more_vert,
                                              ),
                                            )
                                          : SizedBox()
                                ]
                                // GestureDetector(child: Icon(Icons.delete),
                                // onTap: () async {

                                ),
                            Container(
                              padding: new EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 2.0),
                              child: secondHalf!.isEmpty
                                  ? new Text(firstHalf!)
                                  : new Column(
                                      children: <Widget>[
                                        new Text(flag
                                            ? (firstHalf! + "...")
                                            : (firstHalf! + secondHalf!)),
                                        new InkWell(
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              new Text(
                                                flag
                                                    ? "show more"
                                                    : "show less",
                                                style: new TextStyle(
                                                    color: PrimaryColor),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            setState(() {
                                              flag = !flag;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              replyClick(
                                true,
                                data.id,
                              );
                              provider.setTotal(data);
                            },
                            child: Text(
                              'Reply',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: PrimaryColor,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black12,
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 3.0),
                                    Shadow(
                                        color: Colors.white10,
                                        offset: Offset(-3.0, 3.0),
                                        blurRadius: 3.0),
                                  ]),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                if (check == true) {
                                  setState(() {
                                    check = false;
                                  });
                                } else {
                                  // print(data.)

                                  setState(() {
                                    check = true;
                                  });
                                }
                              },
                              child: data.totalReComment! > 0
                                  ? check == true
                                      ? Text(
                                          'Hide replies',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: PrimaryColor,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black12,
                                                    offset: Offset(3.0, 3.0),
                                                    blurRadius: 3.0),
                                                Shadow(
                                                    color: Colors.white10,
                                                    offset: Offset(-3.0, 3.0),
                                                    blurRadius: 3.0),
                                              ]),
                                        )
                                      : Text(
                                          'view ${data.totalReComment} replies',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                              color: PrimaryColor,
                                              shadows: [
                                                Shadow(
                                                    color: Colors.black12,
                                                    offset: Offset(3.0, 3.0),
                                                    blurRadius: 3.0),
                                                Shadow(
                                                    color: Colors.white10,
                                                    offset: Offset(-3.0, 3.0),
                                                    blurRadius: 3.0),
                                              ]),
                                        )
                                  : SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            data.totalReComment == 0
                ? SizedBox()
                : check == true
                    ? ChangeNotifierProvider(
                        create: (_) => ReCommentsProvider(),
                        child: RecommentList(
                          data,
                          postId,
                          index,
                          list,
                          provider,
                        ))
                    : SizedBox(),
          ])
        ]));
  }

  m(CommentItemModel data) {
    setState(() {
      if (data.comment!.length > 80) {
        firstHalf = data.comment!.substring(0, 50);
        secondHalf = data.comment!.substring(50, data.comment!.length);
      } else {
        firstHalf = data.comment;
        secondHalf = "";
      }
    });
  }
}
