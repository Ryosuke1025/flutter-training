import 'dart:convert';

class WeatherGetResponse {
  const WeatherGetResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherGetResponse.fromJsonString(String jsonString) {
    final map = jsonDecode(jsonString);
    if (map is! Map<String, dynamic>) {
      throw const FormatException('Root is not an object');
    }

    final wc = map['weather_condition'];
    if (wc is! String || wc.isEmpty) {
      throw const FormatException('weather_condition is missing/invalid');
    }

    final max = map['max_temperature'];
    if (max is! int) {
      throw const FormatException('max_temperature is missing/invalid');
    }

    final min = map['min_temperature'];
    if (min is! int) {
      throw const FormatException('min_temperature is missing/invalid');
    }

    final dateStr = map['date'];
    final date = (dateStr is String) ? DateTime.tryParse(dateStr) : null;
    if (date == null) {
      throw const FormatException('date is not a valid ISO-8601 string');
    }

    return WeatherGetResponse(
      weatherCondition: wc,
      maxTemperature: max,
      minTemperature: min,
      date: date,
    );
  }

  final String weatherCondition;
  final int maxTemperature;
  final int minTemperature;
  final DateTime date;
}
