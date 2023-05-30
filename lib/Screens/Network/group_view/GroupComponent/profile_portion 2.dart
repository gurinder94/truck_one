import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/option_button.dart';
import 'package:my_truck_dot_one/Screens/Network/group_post_edit_page/group_post_edit.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:provider/provider.dart';
import '../../../commanWidget/Comman_Alert_box.dart';
import '../../../commanWidget/custom_image_network_profile.dart';
import '../../user_profile.dart';
import '../../group_post_edit_page/group_edit_post.dart';

class ProfilePortion extends StatelessWidget {
  String gId;
  int index;
  PostDatum PostItem;
  int reportSecondPop = 0;

  ProfilePortion(this.index, this.gId, this.PostItem);

  late GroupProvider _groupProvider;

  @override
  Widget build(BuildContext context) {
    _groupProvider = context.read<GroupProvider>();
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (context) => UserDetailProvider(),
                      child: UserProfile(
                        userId: PostItem.userData!.id!,
                      ),
                    )));
          },
          child: Container(
            width: 50,
            height: 50,
            child: CustomImageProfile(
                image: IMG_URL + PostItem.userData!.image.toString(),
                width: 50,
                boxFit: BoxFit.cover,
                height: 50),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              PostItem.userData!.personName.toString(),
              style:
                  TextStyle(color: Colors.black.withOpacity(.8), fontSize: 15),
            ),
            Text(
              PostItem.postedAt.toString(),
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.black45),
            ),
          ],
        ),
        Spacer(),
        PostItem.userData!.id == _groupProvider.getId
            ? PopupMenuButton(
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (context) => GroupPostProvider(),
                                child: GroupEditPost(
                                  data: PostItem,
                                  gId: gId,
                                  groupProvider: _groupProvider,
                                )),
                          ));

                      break;

                    case 2:
                      postDelete(PostItem.id, context, _groupProvider.getId,
                          index, _groupProvider, PostItem);
                      break;
                  }
                },
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(AppLocalizations.instance.text("Edit")),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text(AppLocalizations.instance.text("Delete")),
                        value: 2,
                      )
                    ])
            :
        PopMenuBar(
          val: 0,
          userMenuItems: [
            [
              AppLocalizations.instance.text("Report"), 1],
          ],
          containerDecoration: 3,
          onDoneFunction: (value) {
            switch (value) {
              case 1:
                reportSecondPop = 1;
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(100, 100, 0.0, 0.0),
                    items: [
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text("Spam")),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text(
                            AppLocalizations.instance.text("Violence")),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text(
                            AppLocalizations.instance.text("Harassment")),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text(AppLocalizations.instance
                            .text("Inappropriate Content")),
                        value: 4,
                      ),
                      PopupMenuItem(
                        child:
                        Text(AppLocalizations.instance.text("Other")),
                        value: 5,
                      )
                    ]).then((value) async {
                  var getid = await getUserId();
                  switch (value) {
                    case 1:
                      _groupProvider.groupPostReport({
                        'postId': PostItem.id,
                        'userId': getid,
                        'reason': 'Spam'
                      });
                      break;
                    case 2:
                      _groupProvider.groupPostReport({
                        'postId': PostItem.id,
                        'userId': getid,
                        'reason': 'Violence'
                      });

                      break;
                    case 3:
                      _groupProvider.groupPostReport({
                        'postId': PostItem.id,
                        'userId': getid,
                        'reason': 'Harassment'
                      });

                      break;
                    case 4:
                      _groupProvider.groupPostReport({
                        'postId': PostItem.id,
                        'userId': getid,
                        'reason': 'Inappropriate Content'
                      });

                      break;
                    case 5:
                      _groupProvider.groupPostReport({
                        'postId': PostItem.id,
                        'userId': getid,
                        'reason': 'Other'
                      });

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

  void postDelete(
    String? id,
    BuildContext context,
    String? getId,
    int index,
    GroupProvider groupProvider,
    PostDatum data,
  ) {

    DialogUtils.showMyDialog(
      context,
      onDoneFunction: () async {

        _groupProvider.groupPostDelete(
            {"postId": id, "userId": getId.toString()},
            index,
            groupProvider,
            data,
            id!);
      },
      oncancelFunction: () => Navigator.pop(context),
      title: "Delete!",
      alertTitle: "Delete Post",
      btnText: "Done",
    );
  }
}
