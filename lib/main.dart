import 'package:flutter/material.dart'; // Flutter framework
import 'package:provider/provider.dart'; // Provider package for state management
import 'weather_provider.dart'; // WeatherProvider class for managing weather data
import 'initial_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider( // Provides WeatherProvider to the entire app
      create: (_) => WeatherProvider(), 
      child: MyApp(), 
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Root widget of the app
      title: 'Weather App', 
      theme: ThemeData(primarySwatch: Colors.blue), 
      home: InitialScreen(),
    );
  }
}















