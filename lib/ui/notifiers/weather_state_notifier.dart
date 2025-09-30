import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/entity/weather.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/core/providers/weather_sync_fetch_provider.dart';
import 'package:flutter_training/core/request/weather_get_request.dart';
import 'package:flutter_training/core/response/weather_get_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherStateNotifier extends AutoDisposeNotifier<WeatherState> {
  WeatherStateNotifier();

  @override
  WeatherState build() {
    return const WeatherState();
  }

  Future<void> updateWeather({
    required String area,
    required DateTime date,
  }) async {
    _setLoading(true);
    try {
      final fetchedWeather = await _fetchWeather(
        area: area,
        date: date,
      );
      _setWeather(fetchedWeather);
    } on YumemiWeatherError catch (error, stackTrace) {
      _setError(error);
      log('Failed to fetchWeather.', error: error, stackTrace: stackTrace);
    }
  }

  void clearError() {
    _setError(null);
  }

  Future<Weather> _fetchWeather({
    required String area,
    required DateTime date,
  }) async {
    try {
      final request = WeatherGetRequest(area: area, date: date);
      final jsonString = jsonEncode(request.toJson());
      final fetchEntry = ref.read(weatherSyncFetchProvider);
      final responseJsonString = await fetchEntry(jsonString);
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
    state = state.copyWith(weather: weather, isLoading: false);
  }

  void _setError(YumemiWeatherError? error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  void _setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

class WeatherState {
  const WeatherState({this.weather, this.error, this.isLoading = false});

  final Weather? weather;
  final YumemiWeatherError? error;
  final bool isLoading;

  WeatherState copyWith({
    Weather? weather,
    YumemiWeatherError? error,
    bool? isLoading,
  }) => WeatherState(
    weather: weather ?? this.weather,
    error: error,
    isLoading: isLoading ?? this.isLoading,
  );
}
