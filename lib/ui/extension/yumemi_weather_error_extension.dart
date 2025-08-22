import 'package:yumemi_weather/yumemi_weather.dart';

extension YumemiWeatherErrorExtension on YumemiWeatherError {
  String get description {
    switch (this) {
      case YumemiWeatherError.invalidParameter:
        return '無効なパラメーターが指定されました。';
      case YumemiWeatherError.unknown:
        return '不明なエラーが発生しました。';
    }
  }
}
