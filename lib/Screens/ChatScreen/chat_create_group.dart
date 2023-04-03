import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/chat_create_group_compoment.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/provider/create_group_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Search_bar.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/custom_image_network_profile.dart';
import 'package:provider/provider.dart';
import '../../AppUtils/constants.dart';
import '../Home/Component/pagination_widget.dart';
import '../commanWidget/Custom_App_Bar_Widget.dart';
import 'chat_home_Page.dart';
import 'provider/chat_home_provider.dart';

class ChatCreateGroup extends StatefulWidget {
  ChatCreateGroup();

  @override
  State<ChatCreateGroup> createState() => _ChatCreateGroupState();
}

class _ChatCreateGroupState extends State<ChatCreateGroup> {
  late CreateGroupProvider _createGroupProvider;

  @override
  void initState() {
    // TODO: implement initState
    _createGroupProvider = context.read<CreateGroupProvider>();

    _createGroupProvider.getMemberList();
    _createGroupProvider.addScrollListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        title: AppLocalizations.instance.text("Add Participants"),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        floatingActionWidget: SizedBox(),
        actions: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Consumer<CreateGroupProvider>(builder: (_, proData, __) {
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    AppLocalizations.instance.text("Next"),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                onTap: () {
                  if (proData.qualificationarray.length != 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                              create: (_) => CreateGroupProvider(),
                              child: ChatCreateGroupCompoment(proData))),
                    ).then((value) {
                      if (value == "Successfully") {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                    create: (_) => ChatHomeProvider(), child: ChatHomePage(1))));
                      }
                    });
                  } else {
                    showMessage("Please select atleast one user");
                  }
                },
              );
            })
          ],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CommanSearchBar(
                onTextChange: (val) {

                    _createGroupProvider.searchFliter(val);

                },
              ),
            ),
            Consumer<CreateGroupProvider>(builder: (_, proData, __) {
              if (proData.load) {
                return Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (proData.list.length == 0)
                return Center(
                    child: Text(
                        AppLocalizations.instance.text("No Record Found")));
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          controller: proData.scrollController,
                          itemCount: proData.list.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
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
                                              image: IMG_URL +
                                                  proData.list[index].image
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
                                          Text(proData.list[index].personName
                                              .toString()),

                                          // Text(_conversation.lastMessages!.length == 0
                                          //     ? ''
                                          //     : _conversation.lastMessages![0].message!),
                                        ],
                                      ),
                                    ),
                                    Checkbox(
                                        value: proData.list[index].isChecked,
                                        onChanged: (val) {
                                          proData.changeValuecheckBox(
                                              proData, index, val);
                                        })
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0xFFEEEEEE),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: 40,
                        child: PaginationWidget(proData.paginationLoder)),
                  ],
                ),
              );
            }),
          ],
        ));
  }
}
//
