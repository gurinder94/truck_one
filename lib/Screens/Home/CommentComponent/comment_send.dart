import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/comments_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/recomments_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';
import '../../../Model/profanity_filter.dart';
import '../../commanWidget/custom_image_network_profile.dart';

class CommentSend extends StatelessWidget {
  var msgController = TextEditingController();
  String id;
  CommentsProvider provider;

  CommentSend(
    this.id,
    this.provider,
  );

  final filter = ProfanityFilter();

  @override
  Widget build(BuildContext context) {
    var _provider = context.watch<CommentsProvider>();

    return _provider.check == false
        ? Container(
            padding: EdgeInsets.all(12),
            child: Row(
              children: [
                CustomImageProfile(
                    image: IMG_URL + _provider.image,
                    width: 50,
                    boxFit: BoxFit.contain,
                    height: 50),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: InputTextField(
                          child: TextFormField(
                            maxLines: 10,
                            minLines: 1,
                            maxLength: 1000,
                            controller: msgController,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 14),
                            decoration:  InputDecoration(
                              counterText: '',
                              hintText:AppLocalizations.instance.text("write here..."),
                              border: InputBorder.none,
                              hintStyle: TextStyle(fontSize: 14),
                            ),
                            keyboardType: TextInputType.multiline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<CommentsProvider>(builder: (context, noti, child) {
                  return noti.postComment
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : IconButton(
                          onPressed: () async {
                            if (msgController.text.trim().isEmpty) {
                              showMessage(
                                'Please enter comment',
                              );
                            } else {
                              var getid = await getUserId();
                              var name = await getNameInfo();
                              CommentsProvider provider =
                                  context.read<CommentsProvider>();
                              provider.postCommnet(
                                {
                                  "userId": getid,
                                  "postId": id,
                                  "comment": filter
                                      .censor(msgController.text.toString()),
                                  "userName": capitalize(name),
                                },
                                msgController.text,
                                provider,
                              );
                              msgController.text = "";
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            size: 30,
                          ));
                })
              ],
            ),
          )
        : Consumer<ReCommentsProvider>(builder: (context, noti, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
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
                    children: [
                      Center(
                          child: Text(
                        "Reply ",
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
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        SizedBox(
                          height: 10,
                        ),
                        CustomImageProfile(
                            image: IMG_URL + _provider.image,
                            width: 50,
                            boxFit: BoxFit.contain,
                            height: 50),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: InputTextField(
                                    child: TextFormField(
                                      maxLength: 150,
                                      controller: msgController,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(fontSize: 14),
                                      decoration: const InputDecoration(
                                        counterText: '',
                                        hintText: 'write here...',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (msgController.text.isEmpty) {
                                showMessage(
                                  'Please enter comment',
                                );
                              } else {
                                var getid = await getUserId();
                                var name = await getNameInfo();

                                noti.postReCommnet(
                                  {
                                    "userId": getid,
                                    "postId": provider.postId,
                                    "comment": filter
                                        .censor(msgController.text.toString()),
                                    "userName": capitalize(name),
                                    "commentId": provider.commentId,
                                  },
                                  provider,
                                  noti,
                                  msgController.text.toString(),
                                );

                                msgController.text = "";
                              }
                            },
                            icon: Icon(
                              Icons.send,
                              size: 30,
                            ))
                      ]),
                    ],
                  ),
                ),
                Positioned(
                    right: 0,
                    top: -13,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(5, 5)),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 3,
                                offset: Offset(-5, -5))
                          ]),
                      child: GestureDetector(
                        child: Icon(
                          Icons.clear,
                          color: Colors.green,
                        ),
                        onTap: () {
                          _provider.setCheckRecomment(
                            false,
                          );
                        },
                      ),
                    )),
              ],
            );
          });
  }
}
