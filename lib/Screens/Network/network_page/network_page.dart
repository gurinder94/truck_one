import 'dart:async';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invitation_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/job_invitation_model.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recommandation_model.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/Component/network_group_item.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/Component/network_item.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/Component/tab.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Search_bar.dart';
import 'Component/Job_invitations_screen.dart';
import '../Provider/invited_connections_provider.dart';
import '../friend_list/my_friends_provider.dart';
import '../Provider/my_groups_provider.dart';
import 'network_provider.dart';
import '../friend_list/friends_list_page.dart';
import '../My_Group_List/groups_list_page.dart';
import 'invite_list_page.dart';

class NetworkPage extends StatefulWidget {
  int i;

  NetworkPage(this.i);

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  late NetworkProvider _provider;
  ScrollController scrollController = ScrollController();
  int pagee = 1;

  String type = "SUGGESTION";
  Timer? _debounce;
  String searchText = '';

  @override
  void initState() {
    _provider = context.read<NetworkProvider>();
    int pagee = 1;
    Future.delayed(Duration(milliseconds: 100), () {
      _provider.setRecommendationTab(widget.i);
      _provider.list.clear();
      getRecommendations('SUGGESTION', searchText);
    });

    _provider.setContext(context);
    _provider.checkrole();
    addScrollListener(context);
  }

