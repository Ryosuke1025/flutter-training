import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/entity/weather.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/core/request/weather_get_request.dart';
import 'package:flutter_training/core/response/weather_get_response.dart';
import 'package:flutter_training/ui/providers/yumemi_weather_client_provider.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherStateNotifier extends AutoDisposeNotifier<WeatherState> {
  WeatherStateNotifier();

  late final YumemiWeather yumemiWeatherClient;

  @override
  WeatherState build() {
    yumemiWeatherClient = ref.read(yumemiWeatherClientProvider);
    return const WeatherState();
  }

  void updateWeather({
    required String area,
    required DateTime date,
  }) {
    try {
      final fetchedWeather = _fetchWeather(area: area, date: date);
      _setWeather(fetchedWeather);
    } on YumemiWeatherError catch (error, stackTrace) {
      _setError(error);
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
    }
  }

  void clearError() {
    _setError(null);
  }

  Weather _fetchWeather({
    required String area,
    required DateTime date,
  }) {
    try {
      final request = WeatherGetRequest(area: area, date: date);
      final jsonString = jsonEncode(request.toJson());
      final responseJsonString = yumemiWeatherClient.fetchWeather(jsonString);
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

  void _setWeather(Weather weather) {
    state = state.copyWith(weather: weather);
  }

  void _setError(YumemiWeatherError? error) {
    state = state.copyWith(error: error);
  }
}

class WeatherState {
  const WeatherState({this.weather, this.error});

  final Weather? weather;
  final YumemiWeatherError? error;

  WeatherState copyWith({Weather? weather, YumemiWeatherError? error}) =>
      WeatherState(
        weather: weather,
        error: error,
      );
}
