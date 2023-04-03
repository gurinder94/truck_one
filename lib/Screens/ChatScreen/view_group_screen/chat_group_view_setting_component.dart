import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';

class ChatGroupSettingComponent extends StatelessWidget {
  ChatViewGroupProvider chatViewGroupProvider;
  ChatGroupSettingComponent(this.chatViewGroupProvider);



  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewGroupProvider>(builder: (_, proData, __) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Members"),
                Text(
                    proData.totalMember.toString()),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Create Date"),
                Text(formatterDate(
                    proData.chatGroupViewModel!.data!.createdBy!
                        .dateTime)),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Create By"),
                Text(proData.chatGroupViewModel!.data!.createdBy!
                    .firstName.toString() + ' ' +
                    proData.chatGroupViewModel!.data!.createdBy!
                        .lastName.toString()),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Only admins can message"),
                Transform.scale(
                    scale: 1,
                    child: IgnorePointer(
                      ignoring: chatViewGroupProvider.chatGroupViewModel!.data!.membersData![0].isAdmin!?false:true,
                      child: Switch(

                        onChanged:chatViewGroupProvider.setAdminMessage ,
                        value: proData.adminMessage!,
                        activeColor: APP_BG,
                        activeTrackColor: PrimaryColor,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Only admins can edit group Info "),
                Transform.scale(
                    scale: 1,
                    child: IgnorePointer(
                      ignoring: chatViewGroupProvider.chatGroupViewModel!.data!.membersData![0].isAdmin!?false:true,
                      child: Switch(
                        onChanged:chatViewGroupProvider.setEditGroup,
                        value: proData.editGroup!,
                        activeColor: APP_BG,
                        activeTrackColor: PrimaryColor,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Only admins can add/remove members "),
                Transform.scale(
                    scale: 1,
                    child: IgnorePointer(
                       ignoring: chatViewGroupProvider.chatGroupViewModel!.data!.membersData![0].isAdmin!?false:true,
                      child: Switch(
                        onChanged: chatViewGroupProvider.setMember,
                        value: proData.member!,
                        activeColor: APP_BG,
                        activeTrackColor: PrimaryColor,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(),
          ],
        ),
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
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
      );
    }
    );
  }
}
