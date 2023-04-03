import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/comments_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recomments_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Edit_Recomment_Screen/edit_recomment_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/CommentEditProvider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Container_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';

import '../Edit_Recomment_Screen/edit_recomment_screen.dart';
import 'Edit_comment.dart';

class ReplyRecommectItem extends StatelessWidget {
  List<RecommentModel> list;
  int i;
  ReCommentsProvider provider;
  String commetId;
  CommentsProvider commentsProvider;
  CommentItemModel data;
  RecommentModel Recommentlist;
  String postId;

  ReplyRecommectItem(
    this.list,
    this.i,
    this.provider,
    this.commetId,
    this.commentsProvider,
    this.data,
    this.Recommentlist,
    this.postId,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
          ),
          CustomPaint(
            painter: PathPainter(drawPath()),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => UserDetailProvider(),
                        child: UserProfile(
                          userId: list[i].userId.toString(),
                        ),
                      )));
            },
            child: ProfileImage(
              child: Container(
                clipBehavior: Clip.antiAlias,
                height: 40,
                width: 40,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Image.network(
                  IMG_URL + list[i].image.toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : CircularProgressIndicator.adaptive();
                  },
                  errorBuilder: (a, b, c) =>
                      Center(child: Image.asset('assets/user_ic.png')),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 5),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        capitalize(
                          list[i].personName.toString(),
                        ),
                        style: TextStyle(
                            fontSize: 16.0,
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
                      Recommentlist.isMyComment == true
                          ? SizedBox(
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
                                                      EditRecommentProvider(),
                                                  child: EditRecommentScreen(
                                                      Recommentlist,
                                                      commetId,
                                                      postId,
                                                      list,
                                                      i,
                                                      provider)));

                                      break;
                                    case 2:
                                      DialogUtils.showMyDialog(
                                        context,
                                        onDoneFunction: () async {
                                          var getId = await getUserId();
                                          provider.hitDeleteCommnet({
                                            'userId': getId,
                                            'postId': provider.postId,
                                            'commentId': list[i].id,
                                          }, provider, i, commentsProvider,
                                              data);
                                        },
                                        oncancelFunction: () => Navigator.pop(
                                            navigatorKey.currentState!.context),
                                        title: 'Delete',
                                        alertTitle: "Delete Comment Message",
                                        btnText: "Done",
                                      ).then((value) {
                                        if (value!) {
                                          provider.list.removeAt(i);
                                        }
                                      });
                                      break;
                                  }
                                },
                                iconsName: Icons.more_vert,
                              ),
                            )
                          : SizedBox()
                    ],
                  ),
                  Text(list[i].comment.toString())
                  // DescriptionTextWidget( text:  list.comment.toString(),i)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Path drawPath() {
  Size size = Size(30, 50);
  Path path = Path();
  path.moveTo(0, size.height / 2);
  path.quadraticBezierTo(10, size.height, size.width, 35);
  return path;
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black.withOpacity(.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
