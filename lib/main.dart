import 'package:flutter/material.dart';
import 'package:flutter_training/ui/route_observer.dart';
import 'package:flutter_training/ui/widget/green_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      home: const Scaffold(
        body: Center(
          child: GreenWidget(),
        ),
      ),
    );
  }
}
