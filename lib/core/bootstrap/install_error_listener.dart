import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/extension/yumemi_weather_error_extension.dart';
import 'package:flutter_training/ui/providers/weather_providers.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

void installErrorListener(
  WidgetRef ref,
  GlobalKey<NavigatorState> navigatorKey,
) {
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
