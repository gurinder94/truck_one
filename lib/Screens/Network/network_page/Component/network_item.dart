import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/recommandation_model 2.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';

import 'package:provider/provider.dart';



class NetworkItem extends StatelessWidget {
  List<PersonInfo> list;
  late NetworkProvider _provider;
  late PersonInfo _info;
  int index;

  NetworkItem(
    this.index,
    this.list,
  );

  @override
  Widget build(BuildContext context) {
    _info = context.watch<PersonInfo>();
    var personInfo = context.read<PersonInfo>();
    _provider = context.read<NetworkProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (context) => UserDetailProvider(),
                      child: UserProfile(
                        userId: _info.id.toString(),
                      ),
                    )))
            .then((value) async {
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
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
                _info.image == null
                    ? 'https://mytruck.one/login'
                    : IMG_URL + _info.image!,
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
                  _info.personName!.substring(0, 1).toUpperCase(),
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
          Text(
            capitalize(
              _info.personName.toString(),
            ),
            textAlign: TextAlign.center,
            softWrap: false,
            maxLines: 1,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '${_info.city} ',
            style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          Selector<PersonInfo, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, loder, child) {
                return Container(
                    child: _provider.tabEnable == 0
                        ? loder == true
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1,
                                ))
                            : GestureDetector(
                                onTap: () async {
                                  var getid = await getUserId();
                                  var name = await getNameInfo();
                                  var image = await getprofileInfo();
                                  _info.inConnection == false
                                      ? personInfo.connectUser({
                                          "invitedBy": getid,
                                          "invitedTo": _info.id,
                                          "userName": name,
                                          "userImage": image,
                                        }, context, _provider, index)
                                      : Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                    create: (context) =>
                                                        UserDetailProvider(),
                                                    child: UserProfile(
                                                      userId:
                                                          _info.id.toString(),
                                                    ),
                                                  )));
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: APP_BAR_BG,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
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
                                  child: Text(
                                    _info.inConnection == false
                                        ? AppLocalizations.instance.text("Connect")
                                        : AppLocalizations.instance.text("View Profile"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              )
                        : Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                    var name = await getNameInfo();
                                    var getid = await getUserId();
                                    var image = await getprofileInfo();
                                    _provider.getInviteAccept({
                                      "invitationId": list[index].invitationId,
                                      "userName": name,
                                      "userImage": image,
                                      "userId": getid,
                                    }, context, _provider, 1, index);
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
                                      var name = await getNameInfo();
                                      var image = await getprofileInfo();
                                      var getid = await getUserId();

                                      _provider.getInviteDecline({
                                        "invitationId":
                                            list[index].invitationId,
                                        "userName": name,
                                        "userImage": image,
                                        "userId": getid,
                                      }, index, _provider, 1);
                                    }),
                              ],
                            ),
                          ));
              }),
        ]),
      ),
    );
  }
}
