import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:weather_app/Models/current_response.dart';
import 'package:weather_app/Models/forecast_response.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

class WeatherProvider extends ChangeNotifier {
  CurrentResponse? currentResponse;
  ForecastResponse? forecastResponse;
  double latitute = 23.0;
  double longitute = 90.0;
  String unit = metric;
  String unitSymbol = celsius;
  bool get hasDataReciveApi => CurrentResponse!= null && ForecastResponse!=null;

  Future<void> getCurrentWeatherData() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&appid=$weatherAPIKey&units=metric';
    Response response = await get(Uri.parse(url));

    try {
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        currentResponse = CurrentResponse.fromJson(map);
        notifyListeners();
      }
      else {
        print(map['message']);
      }
    }
    catch (error) {
      print(error.toString());
    }
  }

  Future<void> getForecastWeatherData() async {
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&appid=$weatherAPIKey';
    Response response = await get(Uri.parse(url));

    try {
      Map<String, dynamic> map = jsonDecode(response.body);
      if (response.statusCode == 200) {
        forecastResponse = ForecastResponse.fromJson(map);
        notifyListeners();
      }
      else {
        print(map['message']);
      }
    }
    catch (error) {
      print(error.toString());
    }
  }


}
