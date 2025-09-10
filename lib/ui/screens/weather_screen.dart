import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/providers/weather_state_provider.dart';
import 'package:flutter_training/ui/widgets/weather_condition_widget.dart';
import 'package:flutter_training/ui/widgets/weather_temperature_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherStateProvider);
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.5,
          child: Column(
            children: [
              const Spacer(),
              WeatherConditionWidget(
                weatherCondition: state.weather?.weatherCondition,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: WeatherTemperatureWidget(
                  maxTemperature: state.weather?.maxTemperature,
                  minTemperature: state.weather?.minTemperature,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCloseButtonWidget(context),
                        ),
                        Expanded(
                          child: _buildReloadButtonWidget(ref),
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

  Widget _buildCloseButtonWidget(BuildContext context) {
    return TextButton(
      onPressed: () => _onPressedCloseButton(context),
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Close'),
    );
  }

  Widget _buildReloadButtonWidget(WidgetRef ref) {
    return TextButton(
      onPressed: () => _onPressedReloadButton(ref),
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Reload'),
    );
  }

  void _onPressedCloseButton(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPressedReloadButton(WidgetRef ref) {
    ref
        .read(weatherStateProvider.notifier)
        .updateWeather(area: 'tokyo', date: DateTime.now());
  }
}
