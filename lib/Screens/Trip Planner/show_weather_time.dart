import 'package:flutter/material.dart';
import 'package:my_truck_dot_one/AppUtils/constants.dart';
import 'package:my_truck_dot_one/AppUtils/data_items.dart';
import 'package:provider/provider.dart';

import 'UserLiveMap/Provider/route_marker_list_provider.dart';

class ShowWeatherDay extends StatefulWidget {
  RouteMarkerListProvider provider;

  ShowWeatherDay(this.provider);

  @override
  _ShowWeatherDayState createState() => _ShowWeatherDayState(provider);
}

class _ShowWeatherDayState extends State<ShowWeatherDay> {
  var _width = 0.0;
  bool check = true;
  int? pos;
  RouteMarkerListProvider provider;

  _ShowWeatherDayState(this.provider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text('Forecast Layer'),
      ),
      body: Column(
        children: [
          Consumer<RouteMarkerListProvider>(builder: (context, noti, child) {
            return Container(
                width: double.infinity,
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: WeatherDays.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                              child: Container(
                                width: 150,
                                height: 10,
                                child: Center(
                                    child: Text(
                                  WeatherDays[index],
                                )),
                                color: index == provider.pos
                                    ? Colors.amberAccent
                                    : Colors.white,
                              ),
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    provider.RemovePolygonline();
                                    provider.setmenuBar(0);
                                    provider.allWeatherDaythreeSeven('1');
                                    break;
                                  case 1:
                                    provider.RemovePolygonline();
                                    provider.setmenuBar(1);
                                    provider.allWeatherDaythreeSeven('2');
                                    break;
                                  case 2:
                                    provider.RemovePolygonline();
                                    provider.setmenuBar(2);
                                    provider.allWeatherDaythreeSeven('3');
                                    break;
                                  case 3:
                                    provider.RemovePolygonline();
                                    provider.setmenuBar(3);
                                    provider.allWeatherDaythreeSeven('3_7');
                                    break;
                                  case 4:
                                    provider.RemovePolygonline();
                                    provider.setmenuBar(4);
                                    provider.allWeatherDaythreeSeven('8_14');
                                    break;
                                }
                              }));
                    }));
          }),
          Expanded(
            child: Consumer<RouteMarkerListProvider>(
                builder: (context, noti, child) {
              return ListView.builder(
                  itemCount: noti.weatherName.length,
                  itemBuilder: (BuildContext context, int index) {
                    return noti.weatherLoading == true
                        ? CircularProgressIndicator()
                        :  noti.weatherName.length==0?Center(child: Text("No record ",style: TextStyle(fontSize:25),)): Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 30,
                              height: 70,
                              child: RadioListTile(
                                  value: index,
                                  groupValue: noti.radioSelected,
                                  onChanged: (ind) => setState(() {
                                        noti.radioSelected = ind;
                                        if (noti.weatherName[index] == "Snow") {
                                          noti.removePolyon(noti.list);
                                        } else if (noti.weatherName[index] ==
                                            "ForecastWeather") {
                                          noti.removePolyon(
                                              noti.forecastRemoveList);
                                        } else if (noti.weatherName[index] ==
                                            "Precipitationt") {
                                          noti.removePolyon(
                                              noti.precipitationtRemoveList);
                                        } else if (noti.weatherName[index] ==
                                            "Thunder") {
                                          noti.removePolyon(
                                              noti.ThunderRemoveList);
                                        }

                                        print(noti.weatherName);
                                      }),
                                  title: Text(noti.weatherName[index])),
                              color: Colors.white,
                            ),
                          );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
