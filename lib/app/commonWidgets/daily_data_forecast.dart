import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../module/home_screen/data/model/weather_data_daily.dart';
import '../utils/custom_colors.dart';



class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({Key? key, required this.weatherDataDaily})
      : super(key: key);

  // string manipulation
  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.5,
      margin: const EdgeInsets.only(left: 4, right: 2),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          // color: CustomColors.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Next Days",
              style:
                  TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          dailyList(context),
        ],
      ),
    );
  }

  Widget dailyList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white, // Set border color
          width: 1.0,       // Set border width
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.4,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: weatherDataDaily.daily.length > 7
              ? 7
              : weatherDataDaily.daily.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                (index==0)?
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ):Container(),
                Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            getDay(weatherDataDaily.daily[index].dt),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                              "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png"),
                        ),
                        Text(
                            "${weatherDataDaily.daily[index].temp!.max}°/${weatherDataDaily.daily[index].temp!.min}",style: const TextStyle(color: Colors.white),)
                      ],
                    )),
                Container(
                  height: 1,
                  color: CustomColors.dividerLine,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
