import 'dart:convert';

class WeatherGetResponse {
  const WeatherGetResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherGetResponse.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return WeatherGetResponse(
      weatherCondition: json['weather_condition'] as String,
      maxTemperature: json['max_temperature'] as int,
      minTemperature: json['min_temperature'] as int,
      date: DateTime.parse(json['date'] as String),
    );
  }

  final String weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
