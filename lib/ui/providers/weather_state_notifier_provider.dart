import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/notifiers/weather_state_notifier.dart';

final weatherStateNotifierProvider =
    AutoDisposeNotifierProvider<WeatherStateNotifier, WeatherState>(
      WeatherStateNotifier.new,
    );
