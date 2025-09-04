import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/ui/mixin/after_layout_mixin.dart';
import 'package:flutter_training/ui/screen/weather_screen.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => GreenWidgetState();
}

class GreenWidgetState extends State<GreenWidget> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.green,
    );
  }

  @override
  Future<void> performAfterLayout() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => const WeatherScreen()),
      );
      await performAfterLayout();
    }
  }
}
