import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/Profile_About_Component.dart';
import 'package:provider/provider.dart';
import '../Language_Screen/application_localizations.dart';
import 'Provider/user_detail_provider.dart';
import 'user_post_list_component/user_Post_list_item.dart';

class UserProfile extends StatelessWidget {
  String userId;

  UserProfile({required this.userId});

  late UserDetailProvider _provider;
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _provider = context.read<UserDetailProvider>();
    _provider.setContext(context);
    addScrollListener(context);
    getUserDetail();

    _provider.getfriendId(userId);
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: ChangeNotifierProvider(
          create: (context) => UserDetail(),
          child: Consumer<UserDetailProvider>(
            builder: (context, noti, child) {
              if (noti.loading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (noti.model.data == null)
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              else
                return NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        backgroundColor: APP_BAR_BG,
                        automaticallyImplyLeading: true,
                        leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.pop(context, false)),
                        expandedHeight: 200.0,
                        floating: false,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          title: Text(
                            capitalize(
                              noti.model.data!.personName.toString(),
                            ),
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          // ),
                          background: Container(
                            decoration: BoxDecoration(
                              image: new DecorationImage(
                                image: NetworkImage(
                                    noti.model.data!.bannerImage == null
                                        ? "https://www.google.com"
                                        : profile_banner_url +
                                            noti.model.data!.bannerImage
                                                .toString()),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 10)
                                      ]),
                                  child: Image.network(
                                    IMG_URL + noti.model.data!.image.toString(),
                                    fit: BoxFit.fill,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : CircularProgressIndicator
                                              .adaptive();
                                    },
                                    errorBuilder: (a, b, c) => Center(
                                        child: Text(
                                      noti.model.data!.personName!
                                          .substring(0, 1)
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.2),
                                          fontSize: 80,
                                          shadows: [
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
                      )
                    ];
                  },
                  body: Column(children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
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
                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          // ProfileAbout(_provider),
                          // contactInformation(_provider.model, _provider),

                          _provider.model.data!.roleTitle == "COMPANY"
                              ? SizedBox()
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.work,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${AppLocalizations.instance.text("Working At")} ${_provider.model.data!.workPlace.toString()}",
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    _provider.model.data!.inConnection ==
                                            "MYSELF"
                                        ? SizedBox()
                                        : Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Spacer(),
                                                _provider.model.data!
                                                            .inConnection ==
                                                        "accept"
                                                    //     ? GestureDetector(
                                                    //   onTap: () async {
                                                    //     var getId = await getUserId();
                                                    //     _provider.getInviteDecline(
                                                    //       {
                                                    //         "invitationId":
                                                    //         _provider.friendId,
                                                    //       },
                                                    //     );
                                                    //   },
                                                    //   child: Container(
                                                    //     padding: EdgeInsets.all(10),
                                                    //     decoration: BoxDecoration(
                                                    //         color: APP_BAR_BG,
                                                    //         borderRadius:
                                                    //         BorderRadius.all(
                                                    //             Radius.circular(20))),
                                                    //     child: Text(
                                                    //       'Remove',
                                                    //       style: TextStyle(
                                                    //           color: Colors.white),
                                                    //     ),
                                                    //   ),
                                                    // ) ?
                                                    ? SizedBox()
                                                    : _provider.model.data!
                                                                .inConnection ==
                                                            "false"
                                                        ? GestureDetector(
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      APP_BAR_BG,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                              child: Text(
                                                                AppLocalizations
                                                                    .instance
                                                                    .text(
                                                                        'Connect'),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              var getid =
                                                                  await getUserId();
                                                              var userName =
                                                                  await getNameInfo();
                                                              var userimage =
                                                                  await getprofileInfo();

                                                              _provider
                                                                  .connectUser(
                                                                {
                                                                  "invitedBy":
                                                                      getid,
                                                                  "invitedTo":
                                                                      _provider
                                                                          .model
                                                                          .data!
                                                                          .id,
                                                                  "userId":
                                                                      getid,
                                                                  "userName":
                                                                      userName,
                                                                  "userImage":
                                                                      userimage,
                                                                },
                                                                context,
                                                              );
                                                            },
                                                          )
                                                        : _provider.model.data!
                                                                    .inConnection ==
                                                                "pending"
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(
                                                                              0xFFEEEEEE),
                                                                          shape:
                                                                              BoxShape.circle,
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
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      var getid =
                                                                          await getUserId();
                                                                      var userName =
                                                                          await getNameInfo();
                                                                      var userimage =
                                                                          await getprofileInfo();

                                                                      _provider
                                                                          .getAccept(
                                                                        {
                                                                          "invitationId": _provider
                                                                              .model
                                                                              .data!
                                                                              .invitationId,
                                                                          "userId":
                                                                              getid,
                                                                          "userName":
                                                                              userName,
                                                                          "userImage":
                                                                              userimage,
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  GestureDetector(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Color(0xFFEEEEEE),
                                                                            shape: BoxShape.circle,
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(5, 5)),
                                                                              BoxShadow(color: Colors.white, blurRadius: 3, offset: Offset(-5, -5))
                                                                            ]),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () async {
                                                                        var getid =
                                                                            await getUserId();
                                                                        var userName =
                                                                            await getNameInfo();
                                                                        var userimage =
                                                                            await getprofileInfo();

                                                                        _provider
                                                                            .getInviteDecline(
                                                                          {
                                                                            "invitationId":
                                                                                _provider.model.data!.invitationId.toString(),
                                                                            "userId":
                                                                                getid,
                                                                            "userName":
                                                                                userName,
                                                                            "userImage":
                                                                                userimage,
                                                                          },
                                                                        );
                                                                      }),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                              ],
                                            ),
                                          ),
                                  ],
                                ),

                          _provider.model.data!.roleTitle == "COMPANY"
                              ? SizedBox()
                              : Divider(),

                          _provider.model.data!.roleTitle == "COMPANY"
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      _provider.model.data!.email.toString(),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    _provider.model.data!.inConnection ==
                                            "MYSELF"
                                        ? SizedBox()
                                        : Expanded(
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Spacer(),
                                                _provider.model.data!
                                                            .inConnection ==
                                                        "accept"
                                                    //     ? GestureDetector(
                                                    //   onTap: () async {
                                                    //     var getId = await getUserId();
                                                    //     _provider.getInviteDecline(
                                                    //       {
                                                    //         "invitationId":
                                                    //         _provider.friendId,
                                                    //       },
                                                    //     );
                                                    //   },
                                                    //   child: Container(
                                                    //     padding: EdgeInsets.all(10),
                                                    //     decoration: BoxDecoration(
                                                    //         color: APP_BAR_BG,
                                                    //         borderRadius:
                                                    //         BorderRadius.all(
                                                    //             Radius.circular(20))),
                                                    //     child: Text(
                                                    //       'Remove',
                                                    //       style: TextStyle(
                                                    //           color: Colors.white),
                                                    //     ),
                                                    //   ),
                                                    // ) ?
                                                    ? SizedBox()
                                                    : _provider.model.data!
                                                                .inConnection ==
                                                            "false"
                                                        ? GestureDetector(
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      APP_BAR_BG,
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20))),
                                                              child: Text(
                                                                AppLocalizations
                                                                    .instance
                                                                    .text(
                                                                        "Connect"),
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              var getid =
                                                                  await getUserId();
                                                              var userName =
                                                                  await getNameInfo();
                                                              var userimage =
                                                                  await getprofileInfo();

                                                              _provider
                                                                  .connectUser(
                                                                {
                                                                  "invitedBy":
                                                                      getid,
                                                                  "invitedTo":
                                                                      _provider
                                                                          .model
                                                                          .data!
                                                                          .id,
                                                                  "userId":
                                                                      getid,
                                                                  "userName":
                                                                      userName,
                                                                  "userImage":
                                                                      userimage,
                                                                },
                                                                context,
                                                              );
                                                            },
                                                          )
                                                        : _provider.model.data!
                                                                    .inConnection ==
                                                                "pending"
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  GestureDetector(
                                                                    child:
                                                                        Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(
                                                                              0xFFEEEEEE),
                                                                          shape:
                                                                              BoxShape.circle,
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
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .check,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                    ),
                                                                    onTap:
                                                                        () async {
                                                                      var getid =
                                                                          await getUserId();
                                                                      var userName =
                                                                          await getNameInfo();
                                                                      var userimage =
                                                                          await getprofileInfo();

                                                                      _provider
                                                                          .getAccept(
                                                                        {
                                                                          "invitationId": _provider
                                                                              .model
                                                                              .data!
                                                                              .invitationId,
                                                                          "userId":
                                                                              getid,
                                                                          "userName":
                                                                              userName,
                                                                          "userImage":
                                                                              userimage,
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  GestureDetector(
                                                                      child:
                                                                          Container(
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        alignment:
                                                                            Alignment.center,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Color(0xFFEEEEEE),
                                                                            shape: BoxShape.circle,
                                                                            boxShadow: [
                                                                              BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(5, 5)),
                                                                              BoxShadow(color: Colors.white, blurRadius: 3, offset: Offset(-5, -5))
                                                                            ]),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .cancel_outlined,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                      onTap:
                                                                          () async {
                                                                        var getid =
                                                                            await getUserId();
                                                                        var userName =
                                                                            await getNameInfo();
                                                                        var userimage =
                                                                            await getprofileInfo();

                                                                        _provider
                                                                            .getInviteDecline(
                                                                          {
                                                                            "invitationId":
                                                                                _provider.model.data!.invitationId.toString(),
                                                                            "userId":
                                                                                getid,
                                                                            "userName":
                                                                                userName,
                                                                            "userImage":
                                                                                userimage,
                                                                          },
                                                                        );
                                                                      }),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                ],
                                                              )
                                                            : SizedBox(),
                                              ],
                                            ),
                                          ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.email,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      _provider.model.data!.email.toString(),
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),

                          Divider(),
                          _provider.model.data!.roleTitle == "COMPANY"
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.black87,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${_provider.model.data!.city.toString()}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          _provider.model.data!.roleTitle == "COMPANY"
                              ? Divider()
                              : SizedBox(),

                          ProfileAbout(_provider),
                        ],
                      ),
                    ),
                    Expanded(child:
                        Consumer<UserDetailProvider>(builder: (_, proData, __) {
                      if (proData.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: proData.userPostList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return ChangeNotifierProvider<PostDatum>.value(
                                value: proData.userPostList[index],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: UserPostItem(
                                    position: index,
                                    userDetailProvider: _provider,
                                  ),
                                ));
                          });
                    }))
                  ]),
                );
            },
          ),
        ));
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();

    _provider.getUserDetail(
        {"userId": getid, "friendId": userId, "page": pagee}, true);
  }

  void addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!_provider.paginationLoder) {
          if (_provider.model.data!.postData!.length == 0) {
          } else {
            _provider.pagee = _provider.pagee + 1;
            pagnationList(context, _provider.pagee);
          }
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }

  contactInformation(
      UserDetailModel model, UserDetailProvider userDetailProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                SizedBox(
                  height: 10,
                ),
                model.data!.workPlace == ''
                    ? SizedBox()
                    : Text(
                        "WorkPlace ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.data!.email.toString(),
                ),
                SizedBox(
                  height: 10,
                ),
                model.data!.workPlace == ''
                    ? SizedBox()
                    : Text(model.data!.workPlace.toString()),
              ],
            ),
          ],
        ),
        Divider(
          color: Colors.black.withOpacity(0.4),
        ),
      ],
    );
  }

  Future<void> getUserDetail() async {
    var getid = await getUserId();
    _provider.getUserDetail({"userId": getid, "friendId": userId}, false);
  }
}
