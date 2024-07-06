import 'package:flutter/material.dart'; 
import 'package:shared_preferences/shared_preferences.dart'; // Importing shared preferences for storing data locally
import 'weather_service.dart'; 

// This class helps to manage the weather data and notify the app about changes
class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService(); 
  Map<String, dynamic>? _weatherData; 
  bool _isLoading = false; 

  // Getter to get the weather data
  Map<String, dynamic>? get weatherData => _weatherData;
  
  bool get isLoading => _isLoading;

  // Function to fetch weather data for a specific city
  Future<void> fetchWeather(String city) async {
    _isLoading = true; 
    notifyListeners(); // Notify listeners about the change

    try {
      _weatherData = await _weatherService.fetchWeather(city); 
      _saveLastSearchedCity(city); // Save the last searched city locally
    } catch (e) {
      _weatherData = null; // If there's an error, set weather data to null
    }

    _isLoading = false; 
    notifyListeners(); 
  }

  // Function to save the last searched city using shared preferences
  Future<void> _saveLastSearchedCity(String city) async {
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setString('lastSearchedCity', city); 
  }

  // Function to load the last searched city from shared preferences
  Future<String?> loadLastSearchedCity() async {
    final prefs = await SharedPreferences.getInstance(); 
    return prefs.getString('lastSearchedCity'); 
  }
}




