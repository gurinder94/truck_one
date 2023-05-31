import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/user_detail_model.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../Home/Component/description_txt.dart';
import '../../Home/Component/option_button.dart';
import '../../Home/Provider/home_page_list_provider.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/commanField_widget.dart';
import '../../commanWidget/comman_video_play.dart';
import '../../commanWidget/custom_image_network_profile.dart';

class UserSharPost extends StatefulWidget {
  PostDatum userModel;

  UserSharPost(this.userModel);

  @override
  State<UserSharPost> createState() => _UserSharPostState();
}

class _UserSharPostState extends State<UserSharPost> {
  late HomePageListProvider homeProvider;
  @override
  var formKey = GlobalKey<FormState>();
  var txtController = TextEditingController();
  int pagePos = 0;

  Widget build(BuildContext context) {
    homeProvider = context.read<HomePageListProvider>();
    return CustomAppBarWidget(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              size: 20,
            )),
        title: AppLocalizations.instance.text("Share Post"),
        actions: Row(
          children: [
            Selector<HomePageListProvider, bool>(
                selector: (_, provider) => provider.sharePostLoder,
                builder: (context, shareLoder, child) {
                  return shareLoder == true
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : GestureDetector(
                          child: Text(AppLocalizations.instance.text("Post")),
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              var getid = await getUserId();
                              var getName = await getNameInfo();
                              homeProvider.sharePost({
                                "userId": getid,
                                "postId": widget.userModel.id,
                                "caption": txtController.text.toString(),
                                "userName": getName,
                              });

                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            }
                          },
                        );
                }),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: CustomImageProfile(
                          width: 50,
                          height: 50,
                          image: IMG_URL +
                              widget.userModel.userData!.image.toString(),
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        capitalize(
                            widget.userModel.userData!.personName.toString()),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: double.infinity,
                    height: 250,
                    child: InputTextField(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: txtController,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText:
                              AppLocalizations.instance.text("Post Message"),
                          border: InputBorder.none,
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 10,
                        minLines: 1,
                        validator: (val) {
                          if (txtController.text.toString().isEmpty)
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
                                image: widget.userModel.orignalPostData == null
                                    ? IMG_URL +
                                        widget.userModel.userData!.image
                                            .toString()
                                    : IMG_URL +
                                        widget.userModel.orignalPostData!
                                            .userData!.image
                                            .toString(),
                                boxFit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              capitalize(capitalize(
                                widget.userModel.orignalPostData == null
                                    ? widget.userModel.userData!.personName
                                        .toString()
                                    : widget.userModel.orignalPostData!
                                        .userData!.personName
                                        .toString(),
                              )),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        DescriptionTxt(
                          description: widget.userModel.orignalPostData == null
                              ? widget.userModel.caption.toString()
                              : widget.userModel.orignalPostData!.caption
                                  .toString(),
                          isShared: widget.userModel.type == 'SHARED',
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        widget.userModel.media!.length == 0
                            ? widget.userModel.orignalPostData == null
                                ? SizedBox()
                                : widget.userModel.orignalPostData!.media!
                                            .length ==
                                        0
                                    ? SizedBox()
                                    : Stack(
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                          Container(
                                              width: double.infinity,
                                              height: 250,
                                              child: PageView.builder(
                                                  allowImplicitScrolling: true,
                                                  itemCount: widget
                                                      .userModel
                                                      .orignalPostData!
                                                      .media!
                                                      .length,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  onPageChanged: (val) {
                                                    pagePos = val;
                                                    setState(() {});
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int itemIndex) {
                                                    Media _media = widget
                                                        .userModel
                                                        .orignalPostData!
                                                        .media![itemIndex];
                                                    return _media.type ==
                                                            "IMAGE"
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              width: 250,
                                                              height: 280,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xff7c94b6),
                                                                image:
                                                                    DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    Base_URL_group_image +
                                                                        _media
                                                                            .name
                                                                            .toString(),
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: CommanVideoView(
                                                                _media.name
                                                                    .toString()),
                                                          );
                                                  })),
                                          widget.userModel.orignalPostData!
                                                      .media!.length >
                                                  1
                                              ? Container(
                                                  width: double.infinity,
                                                  color: Colors.black
                                                      .withOpacity(.5),
                                                  alignment: Alignment.center,
                                                  child: SizedBox(
                                                    height: 25,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: widget
                                                            .userModel
                                                            .orignalPostData!
                                                            .media!
                                                            .length,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            Container(
                                                              height: index ==
                                                                      pagePos
                                                                  ? 9
                                                                  : 5,
                                                              width: index ==
                                                                      pagePos
                                                                  ? 9
                                                                  : 5,
                                                              margin: EdgeInsets
                                                                  .all(1),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            )),
                                                  ))
                                              : SizedBox()
                                        ],
                                      )
                            : widget.userModel.media!.length == 0
                                ? SizedBox()
                                : Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          height: 250,
                                          child: PageView.builder(
                                              allowImplicitScrolling: true,
                                              itemCount: widget
                                                  .userModel.media!.length,
                                              scrollDirection: Axis.horizontal,
                                              onPageChanged: (val) {
                                                pagePos = val;
                                                setState(() {});
                                              },
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int itemIndex) {
                                                Media _media = widget.userModel
                                                    .media![itemIndex];
                                                return _media.type == "IMAGE"
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          width: 250,
                                                          height: 280,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff7c94b6),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                Base_URL_group_image +
                                                                    _media.name
                                                                        .toString(),
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                        ),
                                                      )
                                                    : Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CommanVideoView(
                                                            _media.name
                                                                .toString()),
                                                      );
                                              })),
                                      widget.userModel.media!.length > 1
                                          ? Container(
                                              width: double.infinity,
                                              color:
                                                  Colors.black.withOpacity(.5),
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: 25,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemCount: widget.userModel
                                                        .media!.length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Container(
                                                          height:
                                                              index == pagePos
                                                                  ? 9
                                                                  : 5,
                                                          width:
                                                              index == pagePos
                                                                  ? 9
                                                                  : 5,
                                                          margin:
                                                              EdgeInsets.all(1),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        )),
                                              ))
                                          : SizedBox()
                                    ],
                                  ),

                        // Container(
                        //         width: double.infinity,
                        //         height: 250,
                        //         child: ListView.builder(
                        //             itemCount: widget.userModel.media!.length,
                        //             scrollDirection: Axis.horizontal,
                        //             itemBuilder:
                        //                 (BuildContext context, int index) {
                        //               return Padding(
                        //                 padding: const EdgeInsets.all(15.0),
                        //                 child: widget.userModel.media![index]
                        //                             .type ==
                        //                         "IMAGE"
                        //                     ? Container(
                        //                         width: 250,
                        //                         height: 280,
                        //                         decoration: BoxDecoration(
                        //                           color: Color(0xff7c94b6),
                        //                           image: DecorationImage(
                        //                             image: NetworkImage(
                        //                               Base_URL_group_image +
                        //                                   widget
                        //                                       .userModel
                        //                                       .media![index]
                        //                                       .name
                        //                                       .toString(),
                        //                             ),
                        //                             fit: BoxFit.cover,
                        //                           ),
                        //                           borderRadius:
                        //                               BorderRadius.circular(12),
                        //                         ),
                        //                       )
                        //                     : CommanVideoView(widget
                        //                         .userModel.media![index].name
                        //                         .toString()),
                        //               );
                        //             }),
                        //       ),

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
