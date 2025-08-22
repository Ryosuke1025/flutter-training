import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  final _weather = YumemiWeather();

  WeatherCondition fetchWeather() {
    try {
      final weatherConditionString = _weather.fetchThrowsWeather('tokyo');
      final weatherCondition = WeatherCondition.values.firstWhereOrNull(
        (e) => e.name == weatherConditionString,
      );
      if (weatherCondition == null) {
        // weatherConditionがnullの場合は、YumemiWeatherError.unknownをthrowする
        // ignore: only_throw_errors
        throw YumemiWeatherError.unknown;
      }
      return weatherCondition;
    } on YumemiWeatherError catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
