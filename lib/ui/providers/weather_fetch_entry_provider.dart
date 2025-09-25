import 'dart:isolate';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

typedef WeatherFetchEntry = Future<String> Function(String json);

final weatherSyncFetchProvider = Provider<WeatherFetchEntry>((ref) {
  return (json) => Isolate.run(() => YumemiWeather().syncFetchWeather(json));
});
