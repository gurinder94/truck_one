import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ChatModel/group_friend_List.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/create_group_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:provider/provider.dart';

class ChatCreateGroupCompoment extends StatelessWidget {
  CreateGroupProvider proData;

  ChatCreateGroupCompoment(this.proData, {Key? key}) : super(key: key);

  ///add participants
  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        title: AppLocalizations.instance.text("Create Group"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: Row(
          children: [
            Consumer<CreateGroupProvider>(builder: (_, proData, __) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: proData.createLoder
                      ? SizedBox(
                          width: 25,
                          height: 35,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          )))
                      : Text(
                          AppLocalizations.instance.text("Submit"),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                ),
                onTap: () {
                  if (proData.groupName.text.isNotEmpty) {
                    // Navigator.pop(context, "Successfully");
                    proData.createGroup(context);
                  } else {
                    showMessage("Please enter group name");
                  }
                },
              );
            })
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Consumer<CreateGroupProvider>(builder: (_, pro, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 110,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 110,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        CustomImageProfile(
                          image: pro.imageUrl == null
                              ? ''
                              : SERVER_URL +
                                  '/uploads/event/brand_logo/' +
                                  pro.imageUrl,
                          width: 110,
                          boxFit: BoxFit.cover,
                          height: 120,
                        ),
                        Positioned(
                          top: 90,
                          right: 0,
                          left: 50,
                          child: Container(
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF1A62A9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black54, blurRadius: 10)
                              ],
                            ),
                            child: GestureDetector(
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onTap: () {
                                  pro.getFromGallery("BRANDLOGO", context);
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputShape(
                  child: TextFormField(
                    controller: pro.groupName,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.instance
                          .text("Enter Your Group Name"),
                      hintStyle: TextStyle(fontSize: 17),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "${AppLocalizations.instance.text("Participants")} : ${proData.selectMemberList.length}",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                   height: 10,
                ),
                Expanded(
                  child: GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      childAspectRatio: 0.85,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: List.generate(proData.selectMemberList.length,
                          (index) {
                        return friendItem(proData.selectMemberList, index);
                      })),
                )
              ],
            );
          }),
        ));
  }

  Widget friendItem(List<Datum> selectMemberList, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              CustomImageProfile(
                  image: IMG_URL +
                      proData.selectMemberList[index].image.toString(),
                  width: 50,
                  boxFit: BoxFit.contain,
                  height: 50),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            selectMemberList[index].personName.toString(),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
