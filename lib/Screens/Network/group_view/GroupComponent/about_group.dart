import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_menber_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/my_groups_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/group_invite_member/invite_group_member_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';

import '../../group_invite_member/invite_member_group.dart';
import '../../my_group_list/groups_list_page.dart';
import 'group_member_list.dart';

class AboutGroup extends StatelessWidget {
  late GroupProvider _provider;
  String isMember;
  String? firstHalf;
  String? secondHalf;
  String gId;

  AboutGroup(this.isMember, this.gId);

  @override
  Widget build(BuildContext context) {
    _provider = context.watch<GroupProvider>();
    var provider = context.read<GroupProvider>();
    checkDescriptionLength(_provider);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.white, blurRadius: 5, offset: Offset(-5, -5))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  isMember == "false"
                      ? SizedBox()
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeNotifierProvider(
                                  create: (context) => GroupMenberProvider(),
                                  child: GroupMemberList(
                                      _provider.model.data!.id.toString())))).then((value)
                  {
                    Navigator.pushReplacement(
                        navigatorKey.currentState!.context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                              create: (context) => MyGroupsProvider(),
                              child: GroupsListPage(),
                            )));

                  });
                },
                // child: Text(
                //   '${_provider.model.data == null ? 0 : _provider.model.data!.totalMembers} ${AppLocalizations.instance.text('Members')}',
                //   style: TextStyle(color: Colors.black54),
                // ),
                child: CommonRichText(
                  richText1: AppLocalizations.instance.text('Members') + ' : ',
                  style1: TextStyle(
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.black,
                      fontSize: 13),
                  richText2: _provider.model.data == null
                      ? '0'
                      : _provider.model.data!.totalMembers.toString(),
                  style2:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),
              Spacer(),
              SizedBox(
                height: 10,
              ),
              CondationButton(_provider.model.data!, context, provider),

            ],
          ),

          CommonRichText(
            richText1: AppLocalizations.instance.text('groupType') + ' : ',
            style1: TextStyle(
                fontWeight: FontWeight.w500,
                height: 1.4,
                color: Colors.black,
                fontSize: 13),
            richText2: _provider.model.data!.type!,
            style2: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.instance.text("About"),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),

          // Text(
          //   '${_provider.model.data == null ? '' : _provider.model.data!.description}',
          //   maxLines: 4,
          //   softWrap: true,
          //   overflow: TextOverflow.ellipsis,
          //   style: TextStyle(fontStyle: FontStyle.italic),
          // ),
          Container(
            padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: secondHalf!.isEmpty
                ? new Text(firstHalf!)
                : new Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,

                    children: <Widget>[
                      new Text(
                          _provider.flag
                              ? (firstHalf! + "...")
                              : (firstHalf! + secondHalf!),
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      new InkWell(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new Text(
                              _provider.flag ? "show more" : "show less",
                              style: new TextStyle(color: PrimaryColor),
                            ),
                          ],
                        ),
                        onTap: () {
                          _provider.flag == true
                              ? provider.checkDescription(false)
                              : provider.checkDescription(true);
                        },
                      ),
                    ],
                  ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  checkDescriptionLength(GroupProvider provider) {
    if (provider.model.data!.description!.length > 80) {
      firstHalf = provider.model.data!.description!.substring(0, 70);
      secondHalf = provider.model.data!.description!
          .substring(50, provider.model.data!.description!.length);
    } else {
      firstHalf = provider.model.data!.description!;
      secondHalf = "";
    }
  }

  CondationButton(Data data, BuildContext context, GroupProvider provider) {
    print(data.status);
    switch (data.status) {
      case 'REQUESTED':
        if (data.type == "Private")
          return RequestButtonPrivateGroup(context, provider);
        break;

      case 'JOIN':
        if (data.type == "Private")
          return RequestButtonJoinPrivateGroup(context, provider);
        else
          return RequestButtonJoinPublicGroup(context, provider);

      case 'ACCEPT_DECLINE':
        return RequestAcceptAndDeclineButton(context, provider, data);
      default:
        return SizedBox();
    }
  }

  RequestButtonPrivateGroup(BuildContext context, GroupProvider provider) {
    return Row(
      children: [
        // Container(
        //     padding: EdgeInsets.only(
        //   left: 20, right: 20, top: 10, bottom: 10),
        //     decoration: BoxDecoration(
        //   boxShadow: const [
        //     BoxShadow(
        //         color: Colors.black26,
        //         blurRadius: 3,
        //         offset: Offset(5, 5)),
        //     BoxShadow(
        //         color: Colors.white,
        //         blurRadius: 3,
        //         offset: Offset(-5, -5))
        //   ],
        //   color: APP_BAR_BG,
        //   borderRadius:
        //   BorderRadius.all(Radius.circular(20))),
        //     child: Text(
        // 'Request',
        // style: TextStyle(color: Colors.white),
        //     ),
        //   ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () async {
            var getId = await getUserId();
            provider.hitgroupAction({
              "action": "DECLINE",
              "groupId": gId,
              "loggedInUserId": getId,
              "userId": getId,
              "invitedBy": _provider.model.data!.invitedBy
            });
            _provider.changeNamebutton("JOIN");
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      offset: Offset(5, 5)),
                  BoxShadow(
                      color: Colors.white,
                      blurRadius: 3,
                      offset: Offset(-5, -5))
                ],
                color: APP_BAR_BG,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text(
              AppLocalizations.instance.text("Cancel"),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  RequestButtonJoinPrivateGroup(BuildContext context, GroupProvider provider) {
    return GestureDetector(
      onTap: () async {
        var getid = await getUserId();
        provider.hitgroupPrivateRequest(
          {
            "groupId": gId,
            "userId": getid,
          },
        );
        provider.changeNamebutton("REQUESTED");
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 3, offset: Offset(-5, -5))
            ],
            color: APP_BAR_BG,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          AppLocalizations.instance.text("Request to Join"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  RequestButtonJoinPublicGroup(BuildContext context, GroupProvider provider) {
    return GestureDetector(
      onTap: () async {
        var getid = await getUserId();
        provider.hitGroupJoin(
          {
            "groupId": gId,
            "userId": getid,
          },
        );

        provider.changeNamebutton("LEAVE");
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 3, offset: Offset(-5, -5))
            ],
            color: APP_BAR_BG,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          AppLocalizations.instance.text("Join Group'"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  RequestAcceptAndDeclineButton(
      BuildContext context, GroupProvider provider, Data data) {
    return Row(
      children: [
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                shape: BoxShape.circle,
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
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
          onTap: () async {
            var getId = await getUserId();
            var userName = await getNameInfo();
            var image = await getprofileInfo();

            provider.getInviteAccept({
              "invitationId": data.invitationId,
              "userName": userName,
              "userImage": image,
              "userId": getId,
              "invitedBy": _provider.model.data!.invitedBy
            });

            provider.changeNamebutton("LEAVE");
          },
        ),
        SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                shape: BoxShape.circle,
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
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
          ),
          onTap: () async {
            var getId = await getUserId();
            var userName = await getNameInfo();
            var image = await getprofileInfo();
            provider.getInviteDecline({
              "invitationId": data.invitationId,
              "userName": userName,
              "userImage": image,
              "userId": getId,
              "invitedBy": _provider.model.data!.invitedBy
            });
            provider.changeNamebutton("JOIN");
          },
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  InvitationSend(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (_) => InviteGroupMemberProv(),
                child: InviteMemeberGroup(_provider.model.data!.id,
                    _provider.model.data!.name.toString()),
              ),
            )).then((value) {

        });
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 3, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 3, offset: Offset(-5, -5))
            ],
            color: APP_BAR_BG,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          AppLocalizations.instance.text("Invite"),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
