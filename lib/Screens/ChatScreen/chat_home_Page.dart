import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/Debouncer.dart';
import 'package:my_truck_dot_one/Model/ChatModel/ConversationListModel.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/conversationItem.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/new_conversation_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/new_conversation_screen.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/chat_home_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/create_group_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/PaginationWidget.dart';
import 'package:provider/provider.dart';
import '../../AppUtils/constants.dart';
import '../commanWidget/Custom_App_Bar_Widget.dart';
import '../commanWidget/Search_bar.dart';
import '../commanWidget/SizeConfig.dart';
import 'chat_create_group.dart';
import 'chat_tabber_Screen/chat_tabber.dart';

class ChatHomePage extends StatefulWidget {
  int grouptabber;

  ChatHomePage(this.grouptabber);

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  int? chatTabber;

  int page = 1;

  late ChatHomeProvider _chatHomeProvider;
  Debouncer _debouncer = Debouncer();

  void initState() {
    _chatHomeProvider = context.read<ChatHomeProvider>();

    _chatHomeProvider.resetList();

    _chatHomeProvider.listenChat(context);
    _chatHomeProvider.getConversations('', false, _chatHomeProvider.page);

    _chatHomeProvider.addScrollListener(context, _chatHomeProvider.model);
    chatTabber = widget.grouptabber;
    _chatHomeProvider.groupTabber = widget.grouptabber;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return CustomAppBarWidget(
        title: AppLocalizations.instance.text("Chat"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: Selector<ChatHomeProvider, int>(
            selector: (_, provider) => provider.groupTabber,
            builder: (context, paginationLoading, child) {
              return paginationLoading == 2
                  ? SizedBox()
                  : FloatingActionButton(
                      // isExtended: true,
                      child: Icon(Icons.add),
                      backgroundColor: PrimaryColor,
                      onPressed: () {
                        switch (chatTabber) {
                          case 0:
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    NewConversationProvider(),
                                                child:
                                                    NewConversationScreen())))
                                .then((value) {
                              _chatHomeProvider.resetList();
                              _chatHomeProvider.getConversations(
                                  '', false, _chatHomeProvider.page);
                            });

                            break;
                          case 1:
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                                create: (_) =>
                                                    CreateGroupProvider(),
                                                child: ChatCreateGroup())))
                                .then((value) {
                              _chatHomeProvider.listenChat(context);
                              _chatHomeProvider.resetList();
                              _chatHomeProvider.getConversations('', false, _chatHomeProvider.page);
                            });
                        }
                      },
                    );
            }),
        actions: SizedBox(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizeConfig.screenHeight! < 1010
              ? SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 15
                      : SizeConfig.safeBlockVertical! * 12, //10 for example
                )
              : SizedBox(
                  height: Platform.isIOS
                      ? SizeConfig.safeBlockVertical! * 8
                      : SizeConfig.safeBlockVertical! * 9, //10 for example
                ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: CommanSearchBar(onTextChange: (val) {
                    _chatHomeProvider.getConversations(
                        val, false, _chatHomeProvider.page);
                  }),
                ),
              ],
            ),
          ),
          Selector<ChatHomeProvider, bool>(
              selector: (_, provider) => provider.loading,
              builder: (context, loading, child) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IgnorePointer(
                    ignoring: loading,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChatTabber(
                          title: AppLocalizations.instance.text("Chats"),
                          pos: 0,
                          onClick: () {
                            chatTabber = 0;
                            _chatHomeProvider.list.clear();
                            _chatHomeProvider.page = 1;
                            _chatHomeProvider.getConversations(
                                '', false, _chatHomeProvider.page);
                          },
                        ),
                        ChatTabber(
                          title: AppLocalizations.instance.text("Groups"),
                          pos: 1,
                          onClick: () {
                            chatTabber = 1;
                            _chatHomeProvider.list.clear();
                            _chatHomeProvider.page = 1;
                            _chatHomeProvider.getConversations(
                                '', false, _chatHomeProvider.page);
                          },
                        ),
                        ChatTabber(
                          title: AppLocalizations.instance.text("Seller"),
                          pos: 2,
                          onClick: () {
                            chatTabber = 2;
                            _chatHomeProvider.list.clear();
                            _chatHomeProvider.page = 1;
                            _chatHomeProvider.getConversations(
                                '', false, _chatHomeProvider.page);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          Consumer<ChatHomeProvider>(builder: (_, proData, __) {
            if (proData.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: proData.list.length == 0
                          ? chatTabber == 0
                              ? Center(
                                  child: Text(
                                      'Click on "Add icon" to start a new conversation'))
                              : chatTabber == 1
                                  ? Center(
                                      child: Text(
                                          'Click on "Add icon" to create a new Group'))
                                  : Center(child: Text('No Conversation'))
                          : ListView.builder(
                              itemCount: proData.list.length,
                              controller: proData.scrollController,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                return ChangeNotifierProvider<
                                        ConversationModel>.value(
                                    value: proData.list[index],
                                    child: ConversationItem(
                                      index,
                                      proData,
                                    ));
                              })),
                  PaginationWidget(proData.paginationLoder),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            );
          }),
        ]));
  }
}
