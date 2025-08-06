import 'package:collection/collection.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherService {
  final _weather = YumemiWeather();

  WeatherCondition? fetchWeather() {
    final weatherConditionString = _weather.fetchSimpleWeather();
    return WeatherCondition.values.firstWhereOrNull(
      (e) => e.name == weatherConditionString,
    );
  }
}
