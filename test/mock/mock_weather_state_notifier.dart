import 'package:flutter_training/core/entity/weather.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/ui/notifiers/weather_state_notifier.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class MockWeatherStateNotifier extends WeatherStateNotifier {
  MockWeatherStateNotifier({
    this.shouldFail = false,
    this.weatherCondition = WeatherCondition.sunny,
  });

  final bool shouldFail;
  final WeatherCondition weatherCondition;

  @override
  WeatherState build() => const WeatherState();

  @override
  void updateWeather({required String area, required DateTime date}) {
    if (shouldFail) {
      state = const WeatherState(error: YumemiWeatherError.invalidParameter);
    } else {
      state = WeatherState(
        weather: Weather(
          weatherCondition: weatherCondition,
          maxTemperature: 30,
          minTemperature: 20,
          date: DateTime.parse('2024-01-01T00:00:00Z'),
        ),
      );
    }
  }
}
