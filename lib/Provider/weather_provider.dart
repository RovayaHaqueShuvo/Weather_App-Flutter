import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

class WeatherProvider extends ChangeNotifier {
  double latitute = 100.00;
  double longitute = 100.00;
  String metric='';
  String fahrenheit = 'F';
  String celsius ='C';
  String kelvin = 'K';


  getCurrentWeatherData()
  async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitute&lon=$longitute&appid=$weatherAPIKey';
  Response response = await get(Uri.parse(url));
  if(response.statusCode == 200){
    Map<String, dynamic> map = jsonDecode(response.body);
print('wether temp: ${map['main']['temp']}');
print('wether LOCATION: ${map['name']}');
  }
}}