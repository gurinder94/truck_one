import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/job_invitation_model.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/loading_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:provider/provider.dart';

import '../network_provider.dart';
import '../../Provider/user_detail_provider.dart';

class JobInvitationsScreen extends StatelessWidget {
  List<Datum> list;
  late NetworkProvider _provider;
  late Datum _info;
  int index;

  JobInvitationsScreen(this.index, this.list,);

  @override
  Widget build(BuildContext context) {
    _info = context.watch<Datum>();
    _provider = context.read<NetworkProvider>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (context) => UserDetailProvider(),
              child: UserProfile(
                userId: list[index].companyId!,
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
                  list[index].image==null?'': IMG_URL +
                      list[index].image!,
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
                        list[index].companyName!.substring(0, 1).toUpperCase(),
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
              list[index].companyName.toString().toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "Access" + ' ' + capitalize(list[index].accessLevel.toString(),) ,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            list[index].status == "ACCEPTED"
                ? Text(list[index].status.toString())
                :
            list[index].status == "CANCELLED"?Text(list[index].status.toString()):
            list[index].status == "DECLINE"?Text(list[index].status.toString()):
            Flexible(
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
                            var getId= await getUserId();
                            _info.  hitAcceptOffer({
                              "resetkey": list[index].resetkey.toString(),
                            }, "ACCEPTED",context);
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
                              var getId= await getUserId();
                              _info.  hitRejectOffer({
                                "resetkey": list[index].resetkey.toString(),
                              }, "DECLINE");
                            },),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

String capitalize(String value) {
  var   name;
  if (value.length > 1) {

     name=value[0].toUpperCase() +value.substring(1).toLowerCase();

  }

  return name;
}
