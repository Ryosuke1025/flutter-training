import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/bootstrap/install_error_listener.dart';
import 'package:flutter_training/core/bootstrap/install_loading_listener.dart';
import 'package:flutter_training/core/providers/weather_sync_fetch_provider.dart';
import 'package:flutter_training/ui/widgets/green_widget.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ProviderScope(
      overrides: [
        weatherSyncFetchProvider.overrideWith((ref) {
          return (json) => Isolate.run(() {
            final client = YumemiWeather();
            return client.syncFetchWeather(json);
          });
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
    installErrorListener(ref, navigatorKey);
    installLoadingListener(ref, navigatorKey);
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const GreenWidget(),
    );
  }
}
