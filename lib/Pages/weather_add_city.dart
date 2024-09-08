import 'package:flutter/material.dart';
import 'package:weather_app/Utils/weatherApp_utils.dart';

class WeatherAddCity extends StatelessWidget {
  static const routeName = '/weatherAddcity';

  const WeatherAddCity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Your City'),
        actions: [
          IconButton(
            onPressed: () {
              // Call showSearch() to show the search bar
              showSearch(context: context, delegate: ShowCityFinder())
                  .then((suggestions) {
                if (suggestions != null && suggestions.isNotEmpty) {

                }
              });
            },
            icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.search,
                  size: 20,
                )),
          )
        ],
        leading: CloseButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
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
