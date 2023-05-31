import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/group_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/send_group_post_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';

import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import '../../../Language_Screen/application_localizations.dart';
import '../../../commanWidget/commanField_widget.dart';
import '../../group_create_Post/group_create_post.dart';
import '../view_group.dart';

class GroupPostBox extends StatefulWidget {
  String gId;
  GroupProvider _provider;

  GroupPostBox(this.gId, this._provider);

  @override
  _GroupPostBoxState createState() => _GroupPostBoxState(gId, _provider);
}

class _GroupPostBoxState extends State<GroupPostBox> {
  bool validation = false, uploadFile = false;
  late GroupPostSendProvider _provider;
  String gId;
  final ImagePicker _picker = ImagePicker();

  GroupProvider provider;

  _GroupPostBoxState(this.gId, this.provider);

  late List files;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.read<GroupPostSendProvider>();
    _provider.setContext(context);
    _provider.getUserData();

    files = [];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, blurRadius: 5, offset: Offset(5, 5)),
              BoxShadow(
                  color: Colors.white, blurRadius: 5, offset: Offset(-5, -5))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //
            //             Container(
            //
            //               child: CustomImageProfile(boxFit:BoxFit.cover,
            //                 height: 40,
            //                 width: 40,
            //                 image: '',
            //
            //               ),
            //             ),
            // Container(
            //   padding: EdgeInsets.all(2),
            //   decoration: const BoxDecoration(
            //       color: Color(0xFFEEEEEE),
            //       borderRadius: BorderRadius.all(Radius.circular(10)),
            //       boxShadow: [
            //         BoxShadow(
            //             color: Colors.black12,
            //             blurRadius: 5,
            //             offset: Offset(-5, -5)),
            //         BoxShadow(
            //             color: Colors.white,
            //             blurRadius: 5,
            //             offset: Offset(5, 5))
            //       ]),
            //   child: TextField(
            //     onChanged: (val) {
            //       if (val.length > 0)
            //         setState(() {
            //           validation = false;
            //         });
            //     },
            //     controller: _provider.captionText,
            //     maxLength: 1500,
            //     maxLines: null,
            //     keyboardType: TextInputType.multiline,
            //     textInputAction: TextInputAction.done,
            //     decoration: const InputDecoration(
            //         counterText: '',
            //         hintText: 'What do you want to talk about ?',
            //         border: InputBorder.none),
            //     onTap: ()
            //     {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) =>
            //                   ChangeNotifierProvider(
            //                     create: (context) =>
            //                         GroupPostSendProvider(),
            //                     child: GroupCreatePost(gId, provider,),
            //                   )));
            //     },
            //   ),
            //
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       // Consumer<GroupPostSendProvider>(builder: (context, noti, child) {
            //       //   return noti.loading || uploadFile
            //       //       ? SizedBox(
            //       //           height: 20,
            //       //           width: 20,
            //       //           child: CircularProgressIndicator())
            //       //       : GestureDetector(
            //       //           onTap: () async {
            //       //             if (_provider.captionText.text
            //       //                 .toString()
            //       //                 .trim()
            //       //                 .isEmpty)
            //       //               setState(() {
            //       //                 validation = true;
            //       //               });
            //       //             else {
            //       //               var getid = await getUserId();
            //       //               noti.postInGroup({
            //       //                 "type": "GROUP",
            //       //                 "postedById": getid,
            //       //                 "caption":
            //       //                     _provider.captionText.text.toString().trim(),
            //       //                 "groupId": gId,
            //       //                 "media": files,
            //       //               }, gId);
            //       //               provider.restPage(1);
            //       //               files.clear();
            //       //             }
            //       //           },
            //       //           child: Container(
            //       //             padding: EdgeInsets.only(
            //       //                 left: 20, right: 20, top: 10, bottom: 10),
            //       //             decoration: BoxDecoration(boxShadow: const [
            //       //               BoxShadow(
            //       //                   color: Colors.black26,
            //       //                   blurRadius: 3,
            //       //                   offset: Offset(5, 5)),
            //       //               BoxShadow(
            //       //                   color: Colors.white,
            //       //                   blurRadius: 3,
            //       //                   offset: Offset(-5, -5))
            //       //             ], color: APP_BAR_BG, shape: BoxShape.circle),
            //       //             child: Icon(
            //       //               Icons.send,
            //       //               color: Colors.white,
            //       //               size: 15,
            //       //             ),
            //       //           ),
            //       //         );
            //       // })
            //           ],
            //         ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CustomImageProfile(
                        image: IMG_URL + provider.userImage,
                        width: 40,
                        boxFit: BoxFit.contain,
                        height: 40),
                  ),
                  onTap: () async {},
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 8, left: 6),
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          child: InputTextField(
                            child: TextFormField(
                                textAlign: TextAlign.left,
                                enabled: true,
                                readOnly: true,
                                controller: _provider.captionText,
                                textInputAction: TextInputAction.done,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  hintText: AppLocalizations.instance
                                      .text("Post Message"),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (val) {
                                  setState(() {});
                                },
                                onTap: () {
                                  {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeNotifierProvider(
                                                  create: (context) =>
                                                      GroupPostSendProvider(),
                                                  child: GroupCreatePost(
                                                    gId,
                                                    provider,
                                                  ),
                                                ))).then((value) {
                                      _provider.refresh(gId);
                                    });
                                  }
                                }),
                          ),
                        ),
                      ),
                      // uploadFile
                      //     ? LinearProgressIndicator(
                      //         color: Colors.white,
                      //         backgroundColor: Colors.black,
                      //         minHeight: 1,
                      //       )
                      //     : SizedBox(),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       child:
                      //           postBoxWidget('Camera', 'assets/photo_small_ic.png'),
                      //       onTap: () {
                      //         if (_provider.files.length >= 5)
                      //           showMessage('Post only 5 items');
                      //         else
                      //           pickImageCamera();
                      //       },
                      //     ),
                      //
                      //     GestureDetector(
                      //       child:
                      //           postBoxWidget('Photo', 'assets/picture_small_ic.png'),
                      //       onTap: () {
                      //         if (_provider.files.length >= 5)
                      //           showMessage('Post only 5 items');
                      //         else
                      //           pickImage();
                      //       },
                      //     ),
                      //
                      //     GestureDetector(
                      //       child: postBoxWidget('Video', 'assets/video_ic.png'),
                      //       onTap: () {
                      //         if (_provider.files.length >= 5)
                      //           showMessage('Post only 5 items');
                      //         else
                      //           pickVideo();
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //
                      //     Selector<PostUploadProvider, bool>(
                      //         selector: (_, provider) => provider.loading,
                      //         builder: (context, loder, child) {
                      //           return loder==true?CircularProgressIndicator():GestureDetector(
                      //             onTap: () {
                      //               if (_provider.textController.text.trim().isEmpty)
                      //                 showMessage('Please enter caption');
                      //               else
                      //                 uploadPost();
                      //             },
                      //             child: Container(
                      //               width: MediaQuery.of(context).size.width / 8,
                      //               padding: EdgeInsets.all(6),
                      //               alignment: Alignment.center,
                      //               decoration: const BoxDecoration(
                      //                   color: Colors.blue,
                      //                   borderRadius:
                      //                       BorderRadius.all(Radius.circular(30)),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                         color: Colors.black12,
                      //                         blurRadius: 5,
                      //                         offset: Offset(0, 5))
                      //                   ]),
                      //               child: const Text(
                      //                 'Post',
                      //                 style: TextStyle(
                      //                     color: Colors.white,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             ),
                      //           );
                      //         }),

                      //postBoxWidget('Document','assets/writing_small_ic.png'),
                      //postBoxWidget('Activity','assets/smile_small_ic.png'),
                    ],
                  ),
                )
              ],
            ),

            // Row(
            //   children: [
            //     GestureDetector(
            //       child: postBoxWidget('camera', 'assets/photo_small_ic.png'),
            //       onTap: () {
            //         if (files.length >= 5)
            //           showMessage('Post only 5 items');
            //         else
            //           pickImageCamera();
            //       },
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       child: postBoxWidget('Photo', 'assets/picture_small_ic.png'),
            //       onTap: () {
            //         if (files.length >= 5)
            //           showMessage('Post only 5 items');
            //         else
            //           pickImage();
            //       },
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     GestureDetector(
            //       child: postBoxWidget('video', 'assets/video_ic.png'),
            //       onTap: () {
            //         if (files.length >= 5)
            //           showMessage('Post only 5 items');
            //         else
            //           pickVideo();
            //       },
            //     ),
            //   ],
            // ),

            // SizedBox(
            //   height: files.length > 0 ? 50 : 0,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       shrinkWrap: true,
            //       itemCount: files.length,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.all(5),
            //           height: 50,
            //           width: 50,
            //           color: Colors.redAccent,
            //           child: Stack(
            //             clipBehavior: Clip.none,
            //             alignment: Alignment.topRight,
            //             children: [
            //               files[index]["type"] == 'IMAGE'
            //                   ? Image.network(
            //                 Base_URL_group_image + files[index]["name"],
            //                       height: 50,
            //                       width: 50,
            //                       fit: BoxFit.cover,
            //                     )
            //                   : Icon(Icons.video_call),
            //               Positioned(
            //                 child: GestureDetector(
            //                     onTap: () {
            //                       files.removeAt(index);
            //                       setState(() {});
            //                     },
            //                     child: Icon(Icons.cancel_outlined)),
            //                 top: -10,
            //                 right: -10,
            //               )
            //             ],
            //           ),
            //         );
            //       }),
            // ),
          ],
        ),
      ),
    );
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

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 500,
        imageQuality: 100);

    hitUploadImage(File(image!.path), 'POSTIMAGE');
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
