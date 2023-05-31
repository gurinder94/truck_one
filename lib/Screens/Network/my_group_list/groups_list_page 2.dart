import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_groups_model.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';

import 'package:provider/provider.dart';

import '../../commanWidget/Search_bar.dart';
import 'Component/group_list_item.dart';
import '../group_create_Post/Provider/create_group_provider.dart';
import '../Provider/my_groups_provider.dart';
import '../add_group/create_group_page.dart';

class GroupsListPage extends StatelessWidget {
  late MyGroupsProvider _provider;
  ScrollController scrollController = new ScrollController();
  int pagee = 1;
  Timer? _debounce;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    _provider = context.read<MyGroupsProvider>();
    _provider.setContext(context);
    _provider.list.clear();
    getGroups('');
    addScrollListener(context);
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text(AppLocalizations.instance.text("Groups")),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => CreateGroupProvider(),
                          child: CreateUpdateGroup(),
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: APP_BAR_BG,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommanSearchBar(onTextChange: (val) {
                if (searchText == '') {
                  searchText = val;
                  pagee = 1;
                  searchText = '';
                }

                if (!_provider.loading) {
                  _provider.reset();
                  getGroups(val);
                } else {}
              }),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              child:
                  Consumer<MyGroupsProvider>(builder: (context, noti, child) {
                if (noti.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (noti.list.length == 0)
                  return Center(
                      child: Text(
                          AppLocalizations.instance.text('No Record Found')));
                else {
                  return noti.loading
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : ListView.builder(
                          itemCount: noti.list.length,
                          controller: scrollController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            MyGroup _group = noti.list[index];
                            return GroupListItem(
                              group: _group,
                              provider: _provider,
                              index: index,
                            );
                          });
                }
              }),
            ),
            Selector<MyGroupsProvider, bool>(
                selector: (_, provider) => provider.paginationLoading,
                builder: (context, paginationLoading, child) {
                  return PaginationWidget(paginationLoading);
                }),
          ],
        ));
  }

  Future<void> getGroups(String value) async {
    var getid = await getUserId();
    Future.delayed(Duration(milliseconds: 100), () {
      _provider.getMyGroups(
          {"userId": getid, "page": 1, "searchText": value}, false);
    });
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();
    _provider.getMyGroups({"userId": getid, "page": pagee}, true);
  }

  addScrollListener(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
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
