import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import 'Provider/Group_share_provider.dart';

class GroupPostShare extends StatelessWidget {
  String groupName;
  String groupImage;
  String totalMembers;
  GroupProvider provider;
  TextEditingController description = TextEditingController();
  late GroupShareProvider _groupShareProvider;

  GroupPostShare(
      this.groupName, this.groupImage, this.totalMembers, this.provider);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _groupShareProvider = context.read<GroupShareProvider>();
    return CustomAppBarWidget(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              size: 20,
            )),
        title: AppLocalizations.instance.text('Share a Group'),
        actions: GestureDetector(
            child: Row(
              children: [
                Selector<GroupShareProvider, bool>(
                    selector: (_, provider) => provider.shareGroupPostLoder,
                    builder: (context, shareLoder, child) {
                      return shareLoder == true
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : GestureDetector(
                              child:
                                  Text(AppLocalizations.instance.text('Post')),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  _groupShareProvider.hitshareGroupPost(
                                      description.text,
                                      provider.model.data!.id.toString());


                                }
                              },
                            );
                    }),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            onTap: () async {}),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 90,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: CustomImageProfile(
                          width: 50,
                          height: 50,
                          image: IMG_URL + provider.userImage,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        capitalize(
                          provider.userName,
                        ),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: InputTextField(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: description,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                        decoration:  InputDecoration(
                          hintText: AppLocalizations.instance.text("Post Message"),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        minLines: 1,
                        validator: (val) {
                          if (description.text.toString().isEmpty)
                            return 'Please enter caption';
                          return null;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              child: CustomImageProfile(
                                width: 50,
                                height: 50,
                                image: Base_Url_group + groupImage,
                                boxFit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalize(capitalize(groupName)),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text("$totalMembers " +
                                    AppLocalizations.instance.text("Members")),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionWidget: SizedBox());
  }
}
