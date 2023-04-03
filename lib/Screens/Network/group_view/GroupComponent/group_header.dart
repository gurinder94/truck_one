import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Network/group_post_edit_page/edit_group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/group_invite_member/invite_group_member_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/edit_group/edit_group_page.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/post_options.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/GroupComponent/profile_portion.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/view_group.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../../../Home/Component/description_txt.dart';
import '../../Group_share_post/Provider/Group_share_provider.dart';
import '../../Group_share_post/group_post_share.dart';
import '../../group_invite_member/invite_member_group.dart';
import '../Group_Post_list_component/group_post_item.dart';
import '../group_like_Animation.dart';
import 'description_portion.dart';
import 'media_portion.dart';

class GroupHeader extends StatelessWidget {
  ScrollController scrollController;
  late GroupProvider _provider;
String gId;

Widget aboutWidget,createPostWidget,PaginationLoader;
  GroupHeader(this.gId,{required this.aboutWidget,required this.createPostWidget,required this.scrollController,required this.PaginationLoader});
  @override
  Widget build(BuildContext context) {

    _provider = context.read<GroupProvider>();

    return     Selector<GroupProvider, Data>(
        selector: (_, provider) => provider.model.data!,
        builder: (context, model, child) {
          return CustomScrollView(
          controller:_provider.scrollController ,
              slivers: <Widget>[
                //2
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: true,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context, false)),
                  expandedHeight: 200.0,

                  actions: [

                    model != null ?model.isMember==true
                        ? model.isAdmin!
                        ? PopupMenuButton(
                        onSelected: (val) {
                          switch (val) {
                            case 1:
                              openEditScreen(context);

                              break;
                            case 2:
                              Navigator.push(
                                  navigatorKey.currentState!.context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          create: (_) =>
                                              InviteGroupMemberProv(),
                                          child: InviteMemeberGroup(
                                              _provider.model.data!.id,_provider.model.data!.name.toString()),
                                        ),
                                  )).then((value)
                              {
                                Navigator.pushReplacement(
                                    navigatorKey.currentState!.context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider(
                                          create: (context) => GroupProvider(),
                                          child: ViewGroup(
                                            gId: gId,
                                          ),
                                        )));
                              });

                              break;
                            case 3:  Navigator.push(
                                navigatorKey.currentState!.context,
                                MaterialPageRoute(
                                builder: (context) =>
                                ChangeNotifierProvider(create: (_) => GroupShareProvider(),
                                  child: GroupPostShare(
                                      _provider.model.data!.name.toString(),
                                      _provider.model.data!.groupImage
                                          .toString(),
                                      _provider.model.data!.totalMembers
                                          .toString(), _provider),
                                )
                          )).then((value) => Navigator.pushReplacement(
                                navigatorKey.currentState!.context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider(
                                      create: (context) => GroupProvider(),
                                      child: ViewGroup(
                                        gId: gId,
                                      ),
                                    ))));

                          }
                        },
                        itemBuilder: (context) =>
                        [
                           PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Edit")),
                            value: 1,
                          ),
                           PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Invite")),
                            value: 2,
                          ),
                           PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Share Group")),
                            value: 3,
                          )
                        ])
                        : model.type=="Public"?PopupMenuButton(
                        onSelected: (val) {
                          switch (val) {


                            case 2:
                              Navigator.push(
                                  navigatorKey.currentState!.context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                          create: (_) =>
                                              InviteGroupMemberProv(),
                                          child: InviteMemeberGroup(
                                              _provider.model.data!.id,_provider.model.data!.name.toString()),
                                        ),
                                  )).then((value)
                              {
                                Navigator.pushReplacement(
                                    navigatorKey.currentState!.context,
                                    MaterialPageRoute(
                                        builder: (context) => ChangeNotifierProvider(
                                          create: (context) => GroupProvider(),
                                          child: ViewGroup(
                                            gId: gId,
                                          ),
                                        )));
                              });

                              break;
                            case 3:  Navigator.push(
                                navigatorKey.currentState!.context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(create: (_) => GroupShareProvider(),
                                          child: GroupPostShare(
                                              _provider.model.data!.name.toString(),
                                              _provider.model.data!.groupImage
                                                  .toString(),
                                              _provider.model.data!.totalMembers
                                                  .toString(), _provider),
                                        )
                                )).then((value) => Navigator.pushReplacement(
                                navigatorKey.currentState!.context,
                                MaterialPageRoute(
                                    builder: (context) => ChangeNotifierProvider(
                                      create: (context) => GroupProvider(),
                                      child: ViewGroup(
                                        gId: gId,
                                      ),
                                    ))));

                          }
                        },
                        itemBuilder: (context) =>
                        [

                          PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Invite")),
                            value: 2,
                          ),
                          PopupMenuItem(
                            child: Text(AppLocalizations.instance.text("Share Group")),
                            value: 3,
                          )
                        ]):SizedBox()
                        : SizedBox():SizedBox(),


                  ],


                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      model == null
                          ? ''
                          : model.name.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),

                    background: Container(
                      decoration: BoxDecoration(

                          image: model.coverImage==null
                              ? DecorationImage(
                              image: AssetImage('icons/productimage.png'),
                              fit: BoxFit.cover):DecorationImage(
                              image:
                                   NetworkImage(

                                Base_Url_group +
                                    model.coverImage
                                        .toString(),
                              ),
                              fit: BoxFit.cover)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                            child: Container(
                              color: Colors.black.withOpacity(.1),
                            ),
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(5, 5)),
                                ]),
                            child: Image.network(
                              model.groupImage == '' ? '' :
                              Base_Url_group +
                                  model.groupImage.toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : CircularProgressIndicator.adaptive();
                              },
                              errorBuilder: (a, b, c) =>
                                  Center(
                                      child: Text(
                                        model.name
                                            .toString()
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black.withOpacity(.2),
                                            fontSize: 80,
                                            shadows: const [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  offset: Offset(0, 5),
                                                  blurRadius: 20)
                                            ]),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),

                ),

                SliverToBoxAdapter(
            child: aboutWidget
          ),
                SliverToBoxAdapter(
                    child: createPostWidget
                ),

                // Selector<GroupProvider, bool>(
                //     selector: (_, provider) => provider.paginationLoading,
                //     builder: (context, paginationLoading, child) {
                //       return PaginationWidget(paginationLoading);
                //     }),





    Consumer<GroupProvider>(
    builder: (context, noti, child) {
      return
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (_, int index) {

              return
                ChangeNotifierProvider<PostDatum>.value(
                  value: noti.list[index],
                  // child: Padding(
                  //   padding: const EdgeInsets.only(bottom: 25),
                  //   child: Container(
                  //     margin: EdgeInsets.all(10),
                  //     padding: EdgeInsets.all(10),
                  //     decoration: const BoxDecoration(
                  //         color: Color(0xFFEEEEEE),
                  //         borderRadius: BorderRadius.all(Radius.circular(10)),
                  //         boxShadow: [
                  //           BoxShadow(
                  //               color: Colors.black12,
                  //               blurRadius: 5,
                  //               offset: Offset(5, 5)),
                  //           BoxShadow(
                  //               color: Colors.white,
                  //               blurRadius: 5,
                  //               offset: Offset(-5, -5))
                  //         ]),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //
                  //        ProfilePortion( index, gId),
                  //         DescriptionTxt(
                  //           description: noti.list[index].caption.toString(),
                  //           isShared: noti.list[index].type == 'SHARED' ? true : false,
                  //         ),
                  //
                  //         noti.list[index].media!.length == 0
                  //             ? SizedBox()
                  //             : MediaPortion(),
                  //         SizedBox(
                  //           height: 20,
                  //         ),
                  //         PostOptions(),
                  //         SizedBox(
                  //           height: 10,
                  //         ),
                  //         GroupLikeAnimationComponent(),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  child:GroupPostItem(index, gId,_provider)
,
                );
            },
            childCount: noti.list.length,
          ),
        );
    }
        ),

                SliverToBoxAdapter(
                  child:PaginationLoader,
                ),
      ],
    );


        }

    );
  }
  openEditScreen(BuildContext context) {
    Navigator.push(
       navigatorKey.currentState!.context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => EditGroupProvider(),
              child: EditGroupPage(_provider.model.data!.id)),
        )).then((value) => Navigator.pushReplacement(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => GroupProvider(),
              child: ViewGroup(
                gId: gId,
              ),
            ))));
  }


}
