import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/group_model.dart';
import 'package:my_truck_dot_one/Screens/Network/group_like_list_Screen/provider/group_like_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

class GroupLikePage extends StatelessWidget {
  PostDatum data;

  GroupLikePage(this.data);

  late GroupLikeProvider _likeProvider;

  @override
  Widget build(BuildContext context) {
    _likeProvider = context.read<GroupLikeProvider>();
    _likeProvider.getLikeList(data);
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
          title: const Text(
            'Likes',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: APP_BG,
        body: Consumer<GroupLikeProvider>(builder: (_, proData, __) {
          if (proData.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (proData.likeListModel.data!.length == 0)
            return Center(child: Text('No Record Found'));
          else {
            return ListView.builder(
                itemCount: proData.likeListModel.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(15),

                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                        leading: CustomImageProfile(
                          image: proData
                                      .likeListModel.data![index].image ==
                                  null
                              ? ''
                              : IMG_URL +
                                  proData.likeListModel.data![index].image
                                      .toString(),
                          height: 50,
                          width: 50,
                          boxFit: BoxFit.fill,
                        ),
                        title: Text(proData
                            .likeListModel.data![index].personName
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
                  );
                });
          }
        }));
  }
}
