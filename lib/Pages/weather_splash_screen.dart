import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/Pages/weather_home.dart';

class WeatherSplashScreen extends StatefulWidget {
  const WeatherSplashScreen({super.key});

  @override
  State<WeatherSplashScreen> createState() => _WeatherSplashScreenState();
}

class _WeatherSplashScreenState extends State<WeatherSplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WeatherHome(),)
      );
    });
  }
  // @override
  // void dispose(){
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //   overlays: SystemUiOverlay.values);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,),
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0D1121), Color(0xFF241D49), Color(0xFF9045AA)]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/splash_screen_icon.png'),
          const SizedBox(
            height: 30.0,
          ),
          const Text(
            "Welcome",
            style: TextStyle(
              color: Color(0xE7FFFFFF),
              fontSize: 30,
              fontFamily: 'Cursive',
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Weather",
            style: TextStyle(
              color: Colors.white,
              fontSize: 46,
              fontFamily: 'serif',
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Forecast",
            style: TextStyle(
              color: Color(0xE7EEB912),
              fontSize: 40,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ));
  }
}
