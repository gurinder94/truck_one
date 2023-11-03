import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/chat_screen.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/chat_home_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/chat_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:provider/provider.dart';

import '../../AppUtils/constants.dart';
import '../../Model/ChatModel/ConversationListModel.dart';
import '../commanWidget/custom_image_network_profile.dart';

class ConversationItem extends StatelessWidget {
  late ConversationModel _conversationModel;
  int index;
  ChatHomeProvider proData;

  @override
  ConversationItem(
    this.index,
    this.proData, {
    Key? key,
  });

  @override
  Widget build(BuildContext context) {
    _conversationModel = context.watch<ConversationModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    CustomImageProfile(
                        image: _conversationModel.type == "INDIVIDUAL"
                            ? IMG_URL + _conversationModel.image.toString()
                            : SERVER_URL +
                                '/uploads/event/brand_logo/' +
                                _conversationModel.image.toString(),
                        width: 50,
                        boxFit: BoxFit.cover,
                        height: 50),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          '${_conversationModel.name}',
                          overflow: TextOverflow.ellipsis,
                        )),
                    SizedBox(
                      height: 1,
                    ),
                    Text(
                        _conversationModel.lastMessages!.length == 0
                            ? ''
                            : _conversationModel.lastMessages![0].message!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _conversationModel.type == "GROUP"
                        ? PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: Text(AppLocalizations.instance
                                      .text("Leave Group"))),
                            ],
                            onSelected: (val) {
                              switch (val) {
                                case 1:
                                  _conversationModel.getDeleteGroup(
                                      _conversationModel.conversation_id
                                          .toString(),
                                      index,
                                      proData);
                                  break;
                              }
                            },
                          )
                        : PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: _conversationModel.isBlocked == false
                                      ? Text(AppLocalizations.instance
                                          .text("Block"))
                                      : Text(AppLocalizations.instance
                                          .text("Un-Block"))),
                              PopupMenuItem(
                                  value: 2,
                                  child: Text(AppLocalizations.instance
                                      .text("Delete"))),
                            ],
                            onSelected: (val) {
                              switch (val) {
                                case 2:
                                  _conversationModel.getDeleteConversation(
                                      _conversationModel.conversation_id
                                          .toString(),
                                      index,
                                      proData);
                                  break;
                                case 1:
                                  _conversationModel.getBlockUser(
                                      _conversationModel.conversation_id
                                          .toString(),
                                      _conversationModel.isBlocked == false
                                          ? "BLOCK"
                                          : "UN-BLOCK");
                                  break;
                              }
                            },
                          ),
                    _conversationModel.unReadMsg! > 0
                        ? Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              _conversationModel.unReadMsg.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: const BoxDecoration(
                                color: Colors.blueAccent,
                                shape: BoxShape.circle),
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(5, 5)),
                BoxShadow(
                    color: Colors.white, blurRadius: 4, offset: Offset(-5, -5))
              ]),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                      create: (_) => ChatProvider(
                          _conversationModel.type.toString().toUpperCase(),
                          _conversationModel.isBlocked!),
                      child: ChatPage(
                          conversationId:
                              _conversationModel.conversation_id.toString(),
                          image: _conversationModel.type == "INDIVIDUAL"
                              ? IMG_URL + _conversationModel.image.toString()
                              : SERVER_URL +
                                  '/uploads/event/brand_logo/' +
                                  _conversationModel.image.toString(),
                          name: _conversationModel.name.toString(),
                          userId: _conversationModel.userId == null
                              ? ""
                              : _conversationModel.userId!)))).then((value) {
            proData.listenChat(context);
            proData.resetList();

            proData.getConversations('', false, 1);
          });
        },
      ),
    );
  }
}
