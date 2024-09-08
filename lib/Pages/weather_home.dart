import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Models/current_response.dart';
import 'package:weather_app/Models/forecast_response.dart';
import 'package:weather_app/Pages/weather_add_city.dart';
import 'package:weather_app/Provider/weather_provider.dart';
import 'package:weather_app/Utils/helper_functions.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

import '../CustomeWidgets/custome_widget.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});
  static const routeName = '/';

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  String formattedLocalTime = '';

  @override
  void initState() {
    super.initState();
    // Start the timer to update the time every second
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Update the formatted time every second
        formattedLocalTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    });
  }

  @override
  void didChangeDependencies() {
    context.read<WeatherProvider>().determinePosition().then((value) {
      context.read<WeatherProvider>().getWeatherData();
    });
    super.didChangeDependencies();
  }
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         // Call showSearch() to show the search bar
      //         showSearch(context: context, delegate: ShowCityFinder())
      //             .then((suggestions) {
      //           if (suggestions != null && suggestions.isNotEmpty) {
      //
      //           }
      //         });
      //       },
      //       icon: const Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20),
      //           child: Icon(
      //             Icons.search,
      //             size: 20,
      //           )),
      //     )
      //   ],
      // ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        animationCurve: Curves.easeInOutCubic,
        height: 50,
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color(0xFF8170D5),
        buttonBackgroundColor: const Color(0xFFCAC8EC),
        color: const Color(0xFF755DD3),
        onTap: (index) async {
          if (index == 0) {
            // Navigate to the first page
            await Future.delayed(const Duration( milliseconds: 500 ));
            showSearch(context: context, delegate: ShowCityFinder())
                .then((suggestions) async {
              if (suggestions != null && suggestions.isNotEmpty) {
                await context.read<WeatherProvider>().ConverCityToLatLon(suggestions);
              }
            });
            //await Navigator.pushNamed(context, '/weatherAddcity');
          }
          if (index == 2) {
            // Navigate to the settings page
            await Future.delayed(const Duration( milliseconds: 500 ));
            await Navigator.pushNamed(context, '/weatherSettting');
          }

          // After navigating back, reset the selected index to 1 (default page)
          _bottomNavigationKey.currentState?.setPage(1);
        },
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
            Icons.settings,
            color: Colors.black,
          ),
        ],
      ),
      body: Consumer<WeatherProvider>(
          builder: (context, value, child) =>
          value.hasDataReciveApi
              ? Stack(
            children: [
              const AppBackGround(),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50, horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            formattedLocalTime,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    CurrentWeatherView(
                      current: value.currentResponse!,
                      symbol: value.unitSymbol,
                    ),
                    // ForecastWeatherView(items: value.forecastResponse!.list!)
                  ],
                ),
              ),
              ForecastWeatherView(
                items: value.forecastResponse!.list!,
                currentWe: value.currentResponse!,
              ),
            ],
          )
              : const Center(child: CircularProgressIndicator())),
    );
  }
}

class CurrentWeatherView extends StatelessWidget {
  const CurrentWeatherView(
      {super.key, required this.current, required this.symbol});

  final CurrentResponse current;
  final String symbol;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          getFormattedDateTime(current.dt!, pattern: 'EEEE, d MMMM'),
          style: const TextStyle(fontSize: 22, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CachedNetworkImage(
              imageUrl: getIconUrl(current.weather!.first.icon!),
              height: 70,
              width: 70,
              color: Colors.white,
            ),
            Text(
              '${current.main!.temp!}$degree$symbol',
              style: const TextStyle(fontSize: 65, color: Colors.white),
            ),
          ],
        ),
        Text(
          '${current.weather!.first.description}',
          style: const TextStyle(fontSize: 40, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('MaxTemp:${current.main!.tempMax!.toString()}$degree',
                style: const TextStyle(fontSize: 22, color: Colors.white)),
            Text('MinTemp:${current.main!.tempMin!.toString()}$degree',
                style: const TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
        Image.asset(
          'assets/images/House.png',
          height: 220,
          width: double.infinity,
        ),
      ],
    );
  }
}

