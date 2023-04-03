import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/my_groups_model.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_menber_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/my_groups_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:provider/provider.dart';
import '../../group_admin_choose_Screen/choose_admin_group_page.dart';
import '../../group_view/view_group.dart';

class GroupListItem extends StatelessWidget {
  MyGroup group;
  MyGroupsProvider provider;
  int index;

  GroupListItem(    {required this.group, required this.provider,required this.index });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (context) => GroupProvider(),
                      child: ViewGroup(
                        gId: group.datumGroupId.toString(),
                      ),
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
          BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(-5, -5))
        ]),
        child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              margin: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(5, 5)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 4,
                        offset: Offset(-5, -5))
                  ]),
              child: Container(
                height: 60,
                width: 60,
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(2),
                decoration: const BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(-5, -5)),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 4,
                          offset: Offset(5, 5))
                    ]),
                child: Image.network(
                  Base_Url_Image_Group+group.groupImage,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : CircularProgressIndicator.adaptive();
                  },
                  errorBuilder: (a, b, c) => Center(
                      child: Text(
                    group.name!.substring(0, 1).toString().toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.2),
                        fontSize: 50,
                        shadows: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 5),
                              blurRadius: 20)
                        ]),
                  )),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      group.name.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 3,),
                  Text(
                    group.role == "owner" ? AppLocalizations.instance.text("owner") : AppLocalizations.instance.text('Member'),
                    style: TextStyle(letterSpacing: 3),
                  ),
                ],
              ),
            ),

            GestureDetector(
              child: Container(
            margin: EdgeInsets.all(3),

                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xF8C6C4C4),
                          offset: Offset(5.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: -4),
                      BoxShadow(
                        color: Colors.white.withOpacity(.5),
                        offset: Offset(-3.0, -3.0),
                        blurRadius: 7,
                      ),
                    ]),
                child: Center(
                    child: Text(
              AppLocalizations.instance.text("Left"),
                  style: TextStyle(
                    fontSize: 14,
                    color: PrimaryColor,
                  ),
                )),
              ),
              onTap: () {
                group.role == "owner"
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (context) => GroupMenberProvider(),
                                child: ChooseAdmin(
                                    group.datumGroupId.toString(),
                                    group.invitationId,
                                    group.role == "owner"
                                        ? 'Owner'
                                        : 'MEMBERLEAVE'))))
                    :      DialogUtils.AlertBox(
                  context,
                  onDoneFunction: () async {
                    provider. removeMyGroup( group.datumGroupId.toString(),
                        group.invitationId,

                         index);
                  },
                  oncancelFunction: () => Navigator.pop(context),
                  title: AppLocalizations.instance.text("Delete!"),
                  buttonTitle: AppLocalizations.instance.text("Yes"),
                  secondBtnText: AppLocalizations.instance.text("No"),
                  alertTitle:AppLocalizations.instance.text("groupDeleteMessage"),
                );


              },
            ),



          ],
        ),
      ),
    );
  }
}
