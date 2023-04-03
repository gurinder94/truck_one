import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_frinds_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Search_bar.dart';
import 'my_friends_provider.dart';
import '../Provider/user_detail_provider.dart';

class FriendsListPage extends StatelessWidget {
  late MyFriendsProvider _provider;
  ScrollController _scrollController = new ScrollController();
  int pagee = 1;
  Timer? _debounce;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    _provider = context.read<MyFriendsProvider>();
    _provider.setContext(context);
    addScrollListener(context);
    getFriendsList('', 1, false);
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          centerTitle: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text(AppLocalizations.instance.text('My Friends')),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommanSearchBar(onTextChange: (val) {
                if (val == '') {
                  pagee = 1;
                  getFriendsList('', 1, false);
                }
                if (this.searchText != val) {
                  getFriendsList(val, 1, false);
                }
              }),
            ),
            Expanded(
              child: Consumer<MyFriendsProvider>(
                builder: (context, noti, child) {
                  if (noti.loading) {
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (noti.list.length == 0)
                    return Center(
                        child: Text(
                            AppLocalizations.instance.text('No Record Found')));
                  else
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: noti.list.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          MyFriend _friend = noti.list[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChangeNotifierProvider(
                                        create: (context) =>
                                            UserDetailProvider(),
                                        child: UserProfile(
                                          userId: _friend.userId.toString(),
                                        ),
                                      )));
                            },
                            child: Container(
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
                                      child: Image.network(
                                        _friend.image == null
                                            ? ' '
                                            : IMG_URL + _friend.image!,
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
                                          _friend.personName!
                                              .substring(0, 1)
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(.2),
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
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _friend.personName.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18),
                                        ),
                                        // Text(
                                        //   _friend.aboutCompany.toString(),
                                        //   style:
                                        //       TextStyle(fontStyle: FontStyle.italic),
                                        //   softWrap: true,
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        // )
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              DialogUtils.showMyDialog(
                                                context,
                                                onDoneFunction: () async {
                                                  noti.removeMyFriend(
                                                      _friend.id!,
                                                      noti.list,
                                                      index);
                                                },
                                                oncancelFunction: () =>
                                                    Navigator.pop(context),
                                                title: "Remove Connection",
                                                alertTitle:
                                                    "Remove Connection Message",
                                                btnText: "Done",
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                            )),
                                        Text(AppLocalizations.instance
                                            .text('Remove'))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                },
              ),
            ),
            Selector<MyFriendsProvider, bool>(
                selector: (_, provider) => provider.paginationLoading,
                builder: (context, paginationLoading, child) {
                  return PaginationWidget(paginationLoading);
                }),
          ],
        ));
  }

  Future<void> getFriendsList(val, int pagee, bool value) async {
    var getid = await getUserId();
    _provider.reset();

    if (value == false) {
      if (!_provider.loading) {
        Future.delayed(Duration(milliseconds: 100), () {
          _provider.getFriends({
            "userId": getid,
            "searchText": val,
            'page': pagee.toString(),
          }, false);
        });
      }
    } else {}
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();
    _provider.getFriends({
      "userId": getid,
      "searchText": '',
      'page': pagee.toString(),
    }, true);
  }

  addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        pagee = pagee + 1;
        if (_provider.model.data!.length == 0) {
        } else {
          pagnationList(context, pagee);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }
}
