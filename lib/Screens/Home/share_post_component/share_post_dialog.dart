import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../Language_Screen/application_localizations.dart';
import '../../commanWidget/commanField_widget.dart';
import '../../commanWidget/comman_page_view.dart';
import '../../commanWidget/comman_video_play.dart';
import '../Component/description_txt.dart';

class SharePost extends StatefulWidget {
  PostItem list;
  HomePageListProvider homeProvider;

  SharePost(this.list, this.homeProvider);

  @override
  State<SharePost> createState() => _SharePostState();
}

class _SharePostState extends State<SharePost> {
  var txtController = TextEditingController();

  var formKey = GlobalKey<FormState>();

int pagePos=0;

  @override
  Widget build(BuildContext context) {
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
        actions: GestureDetector(
            child: Row(
              children: [
                Selector<HomePageListProvider, bool>(
                    selector: (_, provider) => provider.sharePostLoder,
                    builder: (context, shareLoder, child) {
                      return shareLoder == true
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : GestureDetector(
                              child:
                                  Text(AppLocalizations.instance.text("Post")),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  var getid = await getUserId();
                                  var getName=await getNameInfo();
                                  widget.homeProvider.sharePost({
                                    "userId": getid,
                                    "postId": widget.list.id,
                                    "caption": txtController.text.toString(),
                                    "userName":getName
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
                          image: IMG_URL + widget.homeProvider.image.toString(),
                          boxFit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        capitalize(widget.homeProvider
                                .accountDetailsModel.data!.userInfo!.firstName
                                .toString() +
                            ' ' +
                            widget.homeProvider
                                .accountDetailsModel.data!.userInfo!.lastName
                                .toString()),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: InputTextField(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: txtController,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          hintText: AppLocalizations.instance.text("Post Message"),
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
                                image: widget.list.orignalPostData == null
                                    ? IMG_URL + widget.list.userData!.image.toString()
                                    : IMG_URL +
                                        widget.list.orignalPostData!.userData!.image
                                            .toString(),
                                boxFit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              capitalize(capitalize(
                                widget.list.orignalPostData == null
                                    ? widget.list.userData!.personName.toString()
                                    : widget.list.orignalPostData!.userData!.personName
                                        .toString(),
                              )),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                        DescriptionTxt(
                          description:widget.list.orignalPostData == null
                              ? widget.list.caption.toString()
                              : widget.list.orignalPostData!.caption.toString() ,
                          isShared: widget.list.type== 'SHARED',
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        widget.list.media!.length == 0
                            ? widget.list.orignalPostData == null
                                ? SizedBox()
                                : widget.list.orignalPostData!.media!.length==0?SizedBox():Stack(
                          alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                        width: double.infinity,
                                        height: 250,

                          child: PageView.builder(
                            allowImplicitScrolling: true,
                            itemCount:  widget.list.orignalPostData!.media!.length,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (val) {
                              pagePos=val;
                              setState(() {

                              });
                            },
                            itemBuilder: (BuildContext context, int itemIndex) {
                              Media _media =widget.list.orignalPostData!.media![itemIndex];
                              return
                                    _media.type ==
                                                  "IMAGE"
                                              ? Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                    width: 250,
                                                    height: 280,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff7c94b6),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          Base_URL_group_image +

                                                                  _media
                                                                  .name
                                                                  .toString(),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                              )
                                              : Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CommanVideoView(_media
                                                    .name
                                                    .toString()),
                                              );

                              })



                        ),
                                    widget.list.orignalPostData!.media!.length>1?       Container(
                                        width: double.infinity,
                                        color: Colors.black.withOpacity(.5),
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 25,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: widget.list.orignalPostData!.media!.length,
                                              itemBuilder: (context, index) => Container(
                                                height: index == pagePos ? 9 : 5,
                                                width: index == pagePos ? 9 : 5,
                                                margin: EdgeInsets.all(1),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                              )),
                                        )):SizedBox()
                                  ],
                                ):widget.list.media!.length==0?SizedBox():Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                                width: double.infinity,
                                height: 250,

                                child: PageView.builder(
                                    allowImplicitScrolling: true,
                                    itemCount:widget.list.media!.length,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (val) {
                                      pagePos=val;
                                      setState(() {

                                      });
                                    },
                                    itemBuilder: (BuildContext context, int itemIndex) {
                                      Media _media =widget.list.media![itemIndex];
                                      return
                                        _media.type ==
                                            "IMAGE"
                                            ? Container(
                                          width: 250,
                                          height: 280,
                                          decoration: BoxDecoration(
                                            color: Color(0xff7c94b6),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                Base_URL_group_image +

                                                    _media
                                                        .name
                                                        .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                12),
                                          ),
                                        )
                                            : CommanVideoView(_media
                                            .name
                                            .toString());

                                    })



                            ),
                            widget.list.media!.length>1?       Container(
                                width: double.infinity,
                                color: Colors.black.withOpacity(.5),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 25,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: widget.list.media!.length,
                                      itemBuilder: (context, index) => Container(
                                        height: index == pagePos ? 9 : 5,
                                        width: index == pagePos ? 9 : 5,
                                        margin: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle),
                                      )),
                                )):SizedBox()
                          ],
                        )
            ]
            ),


                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              )
            ),
          ),
        ),
        floatingActionWidget: SizedBox());
  }
}
