import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../../Model/ChatModel/ChatGroupViewModel.dart';
import '../../commanWidget/custom_image_network_profile.dart';

class MemberItem extends StatelessWidget {
  String conversationId;
  ChatViewGroupProvider proData;
  int index;

  MemberItem(this.conversationId, this.proData, this.index);

  @override
  Widget build(BuildContext context) {
    var data = context.watch<MembersDatum>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            child: CustomImageProfile(
                image: IMG_URL + data.image.toString(),
                width: 100,
                boxFit: BoxFit.contain,
                height: 100),
          ),
          trailing: proData.memberDatumList[0].isAdmin == true
              ? data.isAdmin == true && data.isMyself == true
                  ?PopupMenuButton<int>(
            onSelected: (item) => adminReal(item, data, index,context),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Leave Group')),
            ],
          )
                  : data.isMyself == false && data.isAdmin == false? PopupMenuButton<int>(
                      onSelected: (item) => handleClick(item, data, index,context),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Text('Remove')),
                        PopupMenuItem<int>(
                            value: 1, child: Text('Make as admin')),
                      ],
                    ):PopupMenuButton<int>(
            onSelected: (item) => makeAdmin(item, data, index,context),
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(value: 0, child: Text('Remove')),
                            PopupMenuItem<int>(
                                value: 1, child: Text('Dismiss as admin')),
                          ],
                        )
              : data.isMyself == true
                  ? PopupMenuButton<int>(
                      onSelected: (item) => adminReal(item, data, index,context),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Text('Remove')),
                      ],
                    )
                  : SizedBox(),
          title:
              Text(data.firstName.toString() + ' ' + data.lastName.toString()),
          subtitle: Text(data.isAdmin == true ? 'Admin' : 'Member'),
        ),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 5, offset: Offset(-5, -5))
            ]),
      ),
    );
  }

  handleClick(int item, MembersDatum data, int index, BuildContext context) {
    switch (item) {
      case 0:
        data.hitRemoveMember(data, conversationId, proData, index,false,context);
        break;
      case 1:
        data.hitMakeAdmin(data, conversationId, proData, index, "ADD");
    }
  }

  makeAdmin(int item, MembersDatum data, int index, BuildContext context) {
    switch (item) {
      case 0:
        data.hitRemoveMember(data, conversationId, proData, index,false,context);
        break;
      case 1:
        data.hitMakeAdmin(data, conversationId, proData, index, "REMOVE");
    }
  }

  adminReal(int item, MembersDatum data, int index, BuildContext context) {
    switch (item) {
      case 0:
        data.hitRemoveMember(data, conversationId, proData, index,true,context);
        break;
    }
  }
}

// data.isAdmin==true?data.isMyself==false ?PopupMenuButton<int>(
// onSelected: (item) => adminReal(item,data,index),
// itemBuilder: (context) => [
// PopupMenuItem<int>(value: 0, child: Text('Remove')),
// ],
// ):PopupMenuButton<int>(
// onSelected: (item) => makeAdmin(item,data,index),
// itemBuilder: (context) => [
// PopupMenuItem<int>(value: 0, child: Text('Remove')),
// PopupMenuItem<int>(value: 1, child: Text('Dismiss as admin')),
// ],
// ):PopupMenuButton<int>(
// onSelected: (item) => handleClick(item,data,index),
// itemBuilder: (context) => [
// PopupMenuItem<int>(value: 0, child: Text('Remove')),
// PopupMenuItem<int>(value: 1, child: Text('Make as admin')),
// ],
//),
