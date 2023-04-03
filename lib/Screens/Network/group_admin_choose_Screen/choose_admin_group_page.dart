import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/GroupMenberListModel.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Search_bar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_button_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/anim_search_bar.dart';
import 'package:provider/provider.dart';

import '../Provider/group_menber_provider.dart';

class ChooseAdmin extends StatefulWidget {
  String? gID;
  String? invitationId;
  String? s;

  ChooseAdmin(this.gID, this.invitationId, this.s);

  @override
  _ChooseAdminState createState() => _ChooseAdminState(gID, invitationId, s);
}

class _ChooseAdminState extends State<ChooseAdmin> {
  int _radioValue = 0;
  String? gID;
  String? invitationId;
  String? s;
  String? InId;
  int grouptotal = 0;

  _ChooseAdminState(this.gID, this.invitationId, this.s);

  late GroupMenberProvider _groupMenberProvider;
String searchText='';
int page=1;
  @override
  void initState() {
    // TODO: implement initState
    _groupMenberProvider =
        Provider.of<GroupMenberProvider>(context, listen: false);
    print(gID);
    _groupMenberProvider.getGroupMemberList(gID!, '', false, 1);
  }

  @override
  Widget build(BuildContext context) {
    var p = context.watch<GroupMenberProvider>();
    _groupMenberProvider.setContext(context);

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: APP_BAR_BG,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        title: Text('Choose group admin'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // AnimSearchBar(
          //   onTextChange: (val) {},
          // ),
          // SizedBox(
          //   width: 30,
          // ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 20,),
        // Padding(
        //   padding: EdgeInsets.all(10),
        //   child: CommanSearchBar(onTextChange: (val) {
        //     if (searchText == '') {
        //       searchText = val;
        //       page = 1;
        //     }
        //
        //     if (!_groupMenberProvider.loading) {
        //
        //     }
        //   }),
        // ),

          Expanded(child:
              Consumer<GroupMenberProvider>(builder: (context, noti, child) {
            if (noti.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (noti.groupMemberListModel == null ||
                noti.MemberList.length == 0)
              return Center(child: Text(AppLocalizations.instance.text('No Record Found')));
            return ListView.builder(
                itemCount: noti.MemberList.length,
                itemBuilder: (context, index) {
                  grouptotal = noti.MemberList.length;

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
                      child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(5, 5)),
                                ]),
                            child: Image.network(
                            IMG_URL + noti.MemberList[index].image.toString(),
                              fit: BoxFit.fill,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : Center(
                                        child: LoadingWidget(((progress
                                                        .cumulativeBytesLoaded /
                                                    progress
                                                        .expectedTotalBytes!) *
                                                100)
                                            .toInt()));
                              },
                              errorBuilder: (a, b, c) => Center(
                                  child: Text(
                                noti.MemberList[index].personName!
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.2),
                                    fontSize: 40,
                                    shadows: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(0, 5),
                                          blurRadius: 20)
                                    ]),
                              )),
                            ),
                          ),
                          title: Text(
                              noti.MemberList[index].personName!.toString()),
                          subtitle: Text(
                            noti.MemberList[index].email!.toString(),
                          ),
                          trailing: noti.MemberList[index].role == "owner"
                              ? Text(AppLocalizations.instance.text('Owner'))
                              : noti.MemberList[index].isMyself == true
                                  ? Text(AppLocalizations.instance.text('You'))
                                  : Radio(
                                      value: index,
                                      groupValue: _radioValue,
                                      onChanged: (value) {
                                        print(value);
                                        _handleRadioValueChange(value, index,
                                            noti.groupMemberListModel);
                                      })));
                });
          })),
          p.loading == true
              ? SizedBox()
              : p.groupMemberListModel!.totalCount! > 1
                  ? CommanButtonWidget(
                    title: AppLocalizations.instance.text('Choose Admin'), loder: false ,
                    buttonColor: PrimaryColor,
                    onDoneFuction: ()
                    {
                      _groupMenberProvider.getGroupRemoveAdmin(
                        gID,
                        invitationId,
                        s,
                        InId == null
                            ? _groupMenberProvider
                            .groupMemberListModel!.data![0].id
                            : InId,
                      );
                    },
                    titleColor: Colors.white,
                  )
                           : SizedBox(),

          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void _handleRadioValueChange(
      var value, int index, GroupMemberListModel? groupMemberListModel) {
    setState(() {
      _radioValue = value;

      InId = groupMemberListModel!.data![index].id;
    });
  }
}
