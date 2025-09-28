import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherProvider {
  Future<String> getWeather(String city) async {
    try {
      final url = Uri.parse("http://127.0.0.1:5000/weather?city=$city");
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        return jsonData["result"];
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return "Exception: $e";
    }
  }
}
