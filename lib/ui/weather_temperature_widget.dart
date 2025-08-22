import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherTemperatureWidget extends StatelessWidget {
  const WeatherTemperatureWidget({
    required this.minTemperature,
    required this.maxTemperature,
    super.key,
  });

  final int? minTemperature;
  final int? maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildMinTemperatureWidget(context),
        ),
        Expanded(
          child: _buildMaxTemperatureWidget(context),
        ),
      ],
    );
  }

  Widget _buildMinTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(
      context,
      text: '${minTemperature ?? '**'} ℃',
      color: Colors.blue,
    );
  }

  Widget _buildMaxTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(
      context,
      text: '${maxTemperature ?? '**'} ℃',
      color: Colors.red,
    );
  }

  Widget _buildTemperatureWidget(
    BuildContext context, {
    required String text,
    required Color color,
  }) {
    final baseStyle = Theme.of(context).textTheme.labelLarge;
    return Text(
      text,
      style: baseStyle?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('minTemperature', minTemperature));
    properties.add(IntProperty('maxTemperature', maxTemperature));
  }
}
