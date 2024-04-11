import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../../../utils/Shared_Preferences.dart';
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
        // await SharedPreference.setData(key: "setFirst", data: "false");
        // WeatherData ?weatherData = WeatherData(cur.WeatherDataCurrent.fromJson(map as Map<String, dynamic>), hour.WeatherDataHourly.fromJson(map), daily.WeatherDataDaily.fromJson(map));
        String? isFirstTime  = await SharedPreference.getData(key: "setFirst");
        await SharedPreference.setData(key: "setFirst", data: "false");
        if (kDebugMode) {
          print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>isFirstTime$isFirstTime");
        }

        if(isFirstTime != null && isFirstTime.toString().contains("false")){
          String? time  = await SharedPreference.getData(key: "dateTime");

          if(time != null){
            try{
              DateTime dateTime = DateTime.parse(time);
              if(dateTime.difference(DateTime.now()).inHours <= 4){
                String? data  = await SharedPreference.getData(key: "data");
                if(data != null && data != ""){
                  WeatherData ? weatherData = WeatherData(cur.WeatherDataCurrent.fromJson(jsonDecode(data)),
                      hour.WeatherDataHourly.fromJson(jsonDecode(data)), daily.WeatherDataDaily.fromJson(jsonDecode(data)));
                  emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));

                }else{
                  WeatherData ? weatherData = await FetchWeatherDataRepo.processData(event.position.latitude, event.position.longitude);
                  await SharedPreference.setData(key: "data", data: jsonEncode(weatherData?.toJson()??""));
                  await SharedPreference.setData(key: "setFirst", data: "false");
                  await SharedPreference.setData(key: "dateTime", data: "${DateTime.now()}");
                  emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));

                }

              }else{
                WeatherData ? weatherData = await FetchWeatherDataRepo.processData(event.position.latitude, event.position.longitude);
                emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
                await SharedPreference.setData(key: "data", data: jsonEncode(weatherData?.toJson()??""));
                await SharedPreference.setData(key: "setFirst", data: "false");
                await SharedPreference.setData(key: "dateTime", data: "${DateTime.now()}");
                emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
              }
            }catch(e){
              WeatherData ? weatherData = await FetchWeatherDataRepo.processData(event.position.latitude, event.position.longitude);
              emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
              await SharedPreference.setData(key: "data", data: jsonEncode(weatherData?.toJson()??""));
              await SharedPreference.setData(key: "setFirst", data: "false");
              await SharedPreference.setData(key: "dateTime", data: "${DateTime.now()}");
              emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
            }
          }

        }

        else{
          WeatherData ? weatherData = await FetchWeatherDataRepo.processData(event.position.latitude, event.position.longitude);
          emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
          await SharedPreference.setData(key: "data", data: jsonEncode(weatherData?.toJson()??""));
          await SharedPreference.setData(key: "setFirst", data: "false");
          await SharedPreference.setData(key: "dateTime", data: "${DateTime.now()}");
          emit(WeatherBlocSuccess(weather:weather,weatherData: weatherData));
        }
      } catch (e) {
        if (kDebugMode) {
          print(">>>>>>>>>>>>>error$e");
        }
        emit(WeatherBlocFailure(e.toString()));
      }
    });
  }
}
