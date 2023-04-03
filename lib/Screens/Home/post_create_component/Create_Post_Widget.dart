import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';

import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../Provider/post_upload_provider.dart';

class CreatePostWidget extends StatefulWidget {
  @override
  State<CreatePostWidget> createState() => _CreatePostWidgetState();
}

class _CreatePostWidgetState extends State<CreatePostWidget> {
  final ImagePicker _picker = ImagePicker();

  bool enablePost = false, uploadFile = false;

  late PostUploadProvider _provider;

  String? image = '';

  @override
  void initState() {
    // TODO: implement initState
    var provider = context.read<PostUploadProvider>();

    provider.setPostImage();
  }

  Widget build(BuildContext context) {
    _provider = context.watch<PostUploadProvider>();
    _provider.setContext(context);
    return CustomAppBarWidget(
        leading: GestureDetector(child
            : Icon(Icons.arrow_back),onTap: ()
          {
            Navigator.pop(context);
          },),
        title:  AppLocalizations.instance.text('createPost'),
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
              children: [
                Container(
                  width: 50,
                  height: 50,
                  child: CustomImageProfile(
                      image: IMG_URL + _provider.image.toString(),
                      width: 80,
                      boxFit: BoxFit.fill,
                      height: 80),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _provider.Name.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: InputTextField(
                  child: TextFormField(
                    controller: _provider.textController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:AppLocalizations.instance.text('Post Message'),
                    contentPadding: EdgeInsets.only(top: 15)),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (val) {
                      val.length > 0 ? enablePost = true : enablePost = false;
                      setState(() {});
                    },
              ),

              ),
            ),
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
                    if (_provider.files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickImageCamera();
                  },
                ),
                GestureDetector(
                  child: postBoxWidget('Photo', 'assets/picture_small_ic.png'),
                  onTap: () {
                    if (_provider.files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickImage();
                  },
                ),
                GestureDetector(
                  child: postBoxWidget('Video', 'assets/video_ic.png'),
                  onTap: () {
                    if (_provider.files.length >= 5)
                      showMessage('Post only 5 items');
                    else
                      pickVideo();
                  },
                ),
                Selector<PostUploadProvider, bool>(
                    selector: (_, provider) => provider.loading,
                    builder: (context, loder, child) {
                      return loder == true
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                if (_provider.textController.text
                                    .trim()
                                    .isEmpty)
                                  showMessage('Please enter caption');
                                else
                                  uploadPost();
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width / 5,
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.center,
                                decoration:  BoxDecoration(
                                    color:PrimaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(0, 5))
                                    ]),
                                child:  Text(
                                  AppLocalizations.instance.text('post'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
              height: _provider.files.length > 0 ? 70 : 0,
              alignment: Alignment.topLeft,
              child: ListView.builder(
                  itemCount: _provider.files.length,
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
                              Base_URL_group_image + _provider.files[index]['name'],
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
                                _provider.files[index]['type'] == "IMAGE"
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
                                _provider.files.removeAt(index);
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
        maxHeight: 600,
        maxWidth: 600,
        imageQuality: 100);
    hitUploadImage(File(image!.path), 'POSTIMAGE');
  }

  Future<void> pickVideo() async {
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    hitUploadImage(File(image!.path), 'POSTVIDEO');
  }

  Future<void> pickImageCamera() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );
    hitUploadImage(File(image!.path), 'POSTIMAGE');
  }

  hitUploadImage(File image, String type) async {
    setState(() {
      uploadFile = true;
    });
    try {
      var postUri = Uri.parse(type == 'POSTIMAGE'
          ? SERVER_URL + '/api/v1/post/uploadImage'
          : SERVER_URL + '/api/v1/post/uploadVideo');
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
        String value = await utf8.decoder.bind(response.stream).join();
        var jsonData = json.decode(value);

        if (jsonData['code'] != 200) {
          showMessage(jsonData['message']);
          setState(() {
            uploadFile = false;
          });
        } else {
          _provider.files.add({
            "type": type == "POSTIMAGE" ? 'IMAGE' : "VIDEO",
            "name": jsonData['data']['imagePath']
          });

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

  void showMessage(parseData) {
    final snackBar = SnackBar(content: Text(parseData));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> uploadPost() async {
    var getid = await getUserId();

    _provider.postUpload({
      "caption": _provider.textController.text,
      "postedById": getid,
      "media": _provider.files,
      "type": "INDIVIDUAL",
    });
  }
}
