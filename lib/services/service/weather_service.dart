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
      return Weather(
        weatherCondition: weatherCondition,
        maxTemperature: response.maxTemperature,
        minTemperature: response.minTemperature,
        date: parsedDate,
      );
    } on YumemiWeatherError catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      rethrow;
    } on FormatException catch (error, stackTrace) {
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
      // Jsonのパースに失敗した場合は、YumemiWeatherError.unknownをthrowする
      // ignore: only_throw_errors
      throw YumemiWeatherError.unknown;
    }
  }
}
