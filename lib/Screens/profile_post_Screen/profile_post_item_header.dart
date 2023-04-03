import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_post_list_component/Edit_post_list.dart';
import 'package:my_truck_dot_one/Screens/Network/user_post_list_component/edit_post_item.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/UserInfo.dart';
import '../../AppUtils/constants.dart';
import '../Language_Screen/application_localizations.dart';
import '../commanWidget/Comman_Alert_box.dart';
import '../commanWidget/custom_image_network_profile.dart';
import '../commanWidget/pop_menu_Widget.dart';

class PostItemHeaderPart extends StatelessWidget {
  PostDatum provider;
  UserDetailProvider userDetailProvider;
  int position;

  PostItemHeaderPart(this.provider, this.userDetailProvider, this.position,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              child: CustomImageProfile(
                  image: IMG_URL + provider.userData!.image.toString(),
                  width: 50,
                  boxFit: BoxFit.cover,
                  height: 50),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  capitalize(
                    provider.userData!.personName.toString(),
                  ),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  provider.postedAt.toString(),
                  style: TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                )
              ],
            ),
          ],
        )),
        provider.isMyPost == true
            ? provider.type == "JOIN_GROUP"
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
                  DialogUtils.showMyDialog(
                    context,
                    onDoneFunction: () async {
                      var getid = await getUserId();
                      userDetailProvider.postDelete({
                        "postId": provider.id,
                        "userId": getid,
                      }, position);
                      Navigator.pop(context);
                    },
                    oncancelFunction: () => Navigator.pop(context),
                    title: 'Delete',
                    alertTitle: "Delete Post",
                    btnText: "Yes",
                  );
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
                                  builder: (context) => ChangeNotifierProvider(
                                      create: (context) => EditPostProvider(),
                                      child: EditUserPost(
                                        postDatum: provider,
                                        userDetailProvider: userDetailProvider,
                                      ))));

                          break;
                        case 2:
                          DialogUtils.showMyDialog(
                            context,
                            onDoneFunction: () async {
                              var getid = await getUserId();
                              userDetailProvider.postDelete({
                                "postId": provider.id,
                                "userId": getid,
                              }, position);
                              Navigator.pop(context);
                            },
                            oncancelFunction: () => Navigator.pop(context),
                            title: 'Delete',
                            alertTitle: "Delete Post",
                            btnText: "Yes",
                          );
                          break;
                      }
                    },
                    iconsName: Icons.more_vert,
                  )
            :PopMenuBar(
          val: 0,
          userMenuItems: [
            [
        AppLocalizations.instance.text("Report"), 1],
          ],
          containerDecoration: 3,
          onDoneFunction: (value) {
            switch (value) {
              case 1:
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0.0, 0.0),
                    items: [
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text(AppLocalizations.instance.text("Spam"))),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text(AppLocalizations.instance.text("Violence"))),

                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text(AppLocalizations.instance.text(AppLocalizations.instance.text("Harassment"))),

                        value: 3,
                      ),
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text(AppLocalizations.instance.text("Inappropriate Content"))),

                        value: 4,
                      ),
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text(AppLocalizations.instance.text("Other"))),


                        value: 5,
                      )
                    ]).then((value) async {
                  var getid = await getUserId();
                  switch (value) {
                    case 1:
                      userDetailProvider.postReport({
                        'postId': provider.id,
                        'userId': getid,
                        'reason': 'Spam'
                      }, position, userDetailProvider);
                      break;
                    case 2:
                      userDetailProvider.postReport({
                        'postId': provider.id,
                        'userId': getid,
                        'reason': 'Violence'
                      }, position, userDetailProvider);
                      break;
                    case 3:
                      userDetailProvider.postReport({
                        'postId': provider.id,
                        'userId': getid,
                        'reason': 'Harassment'
                      }, position, userDetailProvider);
                      break;
                    case 4:
                      userDetailProvider.postReport({
                        'postId': provider.id,
                        'userId': getid,
                        'reason': 'Inappropriate Content'
                      }, position, userDetailProvider);
                      break;
                    case 5:
                      userDetailProvider.postReport({
                        'postId': provider.id,
                        'userId': getid,
                        'reason': 'Other'
                      }, position, userDetailProvider);
                      break;
                  }
                });
                break;
            }
          },
          iconsName: Icons.more_vert,
        ),
      ],
    );
  }
}
