import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/MemberItem.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import '../../../Model/ChatModel/ChatGroupViewModel.dart';

class ChatGroupMemberList extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  ChatViewGroupProvider proData;

  ChatGroupMemberList(this.proData);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context, false)),
        title: "Member",
        actions: SizedBox(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Consumer<ChatViewGroupProvider>(builder: (_, Data, __) {
              if (Data.loder == true) {
                return Center(child: CircularProgressIndicator());
              }

              if (Data.memberDatumList.length == 0)
                return Center(child: Text('No Record Found'));
              else
                return Expanded(
                  child: ListView.builder(
                      itemCount: Data.memberDatumList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ChangeNotifierProvider<MembersDatum>.value(
                            value: Data.memberDatumList[index],
                            child: MemberItem(
                                Data.conversationId, Data, index));
                      }),
                );
            })
          ],
        ),
        floatingActionWidget: SizedBox());
  }

  handleClick(int item) {}
}
