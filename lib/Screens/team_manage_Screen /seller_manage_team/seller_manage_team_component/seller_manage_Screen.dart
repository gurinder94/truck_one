import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import '../../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../../commanWidget/Search_bar.dart';
import '../../../commanWidget/comman_bottom_sheet.dart';
import '../Provider/seller_manage_team_Provider.dart';
import 'seller_fliter_mange_team.dart';
import 'Seller_manager_Team_list.dart';

class SellerManageScreen extends StatelessWidget {
  late SellerManageTeamProvider _manageTeamProvider;

  String searchText = '';

  @override
  Widget build(BuildContext context) {
    _manageTeamProvider = context.read<SellerManageTeamProvider>();
    _manageTeamProvider.resetSellerManageList();
    _manageTeamProvider.resetFilterValue();
    _manageTeamProvider.hitManageTeam(context, '', '');
    return CustomAppBarWidget(
        title:AppLocalizations.instance.text('Manage Team') ,
        leading: SizedBox(),
        floatingActionWidget: SizedBox(),

        actions:SizedBox(),
        child: Column(
          children: [
            SizedBox(
              height: 110,
            ),    Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [

                  Expanded(
                    child: CommanSearchBar(onTextChange: (val) {
                      if (searchText == '') {
                        searchText = val;
                      }

                      if (!_manageTeamProvider.loading) {
                        _manageTeamProvider.resetSellerManageList();
                        _manageTeamProvider.hitManageTeam(context, '', val);
                      }
                    },
                    IconName:   GestureDetector(
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                      onTap: ()
                      {
                        CommanBottomSheet.ShowBottomSheet(context,
                            child: SellerFliter(_manageTeamProvider));
                      },
                    ), ),
                  ),


                ],
              ),
            ),
            SellerMangerTeamList(),
          ],
        ));
  }
}
