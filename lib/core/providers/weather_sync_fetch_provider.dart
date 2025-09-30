import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/providers/yumemi_weather_client_provider.dart';

typedef WeatherFetchEntry = Future<String> Function(String json);

final weatherSyncFetchProvider = Provider<WeatherFetchEntry>((ref) {
  return (json) => Isolate.run(
    () => ref.read(yumemiWeatherClientProvider).syncFetchWeather(json),
  );
});
