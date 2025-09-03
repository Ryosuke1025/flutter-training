import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/actions/weather_actions.dart';
import 'package:flutter_training/ui/extension/yumemi_weather_error_extension.dart';
import 'package:flutter_training/ui/green_widget.dart';
import 'package:flutter_training/ui/providers/weather_providers.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final navigatorKey = GlobalKey<NavigatorState>();

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

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenError(ref);
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const GreenWidget(),
    );
  }

  void _listenError(WidgetRef ref) {
    ref.listen(weatherStateProvider.select((state) => state.error), (
      prev,
      next,
    ) {
      final currentContext = navigatorKey.currentContext;
      if (currentContext == null || next == null || identical(prev, next)) {
        return;
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        unawaited(_showErrorDialog(currentContext, next, ref));
      });
    });
  }

  Future<void> _showErrorDialog(
    BuildContext context,
    YumemiWeatherError error,
    WidgetRef ref,
  ) async {
    if (context.mounted) {
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: Text(error.title),
            content: Text(error.description),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  ref.read(weatherActionsProvider).clearError();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
