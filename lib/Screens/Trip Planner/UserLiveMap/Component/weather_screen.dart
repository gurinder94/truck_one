import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_truck_dot_one/ApiCall/api_Call.dart';
import 'package:my_truck_dot_one/Model/weather_model.dart';

class WeatherScreen extends StatelessWidget {
  LatLng pos;
  WeatherScreen({required this.pos});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/4,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder<WeatherModel>(
          future: hitWeather(pos.latitude, pos.longitude),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(child: Text('error${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.done) {

              return Column(
                children: [
                  Row(
                    children: [
                      Image.network('http:${snapshot.data!.current!.condition!.icon.toString()}'),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              snapshot.data!.current!.condition!.text.toString()),
                          Text('${snapshot.data!.current!.tempC.toString()} C')
                        ],
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network('http:${snapshot.data!.forecast!.forecastday![index].day!.condition!.icon.toString()}',
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.forecast!.forecastday![index].day!.condition!.text.toString()),
                              Text('MAX ${snapshot.data!.forecast!.forecastday![index].day!.maxtempC} C'),
                              Text('MIN ${snapshot.data!.forecast!.forecastday![index].day!.mintempC} C')
                            ],
                          ),
                          Container(
                            height: 100,
                            width: .5,
                            color: Colors.black45,
                            margin: EdgeInsets.all(10),
                          )
                        ],
                      ),
                      itemCount: snapshot.data!.forecast!.forecastday!.length,
                    ),
                  )
                ],
              );
            } else
              return Center(child: CircularProgressIndicator.adaptive());
          },
        ));
  }
}
