import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/invited_connections_model.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/anim_search_bar.dart';
import 'package:provider/provider.dart';
import '../Provider/invited_connections_provider.dart';
import '../Provider/user_detail_provider.dart';

class InviteListPage extends StatelessWidget {
  late InvitedConnectionsProvider _provider;
  int pagee = 1;
  var status = 'accept';
  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    _provider = context.read<InvitedConnectionsProvider>();
    _provider.setContext(context);
    getConnections('', status);

    addScrollListener(context);
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text('Invite Connections',style: TextStyle(fontSize: 18),),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            SizedBox(width: 5,),
            AnimSearchBar(
              onTextChange: (val) {


                if (!_provider.loading) {
                  getConnections(val, status);
                }
              },
            ),
            SizedBox(
              width: 5,
            ),
            PopupMenuButton(
                iconSize: 40,
                onSelected: (value) {
                  switch (value) {
                    case 1:
                      status = "accept";
                      getConnections('', status);
                      break;
                    case 2:
                      status = "pending";

                      getConnections('', 'pending');
                  }
                },
                icon: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFEEEEEE),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: Offset(-5, -5)),
                        BoxShadow(
                            color: APP_BAR_BG,
                            blurRadius: 1,
                            spreadRadius: 2,
                            offset: Offset(5, 5)),
                      ],
                    ),
                    child: RotatedBox(
                      quarterTurns: 45,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black.withOpacity(.5),
                        size: 20,
                      ),
                    )),
                itemBuilder: (context) => [
                      const PopupMenuItem(
                        child: Text("Accepted"),
                        value: 1,
                      ),
                      const PopupMenuItem(
                        child: Text("Pending"),
                        value: 2,
                      )
                    ]),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => ChangeNotifierProvider(
        //                   create: (context) => SendMemInviteProvider(),
        //                   child: InviteFriends(),
        //                 )));
        //   },
        //   child: Icon(Icons.add),
        //   backgroundColor: APP_BAR_BG,
        // ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<InvitedConnectionsProvider>(
                builder: (context, noti, child) {
                  if (noti.list.length == 0)
                    return Center(child: Text('No record found'));
                  return noti.loading
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : ListView.builder(
                          itemCount: noti.list.length,
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            InvitedConnection _connection = noti.list[index];

                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color(0xFFEEEEEE),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(5, 5)),
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 5,
                                        offset: Offset(-5, -5))
                                  ]),
                              child: Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    margin: EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Color(0xFFEEEEEE),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 4,
                                              offset: Offset(5, 5)),
                                          BoxShadow(
                                              color: Colors.white,
                                              blurRadius: 4,
                                              offset: Offset(-5, -5))
                                        ]),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Color(0xFFEEEEEE),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                                offset: Offset(-5, -5)),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 4,
                                                offset: Offset(5, 5))
                                          ]),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChangeNotifierProvider(
                                                        create: (context) =>
                                                            UserDetailProvider(),
                                                        child: UserProfile(
                                                            userId: _connection
                                                                .userId
                                                                .toString()),
                                                      )));
                                        },
                                        child: Image.network(
                                          IMG_URL,
                                          fit: BoxFit.fill,
                                          loadingBuilder:
                                              (context, child, progress) {
                                            return progress == null
                                                ? child
                                                : CircularProgressIndicator
                                                    .adaptive();
                                          },
                                          errorBuilder: (a, b, c) => Center(
                                              child: Text(
                                            _connection.personName!
                                                .substring(0, 1)
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(.2),
                                                fontSize: 50,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      offset: Offset(0, 5),
                                                      blurRadius: 20)
                                                ]),
                                          )),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          _connection.personName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          _connection.email.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        _connection.mobileNumber.toString(),
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [

                                        IconButton(
                                            onPressed: () {
                                              _provider.removeInvite(
                                                  _connection.id!,
                                                  noti.list,
                                                  index);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color:
                                                  Colors.red.withOpacity(.7),
                                            )),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                },
              ),
            ),
            Selector<InvitedConnectionsProvider, bool>(
                selector: (_, provider) => provider.paginationLoading,
                builder: (context, paginationLoading, child) {
                  return PaginationWidget(paginationLoading);
                }),
          ],
        ));
  }

  Future<void> getConnections(val, String status) async {
    var getid = await getUserId();
    _provider.reset();
    Future.delayed(Duration(milliseconds: 100), () {
      _provider.getConnections({
        "userId": getid,
        "searchText": val,
        "status": status,
        "page": 1,
      }, false);
    });
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();
    _provider.getConnections({
      "userId": getid,
      "searchText": '',
      "status": status,
      "page": pagee.toString(),
    }, true);
  }

  addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
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
