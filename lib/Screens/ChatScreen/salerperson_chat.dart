import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Model/ChatModel/ConversationListModel.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/Seller_Chat_Screen/seller_chat_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/Seller_Chat_Screen/seller_conversation_item.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/chat_create_group.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/chat_tabber_Screen/chat_tabber.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/new_conversation_provider.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/new_conversation_screen.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/create_group_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Search_bar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:provider/provider.dart';

import '../commanWidget/PaginationWidget.dart';

class SalePerson extends StatelessWidget {
  late SellerChatProvider _sellerChatProvider;

  @override
  Widget build(BuildContext context) {
    _sellerChatProvider = context.read<SellerChatProvider>();

    SizeConfig().init(context);

    return CustomAppBarWidget(
      title: AppLocalizations.instance.text('Chat'),
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.pop(context);
        },
      ),
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
        Selector<SellerChatProvider, bool>(
            selector: (_, provider) => provider.loading,
            builder: (context, loder, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IgnorePointer(
                  ignoring: loder,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChatTabber(
                        title: AppLocalizations.instance.text("Chats"),
                        pos: 0,
                        onClick: () {
                          _sellerChatProvider.setClick(0);
                          _sellerChatProvider.reset();
                        },
                      ),
                      ChatTabber(
                        title: "Group",
                        pos: 1,
                        onClick: () {
                          _sellerChatProvider.setClick(1);
                          _sellerChatProvider.reset();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(child: CommanSearchBar(onTextChange: (val) {
                _sellerChatProvider.search(val);
              })),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Consumer<SellerChatProvider>(builder: (_, proData, __) {
          if (proData.loading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else
            return proData.list.length == 0
                ? Center(child: Text('No Record Found'))
                : Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: proData.scrollController,
                        itemCount: proData.list.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return ChangeNotifierProvider<
                              ConversationModel>.value(
                              value: proData.list[index],
                              child:
                              SellerConversationItem(proData, index,));
                        }),
                  ),
                  PaginationWidget(proData.paginationLoder),
                ],
              ),
            );
        }),
        //
      ]),
      floatingActionWidget: Selector<SellerChatProvider, int>(
          selector: (_, provider) => provider.groupTabber,
          builder: (context, paginationLoading, child) {
            return paginationLoading != 1
                ? FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.add),
              backgroundColor: PrimaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider(
                                create: (_) => NewConversationProvider(),
                                child: NewConversationScreen())))
                    .then((value) {
                  _sellerChatProvider.reset();
                });
              },
            )
                : FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.add),
              backgroundColor: PrimaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider(
                                create: (_) =>
                                    CreateGroupProvider(),
                                child: ChatCreateGroup())))
                    .then((value) {
                  _sellerChatProvider.reset();
                });
              },
            );
          }),
      actions: SizedBox(),
    );
  }
}