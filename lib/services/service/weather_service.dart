import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter_training/services/entity/weather.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';
import 'package:flutter_training/services/request/weather_get_request.dart';
import 'package:flutter_training/services/response/weather_get_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  final _weather = YumemiWeather();

  Weather fetchWeather({
    required String area,
    required DateTime date,
  }) {
    try {
      final request = WeatherGetRequest(area: area, date: date);
      final jsonString = jsonEncode(request.toMap());
      final responseJsonString = _weather.fetchWeather(jsonString);
      final response = WeatherGetResponse.fromJsonString(responseJsonString);
      final weatherCondition = WeatherCondition.values.firstWhereOrNull(
        (e) => e.name == response.weatherCondition,
      );
      if (weatherCondition == null) {
        // weatherConditionがnullの場合は、YumemiWeatherError.unknownをthrowする
        // ignore: only_throw_errors
        throw YumemiWeatherError.unknown;
      }
      return Weather(
        weatherCondition: weatherCondition,
        maxTemperature: response.maxTemperature,
        minTemperature: response.minTemperature,
        date: response.date,
      );
    } on YumemiWeatherError catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
