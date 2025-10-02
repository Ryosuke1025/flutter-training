import 'package:yumemi_weather/yumemi_weather.dart';

final class YumemiWeatherWithInvalidDate extends YumemiWeather {
  @override
  String syncFetchWeather(String requestJson) =>
      '{\n'
      '  "weather_condition": "sunny",\n'
      '  "max_temperature": 30,\n'
      '  "min_temperature": 20,\n'
      '  "date": "invalid"\n'
      '}';
}
