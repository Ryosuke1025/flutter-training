import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/services/entity/weather.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherStore extends AutoDisposeNotifier<WeatherState> {
  @override
  WeatherState build() => const WeatherState();

  void setWeather(Weather weather) {
    state = state.copyWith(weather: weather);
  }

  void setError(YumemiWeatherError? error) {
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
