import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/Seller_Chat_Screen/seller_conversation_item.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/new_conversation_provider.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Search_bar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/SizeConfig.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';

class NewConversationScreen extends StatelessWidget {
  late NewConversationProvider _newConversationProvider;

  @override
  Widget build(BuildContext context) {
    _newConversationProvider = context.read<NewConversationProvider>();
    SizeConfig().init(context);
    return CustomAppBarWidget(
      title: AppLocalizations.instance.text('New Conversation'),
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

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(child: CommanSearchBar(onTextChange: (val) {
                _newConversationProvider.searchText(val);
              })),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        Consumer<NewConversationProvider>(builder: (_, proData, __) {
          if (proData.loading) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else
            return proData.list.length == 0
                ? Center(child: Text('No Record Found'))
                : Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  // controller: proData.scrollController,
                                  itemCount: proData.list.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GestureDetector(
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    CustomImageProfile(
                                                        image: IMG_URL +
                                                            proData.list[index]
                                                                .driverImage
                                                                .toString(),
                                                        width: 50,
                                                        boxFit: BoxFit.contain,
                                                        height: 50),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        '${proData.list[index].personName}'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFFEEEEEE),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(5, 5)),
                                                BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 4,
                                                    offset: Offset(-5, -5))
                                              ]),
                                        ),
                                        onTap: () {
                                          if (isRedundentClick(DateTime.now())) {
                                            print('hold on, processing');
                                            return;
                                          }
                                          _newConversationProvider
                                              .addChatList(proData.list[index]);
                                          // chatHomeProvider.addChatConversation("conversationId", "image", [], "name", "type", 1);
                                        },
                                      ),
                                    );
                                  }),
                            ),
                            PaginationWidget(proData.PaginationLoder),
                          ],
                        ),
                        proData.newloading
                            ? Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                            )
                            : Container()
                      ],
                    ),
                  );
        }),
        //
      ]),
      floatingActionWidget: SizedBox(),
      actions: SizedBox(),
    );
  }
}
