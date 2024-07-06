import 'dart:convert'; // Import for JSON encoding and decoding
import 'package:http/http.dart' as http; // Import for making HTTP requests

// Service class to fetch weather data from OpenWeatherMap API
class WeatherService {
  
  final String apiKey = '35345b743f5f10c5ad8a843de96eb1d1';

  
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    // Construct the API URL with the city name and API key
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    
    // Make an HTTP GET request to the API
    final response = await http.get(Uri.parse(url));
    
    // If the response status code is 200 (OK), decode the JSON response
    if (response.statusCode == 200) {
      return json.decode(response.body); // Return parsed JSON data
    } else {
      // If the response status code is not 200, throw an exception
      throw Exception('Failed to load weather data'); 
    }
  }
}
