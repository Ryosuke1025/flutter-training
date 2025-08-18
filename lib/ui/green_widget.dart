import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_training/ui/mixin/navigation_mixin.dart';
import 'package:flutter_training/ui/weather_screen.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => GreenWidgetState();
}

class GreenWidgetState extends State<GreenWidget> with NavigationMixin {
  @override
  void initState() {
    super.initState();
    unawaited(delayedPush(context, const WeatherScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.green,
    );
  }
}
