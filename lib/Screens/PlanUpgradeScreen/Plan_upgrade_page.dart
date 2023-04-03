// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:my_truck_dot_one/Model/plan_upgrade_model.dart';
// import '../application_localizations.dart';
// import '../commanWidget/Custom_App_Bar_Widget.dart';
// import 'Plan_upgrade_item.dart';
// import 'Provider/plan_upgrade_provider.dart';
//
// class PlanUpgradePage extends StatelessWidget {
//   String planId,planValidity;
//
//  PlanUpgradePage(this.planId, this.planValidity, {Key? key}) : super(key: key);
//   late PlanUpgradeProvider _planUpgradeProvider;
//   Widget build(BuildContext context) {
//     _planUpgradeProvider=context.read<PlanUpgradeProvider>();
//     _planUpgradeProvider.hitGetSubscriptionPlan(planId,planValidity);
//     return CustomAppBarWidget(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: Icon(Icons.arrow_back)),
//         title: "Upgrade Plan",
//         actions: SizedBox(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 110,
//             ),
//             Expanded(child: Consumer<PlanUpgradeProvider>(builder: (_, proData, __) {
//               if (proData.loding) {
//                 return Center(
//                   child: CircularProgressIndicator.adaptive(),
//                 );
//               }
//               if (proData.planUpgradeModel == null)
//                 return Center(
//                     child:
//                     Text(AppLocalizations.instance.text("Network issue")));
//               else if (proData.planUpgradeModel!.data!.length == 0)
//                 return Center(
//                     child: Text(
//                         AppLocalizations.instance.text("No Record Found")));
//               else
//                 return ListView.builder(
//                     itemCount: proData.planUpgradeModel!.data!.length,
//                     padding: EdgeInsets.zero,
//                     itemBuilder: (BuildContext context, int index) {
//                       return ChangeNotifierProvider<Datum>.value(
//                           value: proData.planUpgradeModel!.data![index],
//                           child:PlanUpgradeItem(proData,planId));
//
//                     });
//             })),
//
//           ],
//         ),
//         floatingActionWidget: SizedBox());
//   }
// }
