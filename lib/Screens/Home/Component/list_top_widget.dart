import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/post_edit_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/pop_menu_Widget.dart';
import 'package:my_truck_dot_one/Screens/Home/Edit_post_Component/edit_post.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Comman_Alert_box.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import '../Edit_post_Component/edit_post.dart';

class ListTopWidget extends StatelessWidget {
  PostItem item;
  int position;
  HomePageListProvider listProvider;

  ListTopWidget(
      {required this.item, required this.position, required this.listProvider});

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ///original
              Padding(
                padding: EdgeInsets.all(item.type == 'SHARED' ? 8.0 : 0.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) => UserDetailProvider(),
                                  child: UserProfile(
                                    userId: item.userData!.id!,
                                  ),
                                )));
                      },
                      child: CustomImageProfile(
                          image:    IMG_URL + item.userData!.image.toString(),
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
                          SizedBox(
                            height: 6,
                          ),

                          Text(
                            capitalize(  item.userData!.personName.toString(),)
                          ,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.postedAt.toString(),
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 20,
                    ),

                    item.isMyPost == true
                        ?  item.type=="JOIN_GROUP"?

                    PopMenuBar(
                        iconsName: Icons.more_vert,
                        val: 0,
                        userMenuItems: [
                          [AppLocalizations.instance.text("Delete"), 1]

                        ] ,
                        containerDecoration: 3,
                        onDoneFunction: (value) {
                          switch (value) {
                            case 1:
                              postDelete(item.id, context);
                              break;
                          }
                        }):

                    PopMenuBar(
                      iconsName: Icons.more_vert,
                      val: 0,
                            userMenuItems: [
                              [AppLocalizations.instance.text("Edit"), 1],
                              [AppLocalizations.instance.text("Delete"), 2]
                            ] ,
                            containerDecoration: 3,
                            onDoneFunction: (value) {
                              switch (value) {
                                case 1:
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>  ChangeNotifierProvider(
                                              create: (context) =>
                                                  PostEditProvider(),
                                              child: EditPost(item, listProvider,
                                                  item.type.toString(),),
                                            )));

                                  break;
                                case 2:
                                  postDelete(item.id, context);
                                  break;
                              }
                            })
                        : PopMenuBar(
                      iconsName: Icons.more_vert,
                      val: 0,
                            userMenuItems:[
                              [AppLocalizations.instance.text("Report"), 1],
                            ] ,
                            containerDecoration: 3,
                            onDoneFunction: (value) {
                              switch (value) {
                                case 1:
                                  showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          100, 100, 0.0, 0.0),
                                      items: [
                                        const PopupMenuItem(
                                          child: Text("Spam"),
                                          value: 1,
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Violence"),
                                          value: 2,
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Harassment"),
                                          value: 3,
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Inappropriate Content"),
                                          value: 4,
                                        ),
                                        const PopupMenuItem(
                                          child: Text("Other"),
                                          value: 5,
                                        )
                                      ]).then((value) async {
                                    var getid = await getUserId();
                                    switch (value) {
                                      case 1:
                                        listProvider.postReport(
                                          {
                                            'postId': item.id,
                                            'userId': getid,
                                            'reason': 'Spam'
                                          },
                                          position,
                                          listProvider,
                                        );
                                        break;
                                      case 2:
                                        listProvider.postReport({
                                          'postId': item.id,
                                          'userId': getid,
                                          'reason': 'Violence'
                                        }, position, listProvider);
                                        break;
                                      case 3:
                                        listProvider.postReport({
                                          'postId': item.id,
                                          'userId': getid,
                                          'reason': 'Harassment'
                                        }, position, listProvider);
                                        break;
                                      case 4:
                                        listProvider.postReport({
                                          'postId': item.id,
                                          'userId': getid,
                                          'reason': 'Inappropriate Content'
                                        }, position, listProvider);
                                        break;
                                      case 5:
                                        listProvider.postReport({
                                          'postId': item.id,
                                          'userId': getid,
                                          'reason': 'Other'
                                        }, position, listProvider);
                                        break;
                                    }
                                  });
                                  break;
                              }
                            })
                  ],
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.4),
            offset: Offset(-5.0, -5.0),
            blurRadius: 10,
          ),
        ]),
      ),
    );
  }

  void postDelete(String? id, BuildContext context) {
    DialogUtils.showMyDialog(
      context,
      onDoneFunction: () async {
        var getid = await getUserId();

        listProvider.postDelete(
            {"postId": id, "userId": getid},
            position,
            listProvider);
        Navigator.pop(context);
      },
      oncancelFunction: () => Navigator.pop(context),
      title: '${AppLocalizations.instance.text("Delete")}!',
      alertTitle:
      AppLocalizations.instance.text("Delete Post"),
      btnText: "Done",
    );
  }
}

