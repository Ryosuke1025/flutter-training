import 'package:flutter/material.dart';
import 'package:flutter_training/ui/green_widget.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        weatherActionsProvider.overrideWith((ref) {
          final service = ref.watch(weatherServiceProvider);
          return WeatherActions(
            updateWeather: ({required area, required date}) async {
              service.updateWeather(area: area, date: date);
            },
            clearError: service.clearError,
          );
        }),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GreenWidget(),
    );
  }
}
