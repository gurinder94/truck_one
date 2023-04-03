import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/Home/Component/pagination_widget.dart';
import 'package:my_truck_dot_one/Screens/Network/Provider/send_group_post_provider.dart';
import 'package:provider/provider.dart';
import '../Provider/group_provider.dart';
import 'GroupComponent/about_group.dart';
import 'GroupComponent/group_header.dart';
import 'GroupComponent/group_post_box.dart';


class ViewGroup extends StatefulWidget {
  String gId;

  ViewGroup({required this.gId});

  @override
  _ViewGroupState createState() => _ViewGroupState(gId);
}

class _ViewGroupState extends State<ViewGroup> {
  late GroupProvider _provider;
  String gId;
  String? id;
// int pagee=1;
  _ViewGroupState(this.gId);
  ScrollController scrollController= new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _provider = context.read<GroupProvider>();
    _provider.setContext(context,gId);


    _provider.getGroupDetail(gId,false,1);
  }

  @override
  Widget build(BuildContext context) {
    _provider.addScrollListener( context,gId);
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        body: Consumer<GroupProvider>(
              builder: (context, noti, child) {
                return
                 noti.loading==true?Center(child: CircularProgressIndicator()): GroupHeader(
                    gId,
                    aboutWidget:


                    AboutGroup(
                        noti.model.data!.isMember.toString(),gId),
                    createPostWidget: noti.model.data!.isMember == true
                        ? ChangeNotifierProvider(
                      create: (context) => GroupPostSendProvider(),
                      child: GroupPostBox(gId,_provider),
                    )
                        : SizedBox(),
                    scrollController: scrollController,
                     PaginationLoader: PaginationWidget(noti.paginationLoading),
                  );


              }
          ),
        );

  }

  getId() async {
    id = await getUserId();
  }
  pagnationList(BuildContext context, int pagee) async {
    _provider.getGroupDetail( gId,  true,pagee);
  }

  // addScrollListener(BuildContext context) {
  //   scrollController.addListener(() {
  //     if (scrollController.position.maxScrollExtent ==
  //         scrollController.position.pixels) {
  //       pagee = pagee + 1;
  //       if (_provider.model.data!.postData!.length== 0) {
  //         showMessage(
  //           "No Records Found",
  //         );
  //       } else {
  //         pagnationList(context, pagee);
  //       }
  //       // Perform event when user reach at the end of list (e.g. do Api call)
  //
  //     }
  //   });
  // }
}
