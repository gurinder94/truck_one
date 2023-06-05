import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/myPlans/my_plan_list_item.dart';
import 'package:my_truck_dot_one/Screens/MenuScreen/myPlans/my_plan_list_provider.dart';
import 'package:my_truck_dot_one/Screens/PricingScreen/component/PriceTabber.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_page.dart';
import 'package:my_truck_dot_one/Screens/PrivacyPolicyScreen/privacy_policy_provider.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/comman_rich_text.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPlansScreen extends StatefulWidget {
  const MyPlansScreen({Key? key}) : super(key: key);

  @override
  State<MyPlansScreen> createState() => _MyPlansScreenState();
}

class _MyPlansScreenState extends State<MyPlansScreen> {
  @override
  int pageChanged = 0;
  late MyPlanListProvider _provider;
  int count = 1;

  Map<String, PurchaseDetails> purchases = {};

  @override
  void initState() {
    // if (mounted) {
    _provider = context.read<MyPlanListProvider>();
    _provider.initData();
    // _provider.getmyPlan();
    // }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _provider.disposee();
    super.dispose();
  }

  popUpMenuOptions() {
    return PopupMenuButton(onSelected: (value) {
      // your logic
      print("onSelected> ${value.toString()}");
      _provider.onPopUpMenuClickAction(value.toString());
    }, itemBuilder: (BuildContext bc) {
      return const [
        PopupMenuItem(
          child: Text("E-Commerce"),
          value: 'ECOMMERCE',
        ),
        PopupMenuItem(
          child: Text("Event"),
          value: 'EVENT',
        ),
        PopupMenuItem(
          child: Text("Job"),
          value: 'JOB',
        ),
        PopupMenuItem(
          child: Text("Service"),
          value: 'SERVICE',
        ),
        PopupMenuItem(
          child: Text("Trip-Planner"),
          value: 'TRIP_PLANNER',
        ),
      ];
    });
  }

  Widget build(BuildContext context) {
    return CustomAppBarWidget(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: "Subscription Plan",
        actions: popUpMenuOptions(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MyPlanTabber(
                    pos: 0,
                    title: 'Monthly',
                    onTabHit: (value) {
                      Provider.of<MyPlanListProvider>(context, listen: false)
                          .setMenuClick(value, context);
                    },
                  ),
                  MyPlanTabber(
                    pos: 1,
                    title: 'Yearly',
                    onTabHit: (value) {
                      Provider.of<MyPlanListProvider>(context, listen: false)
                          .setMenuClick(value, context);
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<MyPlanListProvider>(builder: (_, proData, __) {
                if (proData.loading) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (proData.products == null)
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                else if (proData.notFoundIds.isNotEmpty)
                  return Center(
                      child: Text(
                          "We would like you to enable in app purchase from your device setting."
                          " Settings>Screen Time > Content & Privacy Restriction > Enable."
                          "Now click on iTunes & App Store Purchases > In-app Purchase> Allow."));
                else if (proData.products.isEmpty)
                  return Center(
                      child: Text(
                          AppLocalizations.instance.text("No Record Found")));
                else
                  purchases = Map<String, PurchaseDetails>.fromEntries(
                      proData.purchases.map((PurchaseDetails purchase) {
                    print("874327hjfdhjjhhjfdshrr943929 ${purchase.productID}");
                    if (purchase.pendingCompletePurchase) {
                      InAppPurchase.instance.completePurchase(purchase);
                    }

                    return MapEntry<String, PurchaseDetails>(
                        purchase.productID, purchase);
                  }));
                return SingleChildScrollView(
                  child: proData.purchasePending
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Column(
                              children: List.generate(proData.products.length,
                                  (index) {
                                final PurchaseDetails? previousPurchase =
                                    purchases[proData.products[index].id];
                                return MyPlanListItem(proData.products[index],
                                    index, previousPurchase, proData, []);
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: CommonRichText(
                                richText1: "Subscription Info ",
                                style1: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                    color: Colors.black,
                                    fontSize: 14),
                                richText2:
                                    "Payment will be charged to iTunes Account at confirmation of purchase. Subscription automatically renews unless auto - renew is turned off at least 24 hours before the end of the current period.Account will be charged for renewal within 24 hours prior to the end of the current period, and identify the cost of the renewal.Subscriptions may be managed by the user and auto-renewal may be turned off by going to the user's Account Settings after purchase. ",
                                style2: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      PrivacyPolicyProvider(),
                                                  child: PrivacyPolicyPage(
                                                    type: "POLICY",
                                                  )))),
                                  child: Text(
                                    "Privacy Policy |",
                                    style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider(
                                                  create: (_) =>
                                                      PrivacyPolicyProvider(),
                                                  child: PrivacyPolicyPage(
                                                    type: "TERMSUSE",
                                                  )))),
                                  child: Text(
                                    "Terms of Use",
                                    style: TextStyle(
                                      color: PrimaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                );
                // return ListView.builder(
                //     itemCount: proData.products.length,
                //     padding: EdgeInsets.zero,
                //     itemBuilder: (BuildContext context, int index) {
                //       return PricingItem(
                //         proData.products[index],
                //         index,
                //         proData,
                //       );
                //     });
              }),
            ),
          ],
        ),
        floatingActionWidget: SizedBox());
  }
}

launchURL(String url) async {
  print(url);
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
    throw 'Could not launch $url';
  }
}
