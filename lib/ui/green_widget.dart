import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/ui/weather_screen.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => GreenWidgetState();
}

class GreenWidgetState extends State<GreenWidget> {
  @override
  void initState() {
    super.initState();
    unawaited(transitionToWeatherWidget());
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.green,
    );
  }

  Future<void> transitionToWeatherWidget() async {
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => const WeatherScreen()),
      );
      await transitionToWeatherWidget();
    }
  }
}
