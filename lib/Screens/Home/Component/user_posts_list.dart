import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';

import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/post_create_component/PostItemWidget.dart';
import 'package:my_truck_dot_one/commonUI/loading_shimmer.dart';
import 'package:provider/provider.dart';

import '../../NotificationScreen/Provider/notificationProvider.dart';



class UserPostList extends StatefulWidget {
  @override
  State<UserPostList> createState() => _UserPostListState();
}

class _UserPostListState extends State<UserPostList> {
  late HomePageListProvider _listProvider;

  late NotificationProvider _notificationProvider;

  ScrollController _scrollController = ScrollController();

  int _page = 1;

  @override
  void initState() {

    // TODO: implement initState
    _listProvider = context.read<HomePageListProvider>();
    _notificationProvider = context.read<NotificationProvider>();
    _notificationProvider.hitNotificationCount(context);
    _listProvider.resetBookings();
    _listProvider.setContext(context);
    _listProvider.getUserDetail();

    getPosts(context, false);
    addScrollListener(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<HomePageListProvider>(builder: (context, data, child) {
      return data.loading
          ? SizedBox(
          height: MediaQuery.of(context).size.height-190,
          child: dashBoardPostLoading())
          : data.list.length == 0
              ? Center(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text('No Post Found!!')))
              : Expanded(
                  child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: data.list.length,
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (context, i) {
                        return ChangeNotifierProvider<PostItem>.value(
                            value: data.list[i],
                            child: MyPostItemWidget(_listProvider, i));
                      }),
                ));
    });
  }

  getPosts(BuildContext context, bool pagination) async {
    var getid = await getUserId();

    _listProvider.getPosts({
      "userId": getid,
      "count": 10,
      "page": _page,
    }, pagination);
  }

  Future<void> _refresh() async {
    var getid = await getUserId();
    _listProvider.resetBookings();

    return _listProvider.getPosts({
      "userId": getid,
      "count": 10,
      "page": 1,
    }, false);
  }

  void addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!_listProvider.loading) {
          _page = _page + 1;
          getPosts(context, true);
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
  }
}
