import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/add_group_list_member_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import '../../../Model/ChatModel/GroupViewAddMemberList.dart';
import 'add_AddMember_item.dart';

class AddGroupMemberList extends StatelessWidget {
  late AddGroupListMemberProvider _addGroupListMemberProvider;

  @override
  Widget build(BuildContext context) {
    _addGroupListMemberProvider = context.read<AddGroupListMemberProvider>();
    _addGroupListMemberProvider.groupAddMember(context);
    _addGroupListMemberProvider.AddMemberList = [];
    return  CustomAppBarWidget(
      title: 'Add Participants',
      actions: SizedBox(),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);


        },
      ),
      floatingActionWidget: SizedBox(),
      child: Consumer<AddGroupListMemberProvider>(builder: (_, proData, __) {
          if (proData.loder) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (proData.AddMemberList.length == 0)
            return Center(child: Text('No Record Found'));
          return Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: proData.AddMemberList.length,
                    padding: EdgeInsets.zero,

                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider<Datum>.value(
                          value: proData.AddMemberList[index],
                          child: GroupMemberItem(proData, index));



                    }),
              ),
            ],
          );
        }),

    );
  }
}