class ForecastWeatherView extends StatelessWidget {
  const ForecastWeatherView(
      {super.key, required this.items, required this.currentWe});

  final List<Forecast> items;
  final currentWe;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.4,
        maxChildSize: 0.9, // Maximum height
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF8271D6),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                ),
              ],
            ),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Today",
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    Text(
                      getFormattedDateTime(items.first.main!.temp!,
                          pattern: 'd MMMM'),
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${currentWe.name}, ${currentWe.sys!.country}',
                        style: const TextStyle(
                          fontSize: 26.0,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Card(
                              color: Color(0xFF3F40A2),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  children: [
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(
                                          Icons.sunny,
                                          color: Colors.white,
                                        ),
                                        Text("SUNRISE",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))
                                      ],
                                    ),
                                    Text(
                                      getFormattedDateTime(
                                          currentWe.sys!.sunrise!,
                                          pattern: "hh:mm a"),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(Icons.sunny_snowing,
                                          color: Colors.white,),
                                        Text("SUNSET", style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                      ],
                                    ),
                                    Text(
                                      getFormattedDateTime(
                                          currentWe.sys!.sunset!,
                                          pattern: "hh:mm a"),
                                      style: const TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Card(
                              color: Color(0xFF3F40A2),
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(child: Image.asset(
                                      'assets/images/LatLonIcon.png',)),
                                    Column(
                                      children: [
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text("LATITUTE",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white))
                                          ],
                                        ),
                                        Text(
                                          context
                                              .read<WeatherProvider>()
                                              .latitute
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text("LONGITUTE",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white))
                                          ],
                                        ),
                                        Text(
                                          context
                                              .read<WeatherProvider>()
                                              .longitute
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    const  SizedBox(height: 14,),
                      const Text("Forecast", style: TextStyle(fontSize: 30, color:Colors.white),),
                      ForecastWeather(items: items),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ForecastWeather extends StatelessWidget {
  const ForecastWeather({super.key, required this.items});

  final items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 20,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 1000,
            color: Color(0x7B383AAD),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(getFormattedDateTime(item.dt!, pattern: 'EEE hh:mm a',), style: const TextStyle(color: Colors.white, fontSize: 16),),
                  CachedNetworkImage(
                    imageUrl: getIconUrl(item.weather!.first.icon!), width: 40,
                    height: 40,),
                  Text(item.main.temp!.toString(), style: const TextStyle(color: Colors.white, fontSize: 16),),
                  Text(item.weather!.first.main!.toString(), style: const TextStyle(color: Colors.white, fontSize: 22),),
                  Text(item.weather!.first.description!.toString(), style: const TextStyle(color: Colors.white, fontSize: 22),),
                ],
              ),),);
        },),
    );
  }
}

class ShowCityFinder extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // Action icons on the search bar (e.g., clear button)
    return [
      IconButton(
        onPressed: () {
          query = ''; // Clear the search query
        },
        icon: const Icon(Icons.clear_sharp),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Leading icon in the search bar (back button)

    return IconButton(
      onPressed: () {
        close(context, ''); // Close the search
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Display results (e.g., cities that match the query)
    return ListTile(
      title: Text('Search Result for "$query"'),
      onTap: (){
        close(context, query);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filterSearch = query.isEmpty
        ? Cities
        : Cities.where((suggestions) =>
        suggestions.toLowerCase().startsWith(query.toLowerCase())).toList();
    // Suggestions when the user types in the search bar
    return ListView.builder(
      itemCount: filterSearch.length,
      itemBuilder: (context, index) {
        final suggestions = filterSearch[index];
        return ListTile(
          title: Text(suggestions),
          onTap: () {
            close(context,
                suggestions); // Show the results based on the selected suggestion
          },
        );
      },
    );
  }
}