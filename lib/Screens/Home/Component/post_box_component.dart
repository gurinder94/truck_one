import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/post_upload_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/post_create_component/Create_Post_Widget.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/user_detail_provider.dart';
import 'package:my_truck_dot_one/Screens/Network/user_profile.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/commanField_widget.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/custom_image_network_profile.dart';

class PostBox extends StatefulWidget {
  PostBox();

  @override
  _PostBoxState createState() => _PostBoxState();
}

class _PostBoxState extends State<PostBox> {
  final ImagePicker _picker = ImagePicker();

  bool enablePost = false, uploadFile = false;
  late PostUploadProvider _provider;

  String? image = '';
  String? Name = '';

  @override
  void initState() {
    // TODO: implement initState
    var provider = context.read<PostUploadProvider>();

    provider.setPostImage();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _provider = context.watch<PostUploadProvider>();
    _provider.setContext(context);

    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 1, left: 7, right: 7),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
        BoxShadow(
          color: Color(0xFFD9D8D8),
          offset: Offset(5.0, 5.0),
          blurRadius: 7,
        ),
        BoxShadow(
          color: Colors.white.withOpacity(.4),
          offset: Offset(-5.0, -5.0),
          blurRadius: 10,
        ),
      ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: CustomImageProfile(
                image: _provider.image == null
                    ? ''
                    : IMG_URL + _provider.image.toString(),
                width: 40,
                boxFit: BoxFit.contain,
                height: 40),
            onTap: () async {
              var getid = await getUserId();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (context) => UserDetailProvider(),
                        child: UserProfile(
                          userId: getid,
                        ),
                      )));
            },
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
                        controller: _provider.textController,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: 14),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(bottom: 10),
                          hintText:
                              AppLocalizations.instance.text("Post Message"),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        onChanged: (val) {
                          val.length > 0
                              ? enablePost = true
                              : enablePost = false;
                          setState(() {});
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => PostUploadProvider(),
                                  child: CreatePostWidget(),
                                ),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: _provider.files.length > 0 ? 70 : 0,
                  child: ListView.builder(
                      itemCount: _provider.files.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                margin: EdgeInsets.all(10),
                                color: Colors.blue,
                                child: Image.network(
                                  Base_URL_group_image +
                                      _provider.files[index]['name'],
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
                                    Icons.video_call_outlined,
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
                )
              ],
            ),
          )
        ],
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
            "name": Base_URL_group_image + jsonData['data']['imagePath']
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
