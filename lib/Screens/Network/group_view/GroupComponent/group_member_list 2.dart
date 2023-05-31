import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_menber_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/anim_search_bar.dart';
import 'package:provider/provider.dart';

import '../../../commanWidget/Search_bar.dart';
import '../../user_profile.dart';

class GroupMemberList extends StatelessWidget {
  String? id;

  GroupMemberList(this.id);

  int pagee = 1;
  late GroupMenberProvider _groupMenberProvider;
  ScrollController _scrollController = new ScrollController();
  Timer? _debounce;
  String searchText = '';
  @override
  Widget build(BuildContext context) {

    _groupMenberProvider = context.read<GroupMenberProvider>();
    _groupMenberProvider.getGroupMemberList(id!, '', false, 1);
    _groupMenberProvider.setContext(context);
    addScrollListener(context);
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text(AppLocalizations.instance.text("Group Members")),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   AnimSearchBar(onTextChange: (val) {
        //     print(val);
        //     if (_debounce?.isActive ?? false) _debounce?.cancel();
        //     _debounce = Timer(const Duration(milliseconds: 500), () {
        //       if (this.searchText != val) {
        //         _groupMenberProvider.resetList();
        //         getConnections(val);
        //       } else {}
        //
        //       this.searchText = val;
        //     });
        //   }),
        // ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommanSearchBar(onTextChange: (val) {
              if (searchText == '') {
                searchText = val;
                pagee = 1;
                searchText = '';
              }

              if (!_groupMenberProvider.loading) {
                _groupMenberProvider.resetList();
                getConnections(val);
              } else {}
              this.searchText = val;
            }),
          ),
          SizedBox(height: 8,),
          Expanded(child:
              Consumer<GroupMenberProvider>(builder: (context, noti, child) {
            if (noti.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (noti.groupMemberListModel == null ||
                noti.MemberList.length == 0)
              return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
            return ListView.builder(
                itemCount: noti.MemberList.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 5))
                        ]),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => UserDetailProvider(),
                              child: UserProfile(
                                userId:  noti.MemberList[index].id.toString(),
                              ),
                            )));
                      },
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
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
                            '',
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, progress) {
                              return progress == null
                                  ? child
                                  : Center(
                                      child: LoadingWidget(((progress
                                                      .cumulativeBytesLoaded /
                                                  progress.expectedTotalBytes!) *
                                              100)
                                          .toInt()));
                            },
                            errorBuilder: (a, b, c) => Center(
                                child: Text(
                              noti.MemberList[index].personName!
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.2),
                                  fontSize: 40,
                                  shadows: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0, 5),
                                        blurRadius: 20)
                                  ]),
                            )),
                          ),
                        ),
                        title:
                            Text(noti.MemberList[index].personName!.toString()),
                        subtitle: Text(
                          noti.MemberList[index].email!.toString(),
                        ),
                        trailing: noti.MemberList[index].role == "owner"
                            ? Text("Admin")
                            : noti.MemberList[index].isMyself == true
                                ? Text("You")
                                : IconButton(
                                    onPressed: () {
                                      _groupMenberProvider.getGroupRemoveMember(
                                          id,
                                          noti.MemberList[index].id,
                                          noti.MemberList[index].role == "owner"
                                              ? "ADMINLEAVE"
                                              : "REMOVEMEMBER",
                                          '',
                                          noti.MemberList[index].invitationId);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    )),
                      ),
                    ),
                  );
                });
          })),
          Selector<GroupMenberProvider, bool>(
              selector: (_, provider) => provider.paginationLoading,
              builder: (context, paginationLoading, child) {
                return PaginationWidget(paginationLoading);
              }),
        ],
      ),
    );
  }

  Future<void> getConnections(val) async {

    var getid = await getUserId();
    _groupMenberProvider.resetList();
    Future.delayed(Duration(milliseconds: 100), () {
      _groupMenberProvider.getGroupMemberList(id!, val, false, 1);
    });
  }

  pagnationList(BuildContext context, int pagee) async {
    _groupMenberProvider.getGroupMemberList(id!, '', true, pagee);
  }

  addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        pagee = pagee + 1;
        if (_groupMenberProvider.groupMemberListModel!.data!.length == 0) {
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
