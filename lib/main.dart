import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/bootstrap/install_error_listener.dart';
import 'package:flutter_training/core/di/overrides.dart';
import 'package:flutter_training/ui/widget/green_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ProviderScope(
      overrides: overrides,
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    installErrorListener(ref, navigatorKey);
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: const GreenWidget(),
    );
  }
}
