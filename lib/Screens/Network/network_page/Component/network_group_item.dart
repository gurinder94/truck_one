import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_invitation_model 2.dart';
import 'package:my_truck_dot_one/Screens/Network/group_view/view_group.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:provider/provider.dart';


class GroupItem extends StatelessWidget {
  late GroupInfo _info;
  late NetworkProvider _provider;
  int index;

  GroupItem(this.index, );

  @override
  Widget build(BuildContext context) {
    _info = context.watch<GroupInfo>();
    _provider = context.read<NetworkProvider>();

    return  GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (context) => GroupProvider(),
                      child: ViewGroup(
                        gId: _info.groupId.toString(),
                      ),
                    ))).then((value)
        async {
          var getid = await getUserId();
          _provider.setRecommendationTab(0);
          _provider.getRecommendations({
            "userId": getid,
            "page": 1,
            "type": "SUGGESTION",
            "searchText": ""
          }, false, "");
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 100,
              width: 100,
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
                height: 100,
                width: 100,
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
                  Base_Url_Image_Group + _info.groupImage!,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : Center(
                            child: LoadingWidget(
                                ((progress.cumulativeBytesLoaded /
                                            progress.expectedTotalBytes!) *
                                        100)
                                    .toInt()));
                  },
                  errorBuilder: (a, b, c) => Center(
                      child: Text(
                    _info.groupName!.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(.2),
                        fontSize: 70,
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
            SizedBox(
              height: 10,
            ),
            Text(
              _info.groupName.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Invite by ' + _info.personName.toString(),
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            _info.loading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                    ))
                : Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                           width: 50,
                            height: 50,
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
                              size: 25,
                            ),
                          ),
                          onTap: () async {
                            var name = await getNameInfo();
                            var getid =await getUserId();
                            var image = await getprofileInfo();
                            _provider.getInviteAccept({

                              "invitationId": _info.id,
                              "userName": name,
                              "userImage": image==''?null:image,
                              "userId":getid,
                              "invitedBy":_info.invitedBy
                            }, context, _provider, 2, index);
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            child: Container(
                              width: 50,
                              height: 50,

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
                                size: 25,
                              ),
                            ),
                            onTap: () async {
                              var name = await getNameInfo();
                              var getid =await getUserId();
                              var image = await getprofileInfo();
                              _provider.getInviteDecline(
                                {
                                  "invitationId": _info.id,
                                  "userName": name,
                                  "userImage": image,
                                  "userId":getid,
                                  "invitedBy":_info.invitedBy
                                },
                                index,
                                _provider,
                                2,
                              );
                            }),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
