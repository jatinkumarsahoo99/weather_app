import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../utils/api_factory.dart';
import '../../../provider/http_methods.dart';
import '../data/model/weather_data.dart';
import '../data/model/weather_data_current.dart';
import '../data/model/weather_data_daily.dart';
import '../data/model/weather_data_hourly.dart';

class FetchWeatherDataRepo {
  static WeatherData? weatherData;

  static HttpMethodsDio httpMethodsDio = HttpMethodsDio();

 static Future<WeatherData?> processData(lat, lon) async {
    Completer<WeatherData?> completer = Completer<WeatherData?>();
    try {
      httpMethodsDio.getMethod(
          api: ApiFactory.GET_WEATHER_DATA(lat, lon),
          fun: (map) {
            if (map is Map) {
              weatherData = WeatherData(WeatherDataCurrent.fromJson(map as Map<String, dynamic>),
                  WeatherDataHourly.fromJson(map), WeatherDataDaily.fromJson(map));
            }
            completer.complete(weatherData);
          });
    } catch (e) {
      if (kDebugMode) {
        print(">>>>>>Exception$e");
      }
      completer.complete(null);
    }

    return completer.future;
  }
}
