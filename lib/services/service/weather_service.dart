import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter_training/services/entity/weather.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';
import 'package:flutter_training/services/request/weather_get_request.dart';
import 'package:flutter_training/services/response/weather_get_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  WeatherService({required this.setWeather, required this.setError});

  final _weather = YumemiWeather();
  final void Function(Weather) setWeather;
  final void Function(YumemiWeatherError?) setError;

  void updateWeather({
    required String area,
    required DateTime date,
  }) {
    try {
      final weather = _fetchWeather(area: area, date: date);
      setWeather(weather);
    } on YumemiWeatherError catch (error, stackTrace) {
      setError(error);
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
    }
  }

  void clearError() {
    setError(null);
  }

  Weather _fetchWeather({
    required String area,
    required DateTime date,
  }) {
    try {
      final request = WeatherGetRequest(area: area, date: date);
      final jsonString = jsonEncode(request.toJson());
      final responseJsonString = _weather.fetchWeather(jsonString);
      final response = WeatherGetResponse.fromJson(
        jsonDecode(responseJsonString) as Map<String, dynamic>,
      );
      final weatherCondition = WeatherCondition.values.firstWhereOrNull(
        (e) => e.name == response.weatherCondition,
      );
      if (weatherCondition == null) {
        // weatherConditionがnullの場合は、YumemiWeatherError.unknownをthrowする
        // ignore: only_throw_errors
        throw YumemiWeatherError.unknown;
      }
      final parsedDate = DateTime.parse(response.date);
      final weather = Weather(
        weatherCondition: weatherCondition,
        maxTemperature: response.maxTemperature,
        minTemperature: response.minTemperature,
        date: parsedDate,
      );
      return weather;
    } on YumemiWeatherError catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      rethrow;
    } on Exception catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      // Jsonのパースに失敗した場合は、YumemiWeatherError.unknownをthrowする
      // ignore: only_throw_errors
      throw YumemiWeatherError.unknown;
    }
  }
}
