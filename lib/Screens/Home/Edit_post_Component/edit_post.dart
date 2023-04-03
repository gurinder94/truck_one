import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_truck_dot_one/Model/NetworkModel/post_list_model.dart';
import 'package:my_truck_dot_one/Screens/Home/Provider/home_page_list_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../../../AppUtils/UserInfo.dart';
import '../../../AppUtils/constants.dart';
import '../Provider/post_edit_provider.dart';
import '../../commanWidget/comman_video_play.dart';

class EditPost extends StatefulWidget {
  PostItem item;
  HomePageListProvider listProvider;
  String type;

  EditPost(this.item, this.listProvider, this.type, {Key? key})
      : super(key: key);

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  bool enablePost = false, uploadFile = false;

  late PostEditProvider _provider;
  final ImagePicker _picker = ImagePicker();

  late VideoPlayerController _controller;

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setData();
    });

  }

  @override
  Widget build(BuildContext context) {
    _provider = context.watch<PostEditProvider>();
    _provider.setContext(context);


    return CustomAppBarWidget(
        leading: IconButton(
            onPressed: () {

              Navigator.pop(context);
            },
            icon: Icon(
              Icons.cancel,
              size: 20,
            )),
        title: AppLocalizations.instance.text("Edit Post"),

        actions: Row(
          children: [
            GestureDetector(
              child: Text(
                AppLocalizations.instance.text("Post"),

              ),
              onTap: ()
              async {
                if (_provider.textController.text
                    .trim()
                    .isEmpty)
                  showMessage('Please enter caption');
                else {
                  var getid = await getUserId();
                  _provider.updatePost({
                    'postId': widget.item.id,
                    'caption': _provider.textController.text,
                    'type': 'INDIVIDUAL',
                    'media': _provider.files,
                    'userId': getid,
                  }, widget.listProvider);
                }
              }
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Row(
                  children: [
                    CustomImageProfile(
                      width: 50,
                      boxFit: BoxFit.cover,
                      height: 50,
                      image:   IMG_URL +widget.item.userData!.image.toString(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.item.userData!.personName.toString()),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  child: InputShape(
                    child: TextFormField(
                      controller: _provider.textController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 14),
                      decoration:  InputDecoration(
                        hintText:  AppLocalizations.instance.text("Write something here..."),
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      minLines: 2,
                    ),
                  ),
                ),
                uploadFile || _provider.loading
              ? LinearProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.black,
            minHeight: 1,
          )
              : SizedBox(),

                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        child: postBoxWidget(
                            'camera', 'assets/photo_small_ic.png'),
                        onTap: () {
                          pickImageCamera();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        child: postBoxWidget(
                            'Photo', 'assets/picture_small_ic.png'),
                        onTap: () {
                          pickImage();
                        }),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      child: postBoxWidget('video', 'assets/video_ic.png'),
                      onTap: () {
                        pickVideo();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: _provider.files.length > 0 ? 400 : 0,
                  height: _provider.files.length > 0 ? 400 : 0,
                  child: ListView.builder(
                      itemCount: _provider.files.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (BuildContext context, int index) {
                        print(  _provider.files[index].type=="IMAGE"?   SERVER_URL +
                            '/uploads/post/image/'+_provider.files[index].name.toString()
                            :
                        SERVER_URL+'/uploads/post/video/' +_provider.files[index].name.toString());
                        return Container(
                          width: 308,
                          height: 300,
                          child: Stack(
                            clipBehavior: Clip.antiAlias,
                            children: [
                              _provider.files[index].type=="IMAGE"?        Container(
                                width: 280,
                                height: 280,
                                decoration: BoxDecoration(
                                  color: Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(

                                   SERVER_URL +
                                        '/uploads/post/image/'+_provider.files[index].name.toString()
                                   ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ):  CommanVideoView(_provider.files[index].name.toString()),


                              Positioned(
                                  right:25,
                                  top: 0,
                                  child: GestureDetector(
                                    child: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    onTap: () {
                                      _provider.files.removeAt(index);
                                      setState(() {});
                                    },
                                  )),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
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

  void setData() {
    _provider.textController.text = widget.item.caption.toString();
    _provider.files = widget.item.media!;
    setState(() {});
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    hitUploadImage(File(image!.path), 'POSTIMAGE');
  }

  Future<void> pickVideo() async {
    final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    hitUploadImage(File(image!.path), 'POSTVIDEO');
  }

  Future<void> pickImageCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
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
        print('Response body: $jsonData');
        if (jsonData['code'] != 200) {
          showMessage(jsonData['message']);
          setState(() {
            uploadFile = false;
          });
        } else {
          showMessage(jsonData['message']);
          _provider.files.add(Media(
              type: type == 'POSTIMAGE' ? 'IMAGE' : 'VIDEO',
              name: jsonData['data']['imagePath']));

          print( SERVER_URL+'/uploads/post/video/' +jsonData['data']['imagePath']);
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
}
