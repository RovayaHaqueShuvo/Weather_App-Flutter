import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Pages/weather_add_city.dart';
import 'package:weather_app/Pages/weather_home.dart';
import 'package:weather_app/Pages/weather_setting.dart';
import 'package:weather_app/Pages/weather_splash_screen.dart';
import 'package:weather_app/Provider/weather_provider.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
      create: (context) => WeatherProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: WeatherSplashScreen.routeName,
      routes: {
        WeatherSplashScreen.routeName:(context) => const WeatherSplashScreen(),
        WeatherHome.routeName:(context) =>const WeatherHome(),
        WeatherAddCity.routeName:(context) =>const WeatherAddCity(),
        WeatherSetting.routeName:(context) => const WeatherSetting(),
      },
    );
  }
}


