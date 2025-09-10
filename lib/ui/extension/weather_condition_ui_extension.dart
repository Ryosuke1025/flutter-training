import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/gen/assets.gen.dart';

extension WeatherConditionUiExtension on WeatherCondition {
  Widget get icon {
    switch (this) {
      case WeatherCondition.sunny:
        return SvgPicture.asset(
          Assets.sunny,
          semanticsLabel: 'sunny',
        );
      case WeatherCondition.cloudy:
        return SvgPicture.asset(
          Assets.cloudy,
          semanticsLabel: 'cloudy',
        );
      case WeatherCondition.rainy:
        return SvgPicture.asset(
          Assets.rainy,
          semanticsLabel: 'rainy',
        );
    }
  }
}
