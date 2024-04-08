import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../../../utils/const.dart';
import '../data/model/weather_data.dart';
import '../data/model/weather_data_current.dart' as cur;
import '../data/model/weather_data_daily.dart' as daily;
import '../data/model/weather_data_hourly.dart' as hour;
import '../repository/fetch_weather_data.dart';



part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
			emit(WeatherBlocLoading());
      try {
				WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        if (kDebugMode) {
          print(">>>>>>>>>>>>>lat${event.position.latitude}");
          print(">>>>>>>>>>>>>lng${event.position.longitude}");
        }

				Weather weather = await wf.currentWeatherByLocation(
					event.position.latitude, 
					event.position.longitude,
				);

        // String value = await rootBundle.loadString('assets/json/data.json');
        // var map = json.decode(value);
        // WeatherData ?weatherData = WeatherData(cur.WeatherDataCurrent.fromJson(map as Map<String, dynamic>), hour.WeatherDataHourly.fromJson(map), daily.WeatherDataDaily.fromJson(map));

        WeatherData ? weatherData = await FetchWeatherDataRepo.processData(event.position.latitude, event.position.longitude);
        emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
      } catch (e) {
        if (kDebugMode) {
          print(">>>>>>>>>>>>>error$e");
        }
        emit(WeatherBlocFailure(e.toString()));
      }
    });
  }
}
