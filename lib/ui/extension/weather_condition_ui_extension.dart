import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';

extension WeatherConditionUiExtension on WeatherCondition {
  Widget get icon {
    switch (this) {
      case WeatherCondition.sunny:
        return SvgPicture.asset(
          'lib/ui/assets/sunny.svg',
          semanticsLabel: 'sunny',
        );
      case WeatherCondition.cloudy:
        return SvgPicture.asset(
          'lib/ui/assets/cloudy.svg',
          semanticsLabel: 'cloudy',
        );
      case WeatherCondition.rainy:
        return SvgPicture.asset(
          'lib/ui/assets/rainy.svg',
          semanticsLabel: 'rainy',
        );
    }
  }
}
