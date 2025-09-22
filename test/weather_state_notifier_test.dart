import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/ui/providers/weather_state_notifier_provider.dart';
import 'package:flutter_training/ui/providers/yumemi_weather_client_provider.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'mock/yumemi_weather_with_failure.dart';
import 'mock/yumemi_weather_with_invalid_date.dart';
import 'mock/yumemi_weather_with_success.dart';
import 'mock/yumemi_weather_with_unknown_condition.dart';

ProviderContainer _makeContainerWith(YumemiWeather client) {
  return ProviderContainer(
    overrides: [
      yumemiWeatherClientProvider.overrideWithValue(client),
    ],
  );
}

void _runSuccessFlow() {
  final container = _makeContainerWith(YumemiWeatherWithSuccess());

  // 初期 state を検証
  final initial = container.read(weatherStateNotifierProvider);
  expect(initial.weather, isNull);
  expect(initial.error, isNull);

  // 取得実行
  container
      .read(weatherStateNotifierProvider.notifier)
      .updateWeather(area: 'tokyo', date: DateTime.now());

  // state を検証
  final state = container.read(weatherStateNotifierProvider);
  expect(state.error, isNull);
  expect(state.weather, isNotNull);
  expect(state.weather!.weatherCondition, WeatherCondition.sunny);
  expect(state.weather!.minTemperature, 20);
  expect(state.weather!.maxTemperature, 30);
  expect(state.weather!.date, DateTime.parse('2024-01-01T00:00:00Z'));
}

void _runFailureFlow() {
  final container = _makeContainerWith(YumemiWeatherWithFailure());

  // 取得実行
  container
      .read(weatherStateNotifierProvider.notifier)
      .updateWeather(area: 'tokyo', date: DateTime.now());

  // stateを検証
  final state1 = container.read(weatherStateNotifierProvider);
  expect(state1.error, YumemiWeatherError.invalidParameter);
  expect(state1.weather, isNull);

  // エラーをクリアした後stateを検証
  container.read(weatherStateNotifierProvider.notifier).clearError();
  final state2 = container.read(weatherStateNotifierProvider);
  expect(state2.error, isNull);
}

void _runUnknownConditionFlow() {
  final container = _makeContainerWith(YumemiWeatherWithUnknownCondition());
  container
      .read(weatherStateNotifierProvider.notifier)
      .updateWeather(area: 'tokyo', date: DateTime.utc(2024));
  final state = container.read(weatherStateNotifierProvider);
  expect(state.error, YumemiWeatherError.unknown);
  expect(state.weather, isNull);
}

void _runInvalidDateFlow() {
  final container = _makeContainerWith(YumemiWeatherWithInvalidDate());
  container
      .read(weatherStateNotifierProvider.notifier)
      .updateWeather(area: 'tokyo', date: DateTime.utc(2024));
  final state = container.read(weatherStateNotifierProvider);
  expect(state.error, YumemiWeatherError.unknown);
  expect(state.weather, isNull);
}

void main() {
  test('success: WeatherScreen reflects fetched values', _runSuccessFlow);
  test('failure: sets error and clearError clears it', _runFailureFlow);
  test(
    'failure: decode unknown weather_condition maps to unknown error',
    _runUnknownConditionFlow,
  );
  test(
    'failure: decode invalid date maps to unknown error',
    _runInvalidDateFlow,
  );
}
