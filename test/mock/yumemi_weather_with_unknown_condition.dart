import 'package:yumemi_weather/yumemi_weather.dart';

final class YumemiWeatherWithUnknownCondition extends YumemiWeather {
  @override
  String syncFetchWeather(String requestJson) =>
      '{\n'
      '  "weather_condition": "stormy",\n'
      '  "max_temperature": 30,\n'
      '  "min_temperature": 20,\n'
      '  "date": "2024-01-01T00:00:00Z"\n'
      '}';
}
