import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/services/entity/weather_condition.dart';
import 'package:flutter_training/services/service/weather_service.dart';
import 'package:flutter_training/ui/widget/weather_condition_widget.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  final _weatherService = WeatherService();
  WeatherCondition? weatherCondition;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        children: [
          const Spacer(),
          WeatherConditionWidget(weatherCondition: weatherCondition),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildMinTemperatureWidget(context),
                ),
                Expanded(
                  child: _buildMaxTemperatureWidget(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: _buildCloseButtonWidget(),
                    ),
                    Expanded(
                      child: _buildReloadButtonWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMinTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(context, text: '** ℃', color: Colors.blue);
  }

  Widget _buildMaxTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(context, text: '** ℃', color: Colors.red);
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

  Widget _buildCloseButtonWidget() {
    return TextButton(
      onPressed: _onPressedCloseButton,
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Close'),
    );
  }

  Widget _buildReloadButtonWidget() {
    return TextButton(
      onPressed: _onPressedReloadButton,
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Reload'),
    );
  }

  void _onPressedCloseButton() {
    Navigator.pop(context);
  }

  void _onPressedReloadButton() {
    setState(() {
      weatherCondition = _weatherService.fetchWeather();
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      EnumProperty<WeatherCondition>('weatherCondition', weatherCondition),
    );
  }
}
