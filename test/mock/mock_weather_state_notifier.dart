import 'package:flutter_training/core/entity/weather.dart';
import 'package:flutter_training/ui/notifiers/weather_state_notifier.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MockWeatherStateNotifier extends WeatherStateNotifier {
  MockWeatherStateNotifier({
    this.error,
    this.weather,
  });

  final YumemiWeatherError? error;
  final Weather? weather;

  @override
  WeatherState build() => const WeatherState();

  @override
  void updateWeather({required String area, required DateTime date}) {
    if (error != null) {
      state = WeatherState(error: error);
    } else if (weather != null) {
      state = WeatherState(weather: weather);
    }
  }
}
