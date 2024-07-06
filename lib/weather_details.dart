import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';

// Screen to display weather details fetched from WeatherProvider
class WeatherDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherData = context.watch<WeatherProvider>().weatherData; // Retrieves weather data from provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Details'), 
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Returns to previous screen
          },
        ),
      ),
      body: Container(
        color: Colors.blue, // Background color
        padding: const EdgeInsets.all(16.0), 
        child: Center(
          child: weatherData != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      WeatherCard(title: 'City', value: weatherData['name']), 
                      WeatherIcon(iconCode: weatherData['weather'][0]['icon']), 
                      WeatherCard(title: 'Condition', value: weatherData['weather'][0]['description']), 
                      WeatherCard(title: 'Temperature', value: '${weatherData['main']['temp']} °C'), 
                      WeatherCard(title: 'Humidity', value: '${weatherData['main']['humidity']}%'), 
                      WeatherCard(title: 'Wind Speed', value: '${weatherData['wind']['speed']} m/s'), 
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final city = weatherData['name']; // Retrieves current city for refresh
                          context.read<WeatherProvider>().fetchWeather(city); // Refreshes weather data
                        },
                        child: const Text('Refresh'), 
                      ),
                    ],
                  ),
                )
              : const Center(child: Text('No data', style: TextStyle(color: Colors.white, fontSize: 18))), 
        ),
      ),
    );
  }
}

// Displays individual weather details in a card format
class WeatherCard extends StatelessWidget {
  final String title; 
  final String value; 

  const WeatherCard({required this.title, required this.value}); // Constructor to initialize title and value

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; 

    return Card(
      color: Colors.white.withOpacity(0.8), 
      margin: const EdgeInsets.symmetric(vertical: 10.0), 
      child: Container(
        width: screenWidth - 32, 
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Text(title, style: const TextStyle(color: Colors.black, fontSize: 18)), 
            const SizedBox(height: 5), 
            Text(value, style: const TextStyle(color: Colors.black, fontSize: 16)), 
          ],
        ),
      ),
    );
  }
}

// Displays weather icon fetched from OpenWeatherMap
class WeatherIcon extends StatelessWidget {
  final String iconCode; 

  const WeatherIcon({required this.iconCode}); // Constructor to initialize icon code

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // Retrieves screen width
    final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png'; // Constructs URL for weather icon

    return Card(
      color: Colors.white.withOpacity(0.8), 
      margin: const EdgeInsets.symmetric(vertical: 10.0), 
      child: Container(
        width: screenWidth - 32, // Adjusts container width based on screen size
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          children: [
            const Text('Current Weather', style: TextStyle(color: Colors.black, fontSize: 18)),  
            const SizedBox(height: 10), 
            Image.network(iconUrl), 
          ],
        ),
      ),
    );
  }
}
