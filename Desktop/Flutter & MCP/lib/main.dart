import 'package:flutter/material.dart';
import 'providers/weather_provider.dart';

void main() {
  runApp(const MCPWeatherApp());
}

class MCPWeatherApp extends StatelessWidget {
  const MCPWeatherApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCP Weather (Demo)',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const WeatherPage(),
    );
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _controller = TextEditingController(text: "Bangkok");
  String _result = "ผลลัพธ์จะโชว์ตรงนี้";

  Future<void> _onGetWeather() async {
    final provider = WeatherProvider();
    final res = await provider.getWeather(_controller.text.trim());
    setState(() => _result = res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Weather via MCP (Local)")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Enter city",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _onGetWeather,
              child: const Text("Get Weather"),
            ),
            const SizedBox(height: 24),
            SelectableText(
              _result,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
