import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';
import 'weather_details.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
 
  final TextEditingController _controller = TextEditingController();

  // Initialize state and load the last searched city when the widget is created
  @override
  void initState() {
    super.initState();
    _loadLastSearchedCity();
  }

  // Load the last searched city from shared preferences and update the input field
  Future<void> _loadLastSearchedCity() async {
    final city = await context.read<WeatherProvider>().loadLastSearchedCity();
    if (city != null) {
      _controller.text = city;
      await context.read<WeatherProvider>().fetchWeather(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Know Weather At Your Place')),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Input field to enter the city name
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    labelText: 'Enter city name',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                // Button to fetch the weather for the entered city
                ElevatedButton(
                  onPressed: () async {
                    final city = _controller.text;
                    if (city.isNotEmpty) {
                      // Fetch weather data for the entered city
                      await context.read<WeatherProvider>().fetchWeather(city);
                      // Navigate to the WeatherDetailsScreen to display the weather details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherDetailsScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Get Weather'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


















