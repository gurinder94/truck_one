import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/add_group_list_member_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../../Model/ChatModel/GroupViewAddMemberList.dart';
import '../../commanWidget/custom_image_network_profile.dart';

class GroupMemberItem extends StatelessWidget {
  AddGroupListMemberProvider addGroupListMemberProvider;
  int index;
   GroupMemberItem(this.addGroupListMemberProvider, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data =context.watch<Datum>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            child: CustomImageProfile(
                image: IMG_URL +
                    data
                        .toString(),


                width: 100,
                boxFit: BoxFit.cover,
                height: 100),
          ),
          trailing:data.alreadyExist==true?SizedBox():
          Selector<  AddGroupListMemberProvider, bool>(
              selector: (_, provider) => provider.groupMenber,
              builder: (context, paginationLoading, child) {
                return  GestureDetector(
                  onTap: () {

                    paginationLoading==true?SizedBox():  addGroupListMemberProvider.addMember(
                        context,
                        data.userId
                            .toString(),addGroupListMemberProvider, index);
                  },
                  child: Container(
                    width: 70,
                    height: 40,
                    child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )),
                    decoration: BoxDecoration(
                        color: PrimaryColor,
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 3,
                              offset: Offset(5, 5)),
                          BoxShadow(
                              color: Colors.white,
                              blurRadius: 3,
                              offset: Offset(-5, -5))
                        ]),
                  ),
                );
              }),
          title: Text(data.firstName
              .toString() +
              data.lastName.toString()),
          subtitle: data.alreadyExist==true?Text("In group"):SizedBox(),
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
    );
  }
}
