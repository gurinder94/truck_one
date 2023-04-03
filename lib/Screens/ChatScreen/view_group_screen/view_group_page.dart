import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/Screens/ChatScreen/view_group_screen/view_group_chat_provider/chat_view_group_provider.dart';
import 'package:provider/provider.dart';
import '../../../AppUtils/constants.dart';
import '../../commanWidget/custom_image_network_profile.dart';
import 'Edit_group_View.dart';
import 'chat_group_view_member_list.dart';
import 'chat_group_view_setting_component.dart';

class ViewGroupPage extends StatefulWidget {
  String conversationId;

  ViewGroupPage(
    this.conversationId, {
    Key? key,
  });

  @override
  State<ViewGroupPage> createState() => _ViewGroupPageState();
}

class _ViewGroupPageState extends State<ViewGroupPage> {

  late ChatViewGroupProvider _chatViewGroupProvider;
  // double value = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chatViewGroupProvider = context.read<ChatViewGroupProvider>();
    _chatViewGroupProvider.setConversation(widget.conversationId);

    _chatViewGroupProvider.getGroupViewDeatil();
    _chatViewGroupProvider.backgroundvisible=0.0;
   _chatViewGroupProvider.scrollListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: APP_BG,

        body: Consumer<ChatViewGroupProvider>(builder: (_, proData, __) {
          if (proData.loder) {
            return Center(child: CircularProgressIndicator());
          }
         else  if (proData.chatGroupViewModel==null) {
            return Center(child: CircularProgressIndicator());
          }
          else if (proData.chatGroupViewModel!.data!.membersData!.length == 0)
            return Center(child: Text('No Record Found'));
          else {
            return CustomScrollView(
              controller: _chatViewGroupProvider.scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  backgroundColor: proData.backgroundvisible < 150.4? APP_BG:Colors.transparent,
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: proData.backgroundvisible  < 150.4 ? Colors.black : Colors.white),
                      onPressed: () => Navigator.pop(context, false)),
                  expandedHeight: 200,
                  actions: [
                    proData.memberDatumList[0].isAdmin== true
                        ? PopupMenuButton<int>(
                      icon: Icon(Icons.more_vert,
                          color: proData.backgroundvisible  < 150.4
                              ? Colors.black
                              : Colors.white),
                      onSelected: (item) => handleClick(item, proData),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Text('Edit')),
                      ],
                    ):
                         proData.editGroup == true?
                      SizedBox():    PopupMenuButton<int>(
                           icon: Icon(Icons.more_vert,
                               color: proData.backgroundvisible < 150.4
                                   ? Colors.black
                                   : Colors.white),
                           onSelected: (item) =>
                               handleClick(item, proData),
                           itemBuilder: (context) => [
                             PopupMenuItem<int>(
                                 value: 0, child: Text('Edit')),
                           ],
                         ),
                  ],
                  flexibleSpace: Padding(
                    padding:  proData.backgroundvisible  < 150.4 ?  EdgeInsets.all(8.0):EdgeInsets.all(0.0),
                    child: Container(

                      child: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          _chatViewGroupProvider.chatGroupViewModel!.data!.name
                              .toString(),
                          style: TextStyle(
                              color:
                              proData.backgroundvisible  < 150.4 ? Colors.black : Colors.white),
                        ),
                        background: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            CustomImageProfile(
                                image: _chatViewGroupProvider
                                            .chatGroupViewModel!.data!.image ==
                                        null
                                    ? ''
                                    : SERVER_URL +
                                        '/uploads/event/brand_logo/' +
                                        _chatViewGroupProvider
                                            .chatGroupViewModel!.data!.image
                                            .toString(),
                                width: 100,
                                boxFit: BoxFit.contain,
                                height: 100),

                            // Text("Group Name"),
                            // SizedBox(height: 5,),
                            // Text("10 Member"),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color:
                          proData.backgroundvisible < 150.4 ? Color(0xFFEEEEEE) : PrimaryColor,
                          borderRadius:proData.backgroundvisible  < 150.4?BorderRadius.all(Radius.circular(0)):   BorderRadius.only(
                      bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),


                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                offset: Offset(5, 5)),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(-5, -5))
                          ]),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                    child: ChatGroupSettingComponent(_chatViewGroupProvider)),
                SliverToBoxAdapter(
                    child: ChatGroupViewLower(_chatViewGroupProvider, proData))
              ],
            );
          }
        }));
  }

  // void scrollListener() {
  //   scrollController.addListener(() {
  //     setState(() {
  //       value = scrollController.offset;
  //     });
  //   });
  // }

  handleClick(int item, ChatViewGroupProvider proData) {
    switch (item) {
      case 0:
        return showDialog(
            context: context,
            builder: (_) => Dialog(
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: EditGroupView(proData)));
    }
  }
}
