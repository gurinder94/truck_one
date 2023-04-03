import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/constants.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import '../../commanWidget/input_shape.dart';

class EditGroupView extends StatelessWidget {
  ChatViewGroupProvider proData;

  EditGroupView(this.proData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<ChatViewGroupProvider, String>(
        selector: (_, provider) => provider.imagePicker,
        builder: (context, imagepick, child) {
          return Container(
            height:360,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: APP_BG,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Text(
                  "Edit Group",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 120,
                  child: Stack(
                    children: [
                      CustomImageProfile(
                          image: imagepick == "null"
                              ? SERVER_URL +
                                  '/uploads/event/brand_logo/' +
                                  proData.chatGroupViewModel!.data!.image
                                      .toString()
                              : SERVER_URL +
                                  '/uploads/event/brand_logo/' +
                                  imagepick,
                          width: 100,
                          boxFit: BoxFit.cover,
                          height: 100),
                      Positioned(
                        right: 0,
                        left: 50,
                        top: 78,
                        child: Container(
                          height: 40,
                          width: 40,
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
                              ),
                              onTap: () {
                                proData.getFromGallery(
                                    "BRANDLOGO", context, proData);
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InputShape(
                    child: TextFormField(
                      controller: proData.groupName,
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(50),
                      ],
                      maxLength: 150,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Group Name',
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommanButtonWidget(
                        title: "Cancel",
                        buttonColor: PrimaryColor,
                        titleColor: APP_BG,
                        onDoneFuction: () {
                          Navigator.pop(context);
                        },
                        loder: false,
                      ),
                    ),
                    Expanded(
                      child: CommanButtonWidget(
                        title: "Update Group",
                        buttonColor: PrimaryColor,
                        titleColor: APP_BG,
                        onDoneFuction: () {
                          proData.groupViewUpdate(
                              imagepick == "null"
                                  ? proData.chatGroupViewModel!.data!.image
                                      .toString()
                                  : imagepick,
                              context);
                        },
                        loder: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
