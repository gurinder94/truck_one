import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/provider/seller_dash_bord_provider.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/Provider/seller_product_question%20_answer.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/seller_product_question_screen/seller_question_screen.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:my_truck_dot_one/Screens/commanWidget/Custom_App_Bar_Widget.dart';
import 'package:provider/provider.dart';

import 'Component/line_chart.dart';

class SellerHomePage extends StatefulWidget {
  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  final double _width = 50;
  final double _height = 50;
  final Color _color = Colors.green;
  var selected = true;
  late SellerDashBordProvider _dashBordProvider;

  void initState() {
    _dashBordProvider = context.read<SellerDashBordProvider>();
    _dashBordProvider.hitSellerDashBord();
  }

  @override
  Widget build(BuildContext context) {
    return CustomAppBarWidget(
      leading: SizedBox(),
      floatingActionWidget: SizedBox(),
      actions: SizedBox(),
      title: AppLocalizations.instance.text('DashBoard'),
      child: SingleChildScrollView(
          child: Consumer<SellerDashBordProvider>(builder: (_, proData, __) {

            if (proData.loder) {
              return Column(
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              );
            }
            if (proData.dashBoardModel.data!.length == 0)
              return Center(
                  child: Text(
                      AppLocalizations.instance.text('No Record Found')));
            else {
              return Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 200,
                      child: Image.asset("icons/seller_image.png")),
                  SizedBox(
                    height: 30,
                  ),
                  LineCharts(proData),

                  SizedBox(
                    height: 10,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _dashBordProvider.dashBoardModel.data![0]
                                          .percent ==
                                          0
                                          ? "0"
                                          : _dashBordProvider
                                          .dashBoardModel.data![0].percent
                                          .toString() +
                                          '%',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      AppLocalizations.instance
                                          .text('Answered Queries'),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      proData.dashBoardModel.data![0]
                                          .totalQueries!
                                          .length ==
                                          0
                                          ? "0"
                                          : proData.dashBoardModel.data![0]
                                          .totalQueries![0]
                                          .count.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        AppLocalizations.instance.text(
                                            'Total Queries'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: PrimaryColor),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider(
                                                        create: (_) =>
                                                            SellerProductQuestionProvider(),
                                                        child: SellerQuestionScreen())));
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      proData.dashBoardModel.data![0]
                                          .totalAnsweredQueries!.length == 0

                                          ? "0"
                                          : proData.dashBoardModel.data![0]
                                          .totalAnsweredQueries![0].count
                                          .toString(),
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    GestureDetector(
                                      child: Text(
                                        AppLocalizations.instance.text(
                                            'UnAnswer Queries'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: PrimaryColor),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChangeNotifierProvider(
                                                        create: (_) =>
                                                            SellerProductQuestionProvider(),
                                                        child: SellerQuestionScreen())));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        decoration:
                        BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
                          BoxShadow(
                            color: Color(0xFFD9D8D8),
                            offset: Offset(5.0, 5.0),
                            blurRadius: 7,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(.5),
                            offset: Offset(-5.0, -5.0),
                            blurRadius: 7,
                          ),
                        ]),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider(
                                        create: (_) =>
                                            SellerProductQuestionProvider(),
                                        child: SellerQuestionScreen())));
                      },
                    ),
                  )
                ],
              );
            }
          })),
    );
  }
}
