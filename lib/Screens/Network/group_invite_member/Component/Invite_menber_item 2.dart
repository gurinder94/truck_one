import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invite_menber_model.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/group_invite_member/invite_group_member_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:provider/provider.dart';

import '../../user_profile.dart';

class InviteMenberItem extends StatelessWidget {
  late InviteGroupMemberProv _inviteGroupMemberProv;

  @override
  Widget build(BuildContext context) {
    _inviteGroupMemberProv =context.read<InviteGroupMemberProv>();
    var data = context.read<Datum>();
    _inviteGroupMemberProv.setData(data);
    return GestureDetector(
      onTap: ()
      {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => UserDetailProvider(),
              child: UserProfile(
                userId: data.id.toString()
              ),
            )));

      },
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
              '',
              fit: BoxFit.fill,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : Center(
                        child: LoadingWidget(((progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!) *
                                100)
                            .toInt()));
              },
              errorBuilder: (a, b, c) => Center(
                  child: Text(
                data.firstName!.substring(0, 1).toUpperCase(),
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
          title: Text(data.firstName.toString()),
          subtitle: Text(data.email.toString()),
          trailing: data.isMember == true
              ? Text(data.status.toString())
              : Selector<Datum, bool>(
                  selector: (_, provider) => provider.isChecked!,
                  builder: (context, checked, child) {
                    return Checkbox(
                      value: checked,
                      activeColor: PrimaryColor,
                      onChanged: (val) {
                        print(val);
                        checked = val!;

                        if (checked == true) {
                          print(data.id);
                          data.CheckInvitedMenber(true);
                     _inviteGroupMemberProv.sendTo.add(data.id);

                   _inviteGroupMemberProv.getcount(_inviteGroupMemberProv.sendTo.length);

                     print(_inviteGroupMemberProv.sendTo);
                        } else {
                          data.CheckInvitedMenber(false);

                          _inviteGroupMemberProv.sendTo.remove(data.id);
                          _inviteGroupMemberProv.getcount(_inviteGroupMemberProv.sendTo.length);


                        }
                      },
                    );
                  })),
    );
  }
}
