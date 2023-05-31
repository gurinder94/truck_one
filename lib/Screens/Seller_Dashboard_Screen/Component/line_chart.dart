import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_truck_dot_one/Screens/SellerScreen/provider/seller_dash_bord_provider.dart';
import 'package:my_truck_dot_one/Screens/Language_Screen/application_localizations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../Model/sellerDashBoardModel 2.dart';


class LineCharts extends StatelessWidget {
  SellerDashBordProvider dashBordProvider;
  List<LineSeries<PlanData, String>> mainData = [];

  LineCharts(this.dashBordProvider);

  List<PlanData> data = [];

  @override
  @override
  Widget build(BuildContext context) {
    setDataInGraph(dashBordProvider.dataa.cast<GRAPTHDATA>());

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
                text: AppLocalizations.instance.text('Queries'),

                // Aligns the chart title to left
                alignment: ChartAlignment.center,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                )),
            tooltipBehavior: dashBordProvider.tooltipBehavior,
            legend: Legend(
              isVisible: true,
              // Legend will be placed at the left
              position: LegendPosition.bottom,
            ),
            series: mainData),
        decoration: BoxDecoration(color: Color(0xFFEEEEEE), boxShadow: [
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
    );
  }

  setDataInGraph(List<GRAPTHDATA>? grapthdata) {
    data = [];

    for (int i = 0; i < grapthdata!.length; i++) {
      data.add(PlanData(DateFormat("MMM dd, yy").format(grapthdata[i].id!),
          grapthdata[i].count!.toDouble()));
    }
    LineSeries<PlanData, String> lineSeries = LineSeries<PlanData, String>(
        dataSource: data,
        color: Colors.blue,
        selectionBehavior: dashBordProvider.selectionBehavior,
        name: 'Number of queries per day',
        xValueMapper: (PlanData planData, _) => planData.date,
        yValueMapper: (PlanData planData, _) => planData.value,
        markerSettings: MarkerSettings(isVisible: true),
        enableTooltip: true,
        dataLabelSettings: DataLabelSettings(isVisible: true),
        onPointTap: (value) {});

    mainData.add(lineSeries);
  }
}

class PlanData {
  PlanData(this.date, this.value);

  final String date;
  final double value;
}
