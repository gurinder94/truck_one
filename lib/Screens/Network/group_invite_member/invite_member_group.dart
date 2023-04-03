import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invite_menber_model.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/anim_search_bar.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/comman_button_widget.dart';
import 'Component/Invite_menber_item.dart';
import 'invite_group_member_provider.dart';

class InviteMemeberGroup extends StatefulWidget {
  String? id;
  String ?groupName;
  InviteMemeberGroup(this.id, this.groupName);

  @override
  _InviteMemeberGroupState createState() => _InviteMemeberGroupState(id);
}

class _InviteMemeberGroupState extends State<InviteMemeberGroup> {
  late InviteGroupMemberProv _inviteGroupMemberProv;
  String? id;
  ScrollController _scrollController = new ScrollController();

  _InviteMemeberGroupState(this.id);

  int pagee = 1;
  int count = 0;
  Timer? _debounce;
  String searchText = '';

  @override
  void initState() {
    _inviteGroupMemberProv = context.read<InviteGroupMemberProv>();
    _inviteGroupMemberProv.inviteMenber.clear();
    _inviteGroupMemberProv.getGroupInviteMenber(
      id,
      '',
      false,
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    addScrollListener(context);
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text(AppLocalizations.instance.text('Invite Members')),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CommanSearchBar(onTextChange: (val) {

              if (searchText == '') {
                searchText = val;
                pagee = 1;
                searchText = '';
              }

           if (!_inviteGroupMemberProv.loading) {
                _inviteGroupMemberProv.reset();
                _inviteGroupMemberProv.getGroupInviteMenber(id, val, false, 1);
              }
            }),
          ),
          Expanded(
            child: Consumer<InviteGroupMemberProv>(
                builder: (context, noti, child) {
              if (noti.loading) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (noti.inviteMenber.length == 0)
                return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
              else
                return ListView.builder(
                  itemCount: noti.inviteMenber.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5))
                            ]),
                        child: ChangeNotifierProvider<Datum>.value(
                            value: noti.inviteMenber[index],
                            child: InviteMenberItem()));
                  },
                );
            }),
          ),
          Selector<InviteGroupMemberProv, bool>(
              selector: (_, provider) => provider.paginationLoading,
              builder: (context, paginationLoading, child) {
                return PaginationWidget(paginationLoading);
              }),
        Selector<InviteGroupMemberProv, int>(
            selector: (_, provider) => provider.count,
            builder: (context, paginationLoading, child) {
              return
                CommanButtonWidget(
                  title:  '${AppLocalizations.instance.text('Invite')} ($paginationLoading)',
                  buttonColor: PrimaryColor,
                  titleColor: APP_BG,
                  onDoneFuction: () async {
                    if (paginationLoading == 0)
                      showMessage("Please select atleast one member ");
                    else {
                      _inviteGroupMemberProv.postGroupInviteMenber(id, context,widget.groupName);
                    }
                  },
                  loder: false,
                );
            })

        ],
      ),
    );
  }

  pagnationList(BuildContext context, int pagee) async {
    var getid = await getUserId();

    _inviteGroupMemberProv.getGroupInviteMenber(id, '', true, pagee);
  }

  addScrollListener(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {

        if (_inviteGroupMemberProv.groupInviteMenberModel!.data!.length == 0) {

        } else {
          pagee = pagee + 1;
          pagnationList(context, pagee);
        }
        // Perform event when user reach at the end of list (e.g. do Api call)

      }
    });
  }
}
