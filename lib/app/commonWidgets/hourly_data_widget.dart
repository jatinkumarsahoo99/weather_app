import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../module/home_screen/data/model/weather_data_hourly.dart';



class HourlyDataWidget extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWidget({super.key,required this.weatherDataHourly});

  @override
  State<HourlyDataWidget> createState() => _HourlyDataWidgetState();
}

class _HourlyDataWidgetState extends State<HourlyDataWidget> {
  // card index
  int cardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text("Today", style: TextStyle(fontSize: 18,color: Colors.white)),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.weatherDataHourly.hourly.length > 12
            ? 14
            : widget.weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                if(cardIndex != index){
                  cardIndex = index;
                  setState(() {

                  });
                }

              },
              child: Container(
                width: 90,
                margin: const EdgeInsets.only(left: 4, right: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: cardIndex == index
                        ? const LinearGradient(colors: [
                      Color(0xFF673AB7),
                      Color(0xFFFFAB40)
                    ])
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex,
                  temp: widget.weatherDataHourly.hourly[index].temp!,
                  timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                  widget.weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              ));
        },
      ),
    );
  }
}


// hourly details class
class HourlyDetails extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.cardIndex,
      required this.index,
      required this.timeStamp,
      required this.temp,
      required this.weatherIcon})
      : super(key: key);
  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp),
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : Colors.white,
              )),
        ),
        Container(
            margin: const EdgeInsets.all(5),
            child: Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 40,
              width: 40,
            )),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°",
              style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : Colors.white,
              )),
        )
      ],
    );
  }
}
