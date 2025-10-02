import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/bootstrap/install_error_listener.dart';
import 'package:flutter_training/core/bootstrap/install_loading_listener.dart';
import 'package:flutter_training/ui/widgets/green_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
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
