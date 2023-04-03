import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/ChatModel/ChatGroupViewModel.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/add_group_list_member_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import 'MemberItem.dart';
import 'add_group_member_List.dart';
import 'group_member_List.dart';

class ChatGroupViewLower extends StatelessWidget {
  ChatViewGroupProvider chatViewGroupProvider, proData;

  ChatGroupViewLower(this.chatViewGroupProvider, this.proData);

  int member = 0;

  @override
  Widget build(BuildContext context) {
    chatViewGroupProvider.setList(proData);

    condationTotalMember(proData);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${proData.totalMember.toString()} - Participants"),
            ],
          ),
          Divider(),
          SizedBox(height: 12),
          proData.memberDatumList[0].isAdmin == true
              ? GestureDetector(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.person_add_alt,
                            color: Colors.white,
                          ),
                          backgroundColor: PrimaryColor,
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        Text("Add Participants")
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => AddGroupListMemberProvider(
                                    proData.conversationId),
                                child: AddGroupMemberList()))).then((value) {
                      chatViewGroupProvider.backgroundvisible = 0.0;
                      chatViewGroupProvider.getGroupViewDeatil();
                    });
                  },
                )
              : proData.member == false
                  ? GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.person_add_alt,
                                color: Colors.white,
                              ),
                              backgroundColor: PrimaryColor,
                            ),
                            SizedBox(
                              width: 22,
                            ),
                            Text("Add Participants")
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                    create: (_) => AddGroupListMemberProvider(
                                        proData.conversationId),
                                    child: AddGroupMemberList()))).then(
                            (value) {
                          chatViewGroupProvider.backgroundvisible = 0.0;
                          chatViewGroupProvider.getGroupViewDeatil();
                        });
                      },
                    )
                  : SizedBox(),
          Consumer<ChatViewGroupProvider>(builder: (_, Data, __) {
            if (Data.loder == true) {
              return CircularProgressIndicator();
            }

            if (Data.memberDatumList.length == 0)
              return Center(child: Text('No Record Found'));
            else
              return Container(
                width: double.infinity,
                height: 440,
                child: ListView.builder(
                    itemCount: Data.memberDatumList.length,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ChangeNotifierProvider<MembersDatum>.value(
                          value: Data.memberDatumList[index],
                          child: MemberItem(Data.conversationId, Data, index));
                    }),
              );
          }),
          proData.memberDatumList.length > 5
              ? SizedBox(height: 22)
              : SizedBox(),
          proData.memberDatumList.length > 5
              ? GestureDetector(
                  child: Center(
                      child: Text(
                    "View all (${proData.memberDatumList.length - member} more)",
                    style: TextStyle(
                        color: PrimaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  )),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatGroupMemberList(proData)))
                      ..then((value) {
                        chatViewGroupProvider.backgroundvisible = 0.0;
                        chatViewGroupProvider.getGroupViewDeatil();
                      });
                  },
                )
              : SizedBox(),
        ],
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.white, blurRadius: 5, offset: Offset(-5, -5))
          ]),
    );
  }

  handleClick(
    int item,
    ChatViewGroupProvider proData,
    int index,
  ) {
    print(index);
    proData.memberDatumList.removeAt(index);
    // switch(item)
    // {
    //   case 0:
    //     chatViewGroupProvider.hitRemoveMember(proData ,index);
    // }
  }

  condationTotalMember(ChatViewGroupProvider proData) {
    switch (proData.chatGroupViewModel!.data!.membersData!.length) {
      case 0:
        member = 0;
        break;
      case 1:
        member = 1;
        break;
      case 2:
        member = 2;
        break;
      case 3:
        member = 3;
        break;
      case 4:
        member = 4;
        break;
      case 5:
        member = 5;
        break;
      default:
        {
          member = 5;
        }
    }
  }
}
