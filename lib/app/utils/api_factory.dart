

import 'const.dart';

class ApiFactory {
  // static String BASEURL="http://4.188.234.4:5002";
  static String BASEURL="";

  static String GET_WEATHER_DATA(var lat,var lon) => "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$API_KEY&units=metric&exclude=minutely";
}