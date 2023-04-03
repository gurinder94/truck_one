import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/commanField_widget.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import '../Provider/group_provider.dart';
import '../Provider/send_group_post_provider.dart';

class GroupCreatePost extends StatefulWidget {
  String gId;
  GroupProvider provider;

  GroupCreatePost(this.gId, this.provider);

  @override
  State<GroupCreatePost> createState() => _GroupCreatePostState();
}

class _GroupCreatePostState extends State<GroupCreatePost> {
  bool validation = false, uploadFile = false;
  late GroupPostSendProvider groupPostSendProvider;

  final ImagePicker _picker = ImagePicker();

  late List files;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupPostSendProvider = context.read<GroupPostSendProvider>();
    groupPostSendProvider.setContext(context);

    files = [];
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: AppLocalizations.instance.text('createPost'),
        actions: SizedBox(),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: 90,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CustomImageProfile(
                      image: IMG_URL + widget.provider.userImage.toString(),
                      width: 80,
                      boxFit: BoxFit.fill,
                      height: 80),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.provider.userName.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              padding: EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(-5, -5)),
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 5,
                        offset: Offset(5, 5))
                  ]),
              child: TextField(
                onChanged: (val) {
                  if (val.length > 0)
                    setState(() {
                      validation = false;
                    });
                },
                controller: groupPostSendProvider.captionText,
                maxLength: 1500,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    counterText: '',
                    hintText: AppLocalizations.instance.text("Post Message"),
                    border: InputBorder.none),
              ),
            ),
            // Text(
            //   validation ? 'Enter some caption *' : '',
            //   style: TextStyle(
            //       color: Colors.red,
            //       fontStyle: FontStyle.italic,
            //       fontSize: 15),
            // ),
            uploadFile
                ? LinearProgressIndicator(
                    color: Colors.white,
                    backgroundColor: Colors.black,
                    minHeight: 1,
                  )
                : SizedBox(),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: postBoxWidget('Camera', 'assets/photo_small_ic.png'),
                  onTap: () {
                    if (files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickImageCamera();
                  },
                ),
                GestureDetector(
                  child: postBoxWidget('Photo', 'assets/picture_small_ic.png'),
                  onTap: () {
                    if (files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickImage();
                  },
                ),
                GestureDetector(
                  child: postBoxWidget('Video', 'assets/video_ic.png'),
                  onTap: () {
                    if (files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickVideo();
                  },
                ),
                Consumer<GroupPostSendProvider>(
                    builder: (context, noti, child) {
                  return noti.loading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator())
                      : GestureDetector(
                          onTap: () async {
                            // if (groupPostSendProvider.captionText.text
                            //     .toString()
                            //     .trim()
                            //     .isEmpty)
                            //   setState(() {
                            //     validation = true;
                            //   });
                            if (groupPostSendProvider.captionText.text
                                .toString()
                                .trim()
                                .isEmpty)
                              showMessage('Please enter caption');
                            else {
                              var getid = await getUserId();
                              noti.postInGroup({
                                "type": "GROUP",
                                "postedById": getid,
                                "caption": groupPostSendProvider
                                    .captionText.text
                                    .toString()
                                    .trim(),
                                "groupId": widget.gId,
                                "media": files,
                              }, widget.gId);
                              widget.provider.restPage(1);
                              files.clear();
                            }
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 3,
                                        offset: Offset(3, 3)),
                                    BoxShadow(
                                        color: Colors.white,
                                        blurRadius: 3,
                                        offset: Offset(-5, -5))
                                  ],
                                  color: APP_BAR_BG,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                AppLocalizations.instance.text("Post"),
                                style: TextStyle(color: Colors.white),
                              )),
                        );
                }),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: files.length > 0 ? 70 : 0,
              alignment: Alignment.topLeft,
              child: ListView.builder(
                  itemCount: files.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        Container(
                            height: 40,
                            width: 40,
                            margin: EdgeInsets.all(10),
                            color: Colors.blue,
                            child: Image.network(
                              Base_URL_group_image + files[index]['name'],
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : Center(
                                        child: CircularProgressIndicator
                                            .adaptive());
                              },
                              errorBuilder: (a, b, c) => Center(
                                  child: Icon(
                                files[index]['type'] == "IMAGE"
                                    ? Icons.broken_image_outlined
                                    : Icons.video_call_outlined,
                                color: Colors.white,
                              )),
                            )),
                        Positioned(
                          right: -10,
                          top: -10,
                          child: IconButton(
                              onPressed: () {
                                files.removeAt(index);
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.redAccent,
                              )),
                        )
                      ],
                    );
                  }),
            ),
          ]),
        )),
        floatingActionWidget: SizedBox());
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 500,
        imageQuality: 100);

    hitUploadImage(File(image!.path), 'POSTIMAGE');
  }

  postBoxWidget(String title, String path) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Image.asset(
          path,
          height: 21,
          width: 28,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 13),
        )
      ],
    );
  }

  Future<void> pickVideo() async {
    final XFile? image = await _picker.pickVideo(
        source: ImageSource.gallery, maxDuration: Duration(minutes: 3));
    hitUploadImage(File(image!.path), 'POSTVIDEO');
  }

  Future<void> pickImageCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 500,
    );
    hitUploadImage(File(image!.path), 'POSTIMAGE');
  }

  hitUploadImage(File image, String type) async {
    setState(() {
      uploadFile = true;
    });
    try {
      var postUri =
          Uri.parse(type == 'POSTIMAGE' ? Base_URL_image : Base_URL_video);
      var request = new http.MultipartRequest("POST", postUri);
      request.fields.addAll({"type": type});
      request.files.add(http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
        contentType: type == 'POSTIMAGE'
            ? MediaType('image', 'jpeg')
            : MediaType('video', 'mp4'),
      ));
      var response = await request.send();
      if (response.statusCode == 200) {
        print(response);
        String value = await utf8.decoder.bind(response.stream).join();
        var jsonData = json.decode(value);
        print('Response body: $jsonData');
        if (jsonData['code'] != 200) {
          showMessage(jsonData['message']);
          setState(() {
            uploadFile = false;
          });
        } else {
          files.add({
            "type": type == 'POSTIMAGE' ? 'IMAGE' : 'VIDEO',
            "name": jsonData['data']['imagePath']
          });
          print(files);
          setState(() {
            uploadFile = false;
          });
        }
      }
    } on SocketException {
      setState(() {
        uploadFile = false;
      });
      showMessage('Network Issue !!');
    }
  }

  void showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
