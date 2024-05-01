import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_servises.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  void initState() {
    _fetchWeather();
    super.initState();
  }

  final _weatherService = WeatherServices('f8dfe46a817c04dff354bd2a1be8c824');
  WeatherModel? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentLocation();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition != null) return 'assets/lottie/sunny.json';
    switch (mainCondition?.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/lottie/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/lottie/rainy.json';
      case 'thunderstorm':
        return 'assets/lottie/thunder.json';
      case 'clear':
      default:
        return 'assets/lottie/sunny.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? 'loading city.....'),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}゜C'),
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
