import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/ui/extension/weather_condition_ui_extension.dart';

class WeatherConditionWidget extends StatelessWidget {
  const WeatherConditionWidget({
    required this.weatherCondition,
    super.key,
  });

  final WeatherCondition? weatherCondition;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: weatherCondition?.icon ?? const Placeholder(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      EnumProperty<WeatherCondition>('weatherCondition', weatherCondition),
    );
  }
}
