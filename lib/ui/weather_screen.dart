import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/services/entity/weather.dart';
import 'package:flutter_training/services/service/weather_service.dart';
import 'package:flutter_training/ui/extension/yumemi_weather_error_extension.dart';
import 'package:flutter_training/ui/weather_condition_widget.dart';
import 'package:flutter_training/ui/weather_temperature_widget.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService();
  Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherConditionWidget(
                weatherCondition: weather?.weatherCondition,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: WeatherTemperatureWidget(
                  maxTemperature: weather?.maxTemperature,
                  minTemperature: weather?.minTemperature,
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
        ),
      ),
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
    final newWeather = _weatherService.fetchWeather(
      area: 'tokyo',
      date: DateTime.now(),
    );

    if (newWeather == null) {
      unawaited(_showErrorDialog());
      return;
    }

    setState(() {
      weather = newWeather;
    });
  }

  Future<void> _showErrorDialog(String description) async {
    if (mounted) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('天気の取得に失敗しました。'),
            content: Text(description),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<Weather?>('weather', weather),
    );
  }
}
