import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';

import 'package:my_truck_dot_one/Screens/Home/Provider/like_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

class LikeScreen extends StatelessWidget {
  String postId;

  LikeScreen(this.postId);

  late LikeProvider _likeProvider;

  @override
  Widget build(BuildContext context) {
    _likeProvider = context.read<LikeProvider>();
    _likeProvider.getLikeList(postId);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          centerTitle: false,
          title:  Text(
            AppLocalizations.instance.text('Likes'),
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: APP_BG,
        body: Consumer<LikeProvider>(builder: (_, proData, __) {
          if (proData.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (proData.likeListModel == null)
            return Center(child: Text(proData.message));
          else if (proData.likeListModel!.data!.length == 0)
            return Center(
                child: Text(AppLocalizations.instance.text('No Record Found')));
          else {
            return ListView.builder(
                itemCount: proData.likeListModel!.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            child: CustomImageProfile(
                                image:
                                    proData.likeListModel!.data![index].image ==
                                            null
                                        ? ''
                                        : IMG_URL +
                                            proData.likeListModel!.data![index]
                                                .image
                                                .toString(),
                                width: 40,
                                boxFit: BoxFit.contain,
                                height: 40),
                          ),
                          trailing: Image.asset(
                            'assets/like_ic.png',
                            scale: 30,
                          ),
                          title: Text(proData
                              .likeListModel!.data![index].personName
                              .toString())),
                      decoration: const BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                    ),
                  );
                });
          }
        }));
  }
}
