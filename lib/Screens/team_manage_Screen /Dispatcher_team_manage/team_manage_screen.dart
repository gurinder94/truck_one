import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import '../../commanWidget/Search_bar.dart';
import '../../commanWidget/SizeConfig.dart';
import '../Provider/manage_team_provider.dart';
import 'manage_team_item.dart';

class TeamManageScreen extends StatelessWidget {
  late ManageTeamProvider _manageTeamProvider;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _manageTeamProvider = context.read<ManageTeamProvider>();


    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 60,
        title: Text(AppLocalizations.instance.text("Manage Team")),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: APP_BAR_BG,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
        ),
      ),
      body: Column(
        children: [
          SizeConfig.screenHeight! < 1010
              ? SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 15
                      : SizeConfig.safeBlockVertical! * 12, //10 for example
                )
              : SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 9
                      : SizeConfig.safeBlockVertical! * 9, //10 for example
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                    child: CommanSearchBar(
                  onTextChange: (val) {
                    Future.delayed(Duration(milliseconds: 500), () {
                      if (!_manageTeamProvider.loading)
                        _manageTeamProvider.hitManageTeam( '', val);
                    });
                  },
                  IconName: PopupMenuButton(
                      elevation: 20,
                      enabled: true,
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      onSelected: (value) {
                        switch (value) {
                          case 1:
                            _manageTeamProvider.hitManageTeam( 'ALL', '');
                            break;
                          case 2:
                            _manageTeamProvider.hitManageTeam(
                              'IDLE', '');
                            break;
                          case 3:
                            _manageTeamProvider.hitManageTeam(
                              'ACTIVE', '');
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("All"),
                              value: 1,
                            ),
                            PopupMenuItem(
                              child: Text("Idle"),
                              value: 2,
                            ),
                            PopupMenuItem(
                              child: Text("Active"),
                              value: 3,
                            ),
                          ]),
                )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Consumer<ManageTeamProvider>(builder: (_, proData, __) {
            if (proData.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (proData.manageTeam.data!.length == 0)
              return Center(
                  child:
                      Text(AppLocalizations.instance.text("No Record Found")));
            else
              return Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: proData.manageTeam.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ManageTeamItem(proData.manageTeam.data![index]);
                    }),
              );
          }),
        ],
      ),
    );
  }
}
