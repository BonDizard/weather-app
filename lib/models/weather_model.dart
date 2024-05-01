class WeatherModel {
  final String cityName;
  final String mainCondition;
  final double temperature;

//<editor-fold desc="Data Methods">
  const WeatherModel({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
    );
  }

//</editor-fold>
}
