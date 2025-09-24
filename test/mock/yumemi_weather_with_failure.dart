import 'package:yumemi_weather/yumemi_weather.dart';

final class YumemiWeatherWithFailure extends YumemiWeather {
  @override
  String fetchWeather(String requestJson) {
    // テストのため単一のエラーをthrowする
    // ignore: only_throw_errors
    throw YumemiWeatherError.invalidParameter;
  }
}
