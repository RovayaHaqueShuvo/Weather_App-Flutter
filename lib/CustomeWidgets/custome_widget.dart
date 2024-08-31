

import 'package:flutter/material.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';
class AppBackGround extends StatelessWidget {
  const AppBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/night.png',
          width: double.infinity,
          height: double.infinity,
          fit:BoxFit.cover,
        ),

      ],
    );
  }
}
 Future<void> getBGImages()async{
  int timestamp = await WeatherProvider().currentResponse!.dt!.toInt(); // Example Unix timestamp
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
// Determine if it's day or night based on the hour
  int hour = date.hour;
  if (hour >= 6 && hour < 18) {
    Image.asset(day,
      width: double.infinity,
      height: double.infinity,
      fit:BoxFit.cover,
    );
  } else {
    Image.asset(night,
      width: double.infinity,
      height: double.infinity,
      fit:BoxFit.cover,
    );
  }
}