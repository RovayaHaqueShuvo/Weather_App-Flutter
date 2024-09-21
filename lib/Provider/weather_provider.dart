import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:weather_app/Models/current_response.dart';
import 'package:weather_app/Models/forecast_response.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart' as geo;

class WeatherProvider extends ChangeNotifier {
  CurrentResponse? currentResponse;
  ForecastResponse? forecastResponse;
  double latitute = 23.8070569;
  double longitute = 90.3659351;
  String unit = metric;
  String unitSymbol = celsius;
  bool get hasDataReciveApi => currentResponse!= null && forecastResponse!=null;

 Future<void> getWeatherData() async{
   await _getCurrentWeatherData();
   await _getForecastWeatherData();
  }

  Future<void> _getCurrentWeatherData() async {
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

  Future<void> _getForecastWeatherData() async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitute&lon=$longitute&appid=$weatherAPIKey&units=metric';
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



  String convertToDMS(double coordinate, String positiveDirection, String negativeDirection) {
    // Determine the direction (N/S or E/W)
    String direction = coordinate >= 0 ? positiveDirection : negativeDirection;

    // Get the absolute value for processing
    double absCoord = coordinate.abs();

    // Get degrees, minutes, and seconds
    int degrees = absCoord.floor(); // Integer part for degrees
    double minutesDecimal = (absCoord - degrees) * 60;
    int minutes = minutesDecimal.floor(); // Integer part for minutes
    double seconds = (minutesDecimal - minutes) * 60; // Fractional part for seconds

    // Format and return the result
    return "$degrees° $minutes' ${seconds.toStringAsFixed(2)}\" $direction";
  }
  // getlatitute(){
  //   double latitude = latitute;
  // }
  // void main() {
  //
  //   double longitude = -30.67890;
  //
  //   // Convert latitude and longitude
  //   String latDMS = ;
  //   String lonDMS = );
  //
  //   print("Latitude: $latDMS");  // Output: Latitude: 15° 14' 4.42" N
  //   print("Longitude: $lonDMS"); // Output: Longitude: 30° 40' 44.04" W
  // }



  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final postion = await Geolocator.getCurrentPosition();
    latitute = postion.latitude.toDouble();
    longitute = postion.longitude.toDouble();
  }

  Future <void> ConverCityToLatLon (String City)async{
   try{
     final locationList = await geo.locationFromAddress(City);
     if(locationList.isNotEmpty){
       final location = locationList.first;
       latitute = convertToDMS(location.latitude, "N", "S") as double;
       longitute =convertToDMS( location.longitude, "E", "W") as double;
       getWeatherData();
     }
   } catch(error){
     print(error);
   }
  }

}