  late Function restvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text(AppLocalizations.instance.text("My Network")),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            // AnimSearchBar(
            //   onTextChange: (val) {
            //     if (!_provider.loading) {
            //       searchText = val;
            //       getRecommendations(type, searchText);
            //     }
            //   },
            // ),
            // SizedBox(
            //   width: 20,
            // ),
          ],
        ),
        floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[
            float1(context),
            float2(context),
            // float3(context)
          ],

          colorStartAnimation: APP_BAR_BG,
          colorEndAnimation: APP_BAR_BG,
          animatedIconData: AnimatedIcons.menu_close,
        ),
        body: Consumer<NetworkProvider>(builder: (context, noti, child) {
          return Column(
            children: [

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommanSearchBar(onTextChange: (val) {
                  if (val == '') {

                    pagee=1;
                    _provider.reset();
                    getRecommendations(type, searchText);

                  }
                  if (!_provider.loading) {

                    print(type);
                    searchText = val;
                    getRecommendations(type, searchText);
                  }
                }),
              ),

              SizedBox(
                height: 10,
              ),

              noti.loading == true
                  ? Column(
                      children: [
                        SizedBox(
                          height: 220,
                        ),
                        CircularProgressIndicator(),
                      ],
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTab(
                              title: 'Recommendation',
                              onClick: () {
                                type = 'SUGGESTION';
                                noti.list.clear();
                                noti.groupInfoList.clear();
                                noti.setRecommendationTab(0);
                                getRecommendations('SUGGESTION', searchText);
                              },
                              enable: 0,
                              loading: noti.loading,
                            ),
                            CustomTab(
                              title: ' Invitations ',
                              onClick: () {
                                type = 'Invitations';
                                noti.list.clear();
                                noti.groupInfoList.clear();
                                noti.setRecommendationTab(1);
                                getRecommendations('INVITES', searchText);

                                noti.list.clear();
                              },
                              enable: 1,
                              loading: noti.loading,
                            ),
                            CustomTab(
                              title: 'Group Invitations',
                              onClick: () {
                                type = 'Group Invitations';
                                noti.list.clear();
                                noti.reset();
                                noti.groupInfoList.clear();
                                noti.setRecommendationTab(2);
                                getRecommendations(
                                    'GROUP INVITATION', searchText);
                              },
                              enable: 2,
                              loading: noti.loading,
                            ),
                            noti.getRole == "COMPANY"
                                ? SizedBox()
                                : CustomTab(
                                    title: 'Job Invitations',
                                    onClick: () {
                                      type = 'Job Invitations';
                                      noti.list.clear();
                                      noti.reset();
                                      noti.groupInfoList.clear();
                                      noti.JobInvitationlist.clear();
                                      noti.setRecommendationTab(3);
                                      getRecommendations('Job Invitations', '');
                                    },
                                    enable: 3,
                                    loading: noti.loading,
                                  )
                          ],
                        ),
                      ),
                    ),
              //     :
          //     ChangeNotifierProvider<GroupInfo>.value(
          //     value: noti.groupInfoList[index],
          // child:GroupItem(index),
          // );
              Expanded(
                child: noti.tabEnable == 2
                    ? GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.90,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        children:
                            List.generate(noti.groupInfoList.length, (index) {
                              print(noti.groupInfoList.length);
                          return  ChangeNotifierProvider<GroupInfo>.value(
                                  value: noti.groupInfoList[index],
                              child:GroupItem(index,),
                              );
                        }))
                    : noti.tabEnable == 3
                        ? GridView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.90,
                              // childAspectRatio: (cardWidth/cardHeight)/265),
                            ),
                            itemCount: noti.JobInvitationlist.length,
                            itemBuilder: (BuildContext context, int index) {
                              return  ChangeNotifierProvider<Datum>.value(
                                  value: noti.JobInvitationlist[index],
                                  child: JobInvitationsScreen(
                                      index, noti.JobInvitationlist, ));
                            },
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 300,
                              crossAxisSpacing: 1,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.90,
                              // childAspectRatio: (cardWidth/cardHeight)/265),
                            ),
                            itemCount: noti.list.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ChangeNotifierProvider<PersonInfo>.value(
                                value: noti.list[index],
                                child: NetworkItem(
                                  index,
                                  noti.list,
                                ),
                              );
                            },
                          ),
              ),

              PaginationWidget(noti.paginationLoading),

              SizedBox(
                height: 20,
              ),
            ],
          );
        }));
  }

  Widget float1(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => MyFriendsProvider(),
                        child: FriendsListPage(),
                      )));
        },
        tooltip: 'Friends',
        heroTag: 'one',
        child: Icon(Icons.group),
      ),
    );
  }

  Widget float2(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => MyGroupsProvider(),
                        child: GroupsListPage(),
                      )));
        },
        tooltip: 'Group',
        heroTag: 'two',
        child: Icon(Icons.group_work_outlined),
      ),
    );
  }

  Widget float3(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => InvitedConnectionsProvider(),
                        child: InviteListPage(),
                      )));
        },
        tooltip: 'Invite',
        heroTag: 'three',
        child: Icon(Icons.contact_mail_rounded),
      ),
    );
  }

  Future<void> getRecommendations(
    String type,
    val,
  ) async {
    var getid = await getUserId();

    if (type == "GROUP INVITATION") {

      Future.delayed(Duration(milliseconds: 300), () {
        _provider.reset();
        _provider.getGroupInvitation(
            {"userId": getid, "page": 1, "count": 20, "type": type});
      });
    } else if (type == "SUGGESTION") {
      Future.delayed(Duration(milliseconds: 300), () {
        print(_provider.loading);
        _provider.reset();

        _provider.getRecommendations(
            {"userId": getid, "page": 1, "type": type, "searchText": val},
            false,
            val);
        pagee = 1;
      });
    } else if (type == "INVITES") {
      Future.delayed(Duration(milliseconds: 300), () {
        print(_provider.loading);
        _provider.reset();
        _provider.getRecommendations(
            {"userId": getid, "page": 1, "type": type, "searchText": val},
            false,
            val);
        pagee = 1;
      });
    } else if (type == "Job Invitations") {
      Future.delayed(Duration(milliseconds: 300), () {
        print(_provider.loading);
        _provider.reset();
        _provider.getJobInvitation({
          "userId": getid,
          "page": 1,
        });
        pagee = 1;
      });
    }
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();
    _provider.getRecommendations(
        {"userId": getid, "page": pagee, "type": type, "searchText": ''},
        true,
        '');
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pagee = pagee + 1;
        if (_provider.model.data!.length == 0) {
          showMessage(
            "No Records Found",
          );
        } else {
          pagnationList(context, pagee);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }
}
