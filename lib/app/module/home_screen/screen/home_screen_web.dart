import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../commonWidgets/daily_data_forecast.dart';
import '../../../commonWidgets/hourly_data_widget.dart';
import '../../../utils/utils.dart';
import '../../map_screen/map_view.dart';
import '../bloc/weather_bloc_bloc.dart';

class HomeScreenWeb extends StatelessWidget {
  final WeatherBlocSuccess state;
  const HomeScreenWeb({super.key,required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          // width: MediaQuery.of(context).size.width*0.7,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 1.2 * kToolbarHeight, 20, 20),
            // padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📍 ${state.weather.areaName}',
                  style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 8),
                Text(
                  Utils.getGreeting() ?? '',
                  style: const TextStyle(
                      color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        '${state.weather.temperature!.celsius!.round()}°C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 55,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Center(
                      child: Text(
                        state.weather.weatherMain!.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Center(
                      child: Text(
                        DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Utils.getWeatherIcon(state.weather.weatherConditionCode!),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  MapViewWidget(mapType: "PR0",)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Set border color
                            width: 1.0,       // Set border width
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("Prec Layer Map",style: TextStyle(color: Colors.white,fontSize: 14),),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  MapViewWidget(mapType: "TA2",)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Set border color
                            width: 1.0,       // Set border width
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("Temp Layer Map",style: TextStyle(color: Colors.white,fontSize: 14),),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white, // Set border color
                  width: 1.0, // Set border width
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/11.png',
                                scale: 8,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sunrise',
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat().add_jm().format(state.weather.sunrise!),
                                    style: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/12.png',
                                scale: 8,
                              ),
                              const SizedBox(width: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sunset',
                                    style: TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    DateFormat().add_jm().format(state.weather.sunset!),
                                    style: const TextStyle(
                                        color: Colors.white, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Image.asset(
                              'assets/13.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Max',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${state.weather.tempMax!.celsius!.round()} °C",
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ]),
                          Row(children: [
                            Image.asset(
                              'assets/14.png',
                              scale: 8,
                            ),
                            const SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Min',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w300),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "${state.weather.tempMin!.celsius!.round()} °C",
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w700),
                                ),
                              ],
                            )
                          ])
                        ],
                      ),
                    ),
                    SizedBox(
                      // width: 200,
                        child: HourlyDataWidget(
                            weatherDataHourly: state.weatherData!.getHourlyWeather())),
                    SizedBox(
                      // width: 200,
                      child: DailyDataForecast(
                        weatherDataDaily: state.weatherData!.getDailyWeather(),
                      ),
                    ),
                    // const SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
