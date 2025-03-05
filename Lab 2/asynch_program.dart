import 'dart:convert';
import 'dart:io';

Future<void> fetchWeather() async {
  String city = "Quetta";
  String apiKey = "51d5446871024b8cb4b174654250503"; 
  String url = "https://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city";

  try {
    final uri = Uri.parse(url);
    final request = await HttpClient().getUrl(uri);
    final response = await request.close();

    if (response.statusCode == 200) {
      final jsonString = await response.transform(utf8.decoder).join();
      final data = jsonDecode(jsonString);

      // ✅ Correct JSON structure
      String cityName = data["location"]["name"];
      double temp = data["current"]["temp_c"];
      String weather = data["current"]["condition"]["text"];

      print("City: $cityName");
      print("Temperature: $temp°C");
      print("Weather: $weather");
    } else {
      print("Error: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to fetch weather: $e");
  }
}

void main() {
  fetchWeather();
  print("Weather is being fetched ...");
}
