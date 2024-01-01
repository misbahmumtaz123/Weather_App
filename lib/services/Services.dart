import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/ForecastModel.dart';
import '../View/reuseable/Constants.dart';
import '../model/CurrentWeather.dart';


Future<CurrentWeather> getCurrentWeather(double lat,double long) async {
  var currentUrl =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric';

  final response = await http.get(Uri.parse(currentUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // print(data);
    print('data is recived');
    CurrentWeather currentWeather = CurrentWeather.fromJson(data);
    return currentWeather;
  } else {
    throw Exception('can not fetch data');
  }
}

Future<HourlyWeatherData> getDaysForeCast(double lat,double long) async {

  var daysUrl =
      'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey&units=metric';


  final response = await http.get(Uri.parse(daysUrl));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    // print(data);
    print('forecast data is recieved');
    HourlyWeatherData currentForecast = HourlyWeatherData.fromJson(data);
    return currentForecast;
  } else {
    print('error in forecast data');

    throw Exception('can not fetch Forecast data');
  }
}
