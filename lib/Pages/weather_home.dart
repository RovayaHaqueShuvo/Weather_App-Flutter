import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/CustomeWidgets/curved_navigatioin_bar.dart';
import 'package:weather_app/Models/current_response.dart';
import 'package:weather_app/Models/forecast_response.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/Utils/helper_functions.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

import '../CustomeWidgets/custome_widget.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<WeatherProvider>().getCurrentWeatherData();
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        animationCurve: Curves.easeInOutCubic,
        height: 50,
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color(0x8CCD00FF),
        buttonBackgroundColor: const Color(0xB001FF09),
        color: const Color(0xFFE198FA),
        // onTap: (index){
        //   if(index==0){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherHome(),));
        //   }
        //   if(index==1){
        //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddCity(),));
        //   }
        // },
        items: const [
          Icon(
            Icons.place_outlined,
            color: Colors.black,
          ),
          Icon(
            Icons.home_filled,
            color: Colors.black,
          ),
          Icon(
            Icons.add_circle_outline,
            color: Colors.black,
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
          builder: (context, value, child) => value.hasDataReciveApi
              ? Stack(
                  children: [
                    const AppBackGround(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CurrentWeatherView(
                          current: value.currentResponse!,
                          symbol: value.unitSymbol,
                          items: value.forecastResponse!.list!,
                        ),
                      ],
                    )
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

class CurrentWeatherView extends StatelessWidget {
  const CurrentWeatherView(
      {super.key, required this.current, required this.symbol, required this.items});

  final CurrentResponse current;
  final List<Forecast> items;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          getIconUrl(current.weather!.first.icon!),
          height: 100,
          width: 100,
        ),
        Text(
          '${current.main!.temp!}$degree$symbol',
          style: const TextStyle(fontSize: 80, color: Colors.white),
        ),
        Text(
          '${current.weather!.first.description}',
          style:const TextStyle(fontSize: 40, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Max:${current.main!.tempMax!.toString()}$degree',
                style: const TextStyle(fontSize: 22, color: Colors.white)),
            Text('Min:${current.main!.tempMin!.toString()}$degree',
                style:const TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
        Image.asset(
          'assets/images/House.png',
          height: 300,
          width: 300,
        ),
        Container(
          width: double.infinity,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(colors:[Color(0xFF444EAD), Color(
          //       0xFF6C60C3)],)
          // ),
          child: Card(
            color: const Color(0xFF6C60C3),
            elevation: 15,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Today",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    getFormattedDateTime(current.dt!, pattern: 'EEEE, d MMMM'),
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length ,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        child: Column(
                          children: [
                            Text('${item.main!.temp!}')
                          ],
                        ),
                      );
                    },
                  )
              )
            ]),
          ),
        )
      ],
    );
  }
}


