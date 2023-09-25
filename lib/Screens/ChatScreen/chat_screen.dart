import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ShowErrorMessage.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/chat_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_page.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Comman_Alert_box.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/input_shape.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../AppUtils/constants.dart';
import '../../Model/ChatModel/ConversationListModel.dart';
import '../../Model/ChatModel/MessageModel.dart';
import '../commanWidget/loading_widget.dart';

class ChatPage extends StatelessWidget {
  String conversationId, image, name, userId;

  ChatPage({
    required this.conversationId,
    required this.image,
    required this.name,
    required this.userId,
  });

  late ChatProvider _chatProvider;
  ScrollController scrollController = ScrollController();
  var ChatUrl = SERVER_URL + "/uploads/chatImages/";

  @override
  Widget build(BuildContext context) {
    _chatProvider = context.read<ChatProvider>();
    _chatProvider.role();
    _chatProvider.msgList.clear();
    _chatProvider.listenChat(context, conversationId);
    _chatProvider.getMessages(conversationId);
    _chatProvider.setContext(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          backgroundColor: APP_BAR_BG,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          elevation: 0.0,
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(3),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: 45,
                    height: 45,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : SizedBox(
                              width: 45,
                              height: 45,
                              child: Center(
                                  child: LoadingWidget(((progress
                                                  .cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!) *
                                          100)
                                      .toInt())),
                            );
                    },
                    errorBuilder: (a, b, c) => Center(
                      child: Image.asset(
                        'icons/bannerProfile.png',
                        fit: BoxFit.cover,
                        width: 45,
                        height: 45,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    _chatProvider.type == "GROUP"
                        ? Text(
                            'tab to here for  group info',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          )
                        : SizedBox()
                  ],
                ),
                onTap: () {
                  _chatProvider.type == "GROUP"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewGroupPage(conversationId)))
                      : SizedBox();
                },
              )
            ],
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Consumer<ChatProvider>(
                builder: (context, val, child) => val.connection
                    ? const Icon(
                        Icons.wifi,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.wifi_off_outlined,
                        color: Colors.redAccent,
                      ),
              ),
            )
          ],
        ),
        body: Consumer<ChatProvider>(builder: (_, proData, __) {
          if (proData.loadMessages) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (proData.msgList.length != 0) {
            Future.delayed(Duration(milliseconds: 500), () {
              //   scrollController.animateTo(
              //       // scrollController.position.maxScrollExtent,
              //       // duration: Duration(milliseconds: 100),
              //       // curve: Curves.fastOutSlowIn);
              //
              // });
              scrollController.animateTo(
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
              );
            });
          }
          return Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Expanded(
                child: proData.msgList.length == 0
                    ? Center(child: Text('No Record Found'))
                    : ListView.builder(
                        itemCount: proData.msgList.length,
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          MessageModel mm = proData.msgList[index];

                          return Align(
                            alignment: (proData.userId != mm.senderId)
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: (proData.userId != mm.senderId)
                                      ? APP_BAR_BG
                                      : Colors.blue,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: (proData.userId != mm.senderId)
                                            ? Colors.black12
                                            : Colors.black12,
                                        blurRadius: 5,
                                        offset: Offset(5, 5))
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  final matcher = new RegExp(
                                      r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");
                                  return matcher.hasMatch(mm.message.toString())
                                      ? _launchURL(mm.message.toString())
                                      : mm.document!.length == 0
                                          ? SizedBox()
                                          : _launchURL(ChatUrl +
                                              mm.document.toString().substring(
                                                  1,
                                                  mm.document
                                                          .toString()
                                                          .length -
                                                      1));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RegExp(r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)")
                                              .hasMatch(mm.message.toString())
                                          ? Text(
                                              mm.message.toString(),
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  decoration:
                                                      TextDecoration.underline),
                                            )
                                          : Text(
                                              mm.message.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                      mm.document!.length == 0
                                          ? SizedBox(
                                              height: 5,
                                            )
                                          : SizedBox(
                                              height: 5,
                                            ),
                                      mm.document!.length == 0
                                          ? SizedBox()
                                          : Image.network(
                                              ChatUrl +
                                                  mm.document
                                                      .toString()
                                                      .substring(
                                                          1,
                                                          mm.document
                                                                  .toString()
                                                                  .length -
                                                              1),
                                              fit: BoxFit.cover,
                                              width: 100,
                                              height: 100,
                                              loadingBuilder:
                                                  (context, child, progress) {
                                                return progress == null
                                                    ? child
                                                    : SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      );
                                              },
                                              errorBuilder: (a, b, c) =>
                                                  Container(
                                                width: 50,
                                                height: 50,
                                                child: Center(
                                                    child: Icon(
                                                        Icons.picture_as_pdf)),
                                              ),
                                            ),
                                      mm.document!.length == 0
                                          ? SizedBox(
                                              height: 5,
                                            )
                                          : SizedBox(
                                              height: 5,
                                            ),
                                      Text(
                                        '${mm.userData!.firstName} ${DateFormat('hh:mm aa').format(mm.msgTime!.toLocal())}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              ),
              proData.model.data!.onlyAdminCanMessage == true
                  ? proData.model.data!.isAdmin == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InputShape(
                                  child: TextFormField(
                                    controller: _chatProvider.messageController,
                                    onChanged: (val) {},
                                    decoration: InputDecoration(
                                        hintText: 'write message here...',
                                        border: InputBorder.none,
                                        prefixIcon: IconButton(
                                            onPressed: () async {
                                              openImagePicker(_chatProvider);
                                            },
                                            icon: Icon(
                                                proData.documentName == ""
                                                    ? Icons.attach_file
                                                    : Icons.image))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  height: 50,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      if (_chatProvider.blockUser == true) {
                                        DialogUtils.AlertBox(
                                          context,
                                          onDoneFunction: () async {
                                            _chatProvider.getBlockUser(
                                                conversationId, "UN-BLOCK");
                                            Navigator.pop(context);
                                          },
                                          oncancelFunction: () =>
                                              Navigator.pop(context),
                                          title: 'Unblock!',
                                          buttonTitle: "UnBlock",
                                          secondBtnText: "Cancel",
                                          alertTitle:
                                              "Unblock $name to send a message ",
                                        );
                                      } else {
                                        if (_chatProvider.messageController.text
                                                .toString()
                                                .trim()
                                                .isNotEmpty ||
                                            _chatProvider
                                                .documentName.isNotEmpty) {
                                          _chatProvider.sendMessage();
                                        }
                                      }
                                    },
                                    child: Icon(Icons.send),
                                    backgroundColor: APP_BAR_BG,
                                  ))
                            ],
                          ),
                        )
                      : Text(
                          "Only admins can message",
                          style: TextStyle(
                              color: PrimaryColor, fontWeight: FontWeight.w800),
                        )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: InputShape(
                            child: TextFormField(
                              controller: _chatProvider.messageController,
                              onChanged: (val) {},
                              decoration: InputDecoration(
                                  hintText: 'write message here...',
                                  border: InputBorder.none,
                                  prefixIcon: proData.loading
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircularProgressIndicator(),
                                        )
                                      : proData.documentName == ""
                                          ? proData.roleName == "SELLER" ||
                                                  proData.roleName ==
                                                      "SALERPERSON"
                                              ? PopupMenuButton(
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          [
                                                    PopupMenuItem(
                                                        value: 1,
                                                        child: Text(AppLocalizations
                                                            .instance
                                                            .text(
                                                                "Attachment"))),
                                                    PopupMenuItem(
                                                        value: 2,
                                                        child: Text(
                                                            AppLocalizations
                                                                .instance
                                                                .text(
                                                                    "SellerRating"
                                                                    ""
                                                                    ""
                                                                    ""))),
                                                  ],
                                                  onSelected: (val) {
                                                    switch (val) {
                                                      case 1:
                                                        openImagePicker(
                                                            _chatProvider);
                                                        break;

                                                      case 2:
                                                        _chatProvider
                                                            .getSellerRatingToken(
                                                                userId);
                                                    }
                                                  },
                                                )
                                              : IconButton(
                                                  onPressed: () async {
                                                    openImagePicker(
                                                        _chatProvider);
                                                  },
                                                  icon: Icon(
                                                      proData.documentName == ""
                                                          ? Icons.attach_file
                                                          : Icons.image))
                                          : Icon(Icons.image)),
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              height: 50,
                              child: FloatingActionButton(
                                onPressed: () {
                                  if (_chatProvider.blockUser == true) {
                                    DialogUtils.AlertBox(
                                      context,
                                      onDoneFunction: () async {
                                        _chatProvider.getBlockUser(
                                            conversationId, "UN-BLOCK");
                                        Navigator.pop(context);
                                      },
                                      oncancelFunction: () =>
                                          Navigator.pop(context),
                                      title: 'Unblock!',
                                      buttonTitle: "UnBlock",
                                      secondBtnText: "Cancel",
                                      alertTitle:
                                          "Unblock $name to send a message ",
                                    );
                                  } else {
                                    if (_chatProvider.messageController.text
                                            .toString()
                                            .trim()
                                            .isNotEmpty ||
                                        _chatProvider.documentName.isNotEmpty) {
                                      _chatProvider.sendMessage();
                                    }

                                    // if (_provider.messageController.text
                                    //     .toString()
                                    //     .trim()
                                    //     .isEmpty)
                                    //   return;
                                    // else
                                  }
                                },
                                child: Icon(Icons.send),
                                backgroundColor: APP_BAR_BG,
                              ))
                        ],
                      ),
                    ),
              SizedBox(
                height: 10,
              )
            ],
          );
        }));
  }
}

_launchURL(
  String url_chat,
) async {
  print(url_chat);
  var url = url_chat;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

openImagePicker(ChatProvider chatProvider) async {
  if (Platform.isAndroid) {
    chatProvider.getChatAttachment();
  } else {
    final serviceStatus = await Permission.storage.isGranted;

    bool isCameraOn = serviceStatus == ServiceStatus.enabled;
    final status = await Permission.storage.request();
    if (status == PermissionStatus.granted) {
      print('Permission Granted');
      chatProvider.getChatAttachment();
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }
}
