import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:provider/provider.dart';

import '../../commanWidget/Custom_App_Bar_Widget.dart';
import '../../commanWidget/comman_button_widget.dart';
import '../group_post_edit_page/edit_group_provider.dart';
import 'edit_Drop_visibility.dart';

class EditGroupPage extends StatefulWidget {
  String? groupId;

  EditGroupPage(this.groupId);

  @override
  _EditGroupPageState createState() => _EditGroupPageState(groupId);
}

class _EditGroupPageState extends State<EditGroupPage> {
  final ImagePicker _picker = ImagePicker();
  bool uploadFile = false;

  late EditGroupProvider _provider;

  String? groupId;

  _EditGroupPageState(this.groupId);

  @override
  void initState() {
    //

    _provider = _provider = context.read<EditGroupProvider>();

    _provider.getGroupdetails(groupId);
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<EditGroupProvider>();
    _provider.setContext(context);

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text('Edit Group'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: SizedBox(),
        child: SingleChildScrollView(
            child: provider.loading == true
                ? Column(
                    children: [
                      SizedBox(
                        height: 300,
                      ),
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 320,
                        child: Stack(
                          clipBehavior: Clip.antiAlias,
                          children: [
                            Container(
                              // coverImage.contains('CAU')
                              //     ? coverImage
                              //     :
                              height: 270,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: _provider.coverImage == ''
                                      ? DecorationImage(
                                          image: AssetImage(
                                              'icons/productimage.png'),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(
                                            Base_Url_group +
                                                provider.coverImage,
                                          ),
                                          fit: BoxFit.cover)),
                            ),
                            Positioned(
                              bottom: 3,
                              left: 10,
                              child: Container(
                                height: 100,
                                width: 100,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Image.network(
                                  SERVER_URL +
                                      '/uploads/group/' +
                                      provider.profileImage,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : CircularProgressIndicator.adaptive();
                                  },
                                  errorBuilder: (a, b, c) => Center(
                                      child: Text(
                                    'G',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.2),
                                        fontSize: 80,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(0, 5),
                                              blurRadius: 20)
                                        ]),
                                  )),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 80,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    getImageForCover();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                        color: Colors.black,
                                      )),
                                )),
                                      Positioned(
                                          bottom:10,
                                          left: 90,
                                          child: GestureDetector(
                                            onTap: () {
                                              getImageForProfile();
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                  color: Colors.black,
                                                )),
                                          )),


                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            InputShape(
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(50),
                                ],
                                controller: provider.title,
                                maxLength: 150,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: AppLocalizations.instance.text('Title'),
                                    border: InputBorder.none),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputShape(
                              child: Container(
                                height: 100,
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.done,
                                  maxLines: 10,
                                  controller: provider.description,
                                  maxLength: 2000,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      hintText:AppLocalizations.instance.text('Description'),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InputShape(
                              child: EditDropVisibility(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Selector<EditGroupProvider, bool>(
                                selector: (_, provider) =>
                                    provider.updateLoading,
                                builder: (context, loder, child) {
                                  return CommanButtonWidget(
                                    title:AppLocalizations.instance.text('Update'),
                                    buttonColor: PrimaryColor,
                                    titleColor: APP_BG,
                                    onDoneFuction: () async {
                                      if (provider.title.text
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                        showMessage('Please enter group title');
                                      else if (provider.description.text
                                          .toString()
                                          .trim()
                                          .isEmpty)
                                        showMessage(
                                            'Please enter group description');
                                      else {
                                        var getid = await getUserId();
                                        _provider.updateGroup({
                                          "name": provider.title.text
                                              .toString()
                                              .trim(),
                                          "description": provider
                                              .description.text
                                              .toString()
                                              .trim(),
                                          "coverImage": _provider.coverImage,
                                          "userId": getid,
                                          "type": _provider.visibility,
                                          "groupId": groupId,
                                          "groupImage": _provider.profileImage
                                        });
                                      }
                                    },
                                    loder: loder,
                                  );
                                }),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   bottom: 3,
                      //   left: 10,
                      //   child:
                      //
                      //   Container(
                      //     height: 100,
                      //     width: 100,
                      //     clipBehavior: Clip.antiAlias,
                      //     decoration:  BoxDecoration(
                      //         color: Colors.white,
                      //         shape: BoxShape.circle,
                      //         boxShadow: [
                      //           BoxShadow(
                      //               color: Colors.black26,
                      //               blurRadius: 10,
                      //               offset: Offset(0, 5))
                      //         ]),
                      //     child: Image.network(
                      //       profileImage== ""?'':    Base_Url_group +
                      //           profileImage,
                      //       width: 100,
                      //
                      //       height: 100,
                      //       fit: BoxFit.fill,
                      //       loadingBuilder: (context, child, progress) {
                      //         return progress == null
                      //             ? child
                      //             : CircularProgressIndicator.adaptive();
                      //       },
                      //       errorBuilder: (a, b, c) => Center(
                      //           child: Text(
                      //             'G',
                      //             style: TextStyle(
                      //                 color: Colors.black.withOpacity(.2),
                      //                 fontSize: 80,
                      //                 shadows: [
                      //                   BoxShadow(
                      //                       color: Colors.black12,
                      //                       offset: Offset(0, 5),
                      //                       blurRadius: 20)
                      //                 ]),
                      //           )),
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //     bottom: 10,
                      //     left: 95,
                      //
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         getImageForProfile();
                      //       },
                      //       child: Container(
                      //           padding: EdgeInsets.all(5),
                      //           decoration: const BoxDecoration(
                      //               color: Colors.white, shape: BoxShape.circle),
                      //           child: Icon(
                      //             Icons.edit,
                      //             size: 20,
                      //             color: Colors.black,
                      //           )),
                      //     )),
                      // Positioned(
                      //     bottom: 80,
                      //     right: 0,
                      //     child: GestureDetector(
                      //       onTap: () {
                      //         getImageForCover();
                      //       },
                      //       child: Container(
                      //           padding: EdgeInsets.all(5),
                      //           decoration: const BoxDecoration(
                      //               color: Colors.white, shape: BoxShape.circle),
                      //           child: Icon(
                      //             Icons.edit,
                      //             size: 20,
                      //             color: Colors.black,
                      //           )),
                      //     )),
                      // Container(
                      //   // coverImage.contains('CAU')
                      //   //     ? coverImage
                      //   //     :
                      //   height: 300,
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //       image: _provider.coverImage == ''
                      //           ? DecorationImage(
                      //               image: AssetImage('icons/productimage.png'),
                      //               fit: BoxFit.cover)
                      //           : DecorationImage(
                      //               image: NetworkImage(
                      //                 Base_Url_group + provider.coverImage,
                      //               ),
                      //               fit: BoxFit.cover)),
                      //   child: Stack(
                      //     alignment: Alignment.center,
                      //     children: [
                      //       Positioned(
                      //         left: 10,
                      //         top: 50,
                      //         child: IconButton(
                      //             onPressed: () {
                      //               Navigator.pop(context);
                      //             },
                      //             icon: Icon(
                      //               Icons.arrow_back,
                      //               color: Colors.white,
                      //             )),
                      //       ),
                      //       Stack(
                      //         clipBehavior: Clip.none,
                      //         children: [
                      //           Container(
                      //             height: 100,
                      //             width: 100,
                      //             clipBehavior: Clip.antiAlias,
                      //             decoration: const BoxDecoration(
                      //                 color: Colors.white,
                      //                 shape: BoxShape.circle,
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                       color: Colors.black26,
                      //                       blurRadius: 10,
                      //                       offset: Offset(0, 5))
                      //                 ]),
                      //             child: Image.network(
                      //               SERVER_URL+'/uploads/group/' +
                      //                   provider.profileImage,
                      //               fit: BoxFit.fill,
                      //               loadingBuilder: (context, child, progress) {
                      //                 return progress == null
                      //                     ? child
                      //                     : CircularProgressIndicator
                      //                         .adaptive();
                      //               },
                      //               errorBuilder: (a, b, c) => Center(
                      //                   child: Text(
                      //                 'G',
                      //                 style: TextStyle(
                      //                     color: Colors.black.withOpacity(.2),
                      //                     fontSize: 80,
                      //                     shadows: [
                      //                       BoxShadow(
                      //                           color: Colors.black12,
                      //                           offset: Offset(0, 5),
                      //                           blurRadius: 20)
                      //                     ]),
                      //               )),
                      //             ),
                      //           ),
                      //           Positioned(
                      //               bottom: 0,
                      //               right: 0,
                      //               child: GestureDetector(
                      //                 onTap: () {
                      //                   getImageForProfile();
                      //                 },
                      //                 child: Container(
                      //                     padding: EdgeInsets.all(5),
                      //                     decoration: const BoxDecoration(
                      //                         color: Colors.white,
                      //                         shape: BoxShape.circle),
                      //                     child: Icon(
                      //                       Icons.edit,
                      //                       size: 20,
                      //                       color: Colors.black,
                      //                     )),
                      //               )),
                      //         ],
                      //       ),
                      //       Positioned(
                      //           bottom: 20,
                      //           right: 20,
                      //           child: GestureDetector(
                      //             onTap: () {
                      //               getImageForCover();
                      //             },
                      //             child: Container(
                      //                 padding: EdgeInsets.all(5),
                      //                 decoration: const BoxDecoration(
                      //                     color: Colors.white,
                      //                     shape: BoxShape.circle),
                      //                 child: Icon(
                      //                   Icons.edit,
                      //                   size: 20,
                      //                   color: Colors.black,
                      //                 )),
                      //           )),
                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20.0),
                      //   child: Column(
                      //     children: [
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       InputShape(
                      //         child: TextFormField(
                      //           inputFormatters: <TextInputFormatter>[
                      //             LengthLimitingTextInputFormatter(50),
                      //           ],
                      //           controller: provider.title,
                      //           maxLength: 150,
                      //           keyboardType: TextInputType.name,
                      //           textInputAction: TextInputAction.next,
                      //           decoration: InputDecoration(
                      //               counterText: '',
                      //               hintText: 'Title',
                      //               border: InputBorder.none),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       InputShape(
                      //         child: Container(
                      //           height: 100,
                      //           child: TextFormField(
                      //             keyboardType: TextInputType.multiline,
                      //             textInputAction: TextInputAction.done,
                      //             maxLines: 10,
                      //             controller: provider.description,
                      //             maxLength: 2000,
                      //             decoration: InputDecoration(
                      //                 counterText: '',
                      //                 hintText: 'Description',
                      //                 border: InputBorder.none),
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       InputShape(
                      //         child: EditDropVisibility(),
                      //       ),
                      //       SizedBox(
                      //         height: 20,
                      //       ),
                      //       Selector<EditGroupProvider, bool>(
                      //           selector: (_, provider) => provider.updateLoading,
                      //           builder: (context, loder, child) {
                      //             return    CommanButtonWidget(
                      //               title: "Update",
                      //               buttonColor: PrimaryColor,
                      //               titleColor: APP_BG,
                      //               onDoneFuction: () async {
                      //                 if (provider.title.text
                      //                     .toString()
                      //                     .trim()
                      //                     .isEmpty)
                      //                   showMessage('Please enter group title');
                      //                 else if (provider.description.text
                      //                     .toString()
                      //                     .trim()
                      //                     .isEmpty)
                      //                   showMessage('Please enter group description');
                      //                 else {
                      //                   var getid = await getUserId();
                      //                   _provider.updateGroup({
                      //                     "name":
                      //                     provider.title.text.toString().trim(),
                      //                     "description": provider.description.text
                      //                         .toString()
                      //                         .trim(),
                      //                     "coverImage": _provider.coverImage,
                      //                     "userId": getid,
                      //                     "type": _provider.visibility,
                      //                     "groupId": groupId,
                      //                     "groupImage": _provider.profileImage
                      //                   });
                      //                 }
                      //               },
                      //               loder: loder,
                      //             );
                      //           }),
                      //
                      //     ],
                      //   ),
                      // ),
                    ],
                  )));
  }

  Future<void> getImageForProfile() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 100,
        maxWidth: 100,
        imageQuality: 100);
    hitUploadImage(File(image!.path), 'profile');
  }

  Future<void> getImageForCover() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 300,
        maxWidth: 500,
        imageQuality: 100);
    hitUploadImage(File(image!.path), 'cover');
  }

  hitUploadImage(File image, String type) async {
    setState(() {
      uploadFile = true;
    });
    try {
      var postUri = Uri.parse(SERVER_URL + '/api/v1/event/uploads');
      var request = new http.MultipartRequest("POST", postUri);
      request.fields.addAll({"type": 'GROUPIMAGE'});
      request.files.add(http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
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
          String path = jsonData['data']['imagePath'];
          if (type == "profile")
            _provider.profileImage = path;
          else
            _provider.coverImage = path;
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

  void showMessage(String s) {
    final snackBar = SnackBar(content: Text(s));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
