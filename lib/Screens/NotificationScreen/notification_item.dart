import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/UserInfo.dart';
import 'package:my_truck_dot_one/Screens/EventScreen/ViewEventScreen/Provider/UserViewEventProvider.dart';
import 'package:my_truck_dot_one/Screens/JobScreen/ViewJob/Provider/JobviewProvider.dart';
import 'package:my_truck_dot_one/Screens/Network/network_page/network_provider.dart';
import 'package:my_truck_dot_one/Screens/NotificationScreen/Provider/notificationProvider.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/seller_question_screen.dart';
import 'package:my_truck_dot_one/Screens/team_manage_Screen%20/company_team_manage/Provider/team_manger_provider.dart';
import 'package:provider/provider.dart';
import '../../AppUtils/constants.dart';
import '../../Model/NotificationModel/NotificationModel.dart';
import '../EventScreen/ViewEventScreen/ViewEvent.dart';
import '../Home/Provider/like_provider.dart';
import '../Home/like_component/like_list.dart';
import '../JobScreen/ViewJob/ViewJob.dart';
import '../Network/network_page/network_page.dart';
import '../SellerScreen/seller_product_question_screen/Provider/seller_product_question _answer.dart';
import '../Trip Planner/Dispatcher_Screen/Dispatche_main_Screen.dart';
import '../team_manage_Screen /company_team_manage/company_team_mange_component/team_manage_screen.dart';

class NotificationItem extends StatelessWidget {
  NotificationProvider notificationProvider;

  NotificationItem(this.notificationProvider);

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Datum>();
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(3.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.title.toString()),
              SizedBox(
                height: 5,
              ),
              Text(data.message.toString()),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Text(notificationDateTime(data.createdAt!.toLocal()))),
            ],
          ),
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
        NavigationNextPage(
          data,
        );
      },
    );
  }
}

NavigationNextPage(
  Datum data,
) async {
  var roleName = await getRoleInfo();
  print(data.type);
  if (data.type!.contains("EVENT")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (_) => UserEventViewProvider(),
                  child: UserViewEvent(
                    data.typeId!,
                  ),
                )));
  } else if (data.type!.contains("JOB")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => JobViewProvider(),
                child: ViewJob(data.typeId!, true))));
  } else if (data.type!.contains("ECOMMERCE")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => SellerProductQuestionProvider(),
                child: SellerQuestionScreen())));
  } else if (data.type!.contains("SELLERANSWERED")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => SellerProductQuestionProvider(),
                child: SellerQuestionScreen())));
  } else if (data.type!.contains("USERLEFT")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => ManagerTeamProvider(),
                child: CompanyTeamManageScreen(1, true))));
  } else if (data.type!.contains("TRIP")) {
    var getrole = await getRoleInfo();
    Navigator.push(
      navigatorKey.currentState!.context,
      MaterialPageRoute(
          builder: (context) => DispatcherScreen(
                getrole.toString().toUpperCase(),
              )),
    );
  } else if (data.type!.contains("SENDINVITATION")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => NetworkProvider(), child: NetworkPage(0))));
  } else if (data.type!.contains("LIKEADDED")) {
    Navigator.push(
        navigatorKey.currentState!.context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (_) => LikeProvider(),
                child: LikeScreen(data.typeId!))));
  }
}
