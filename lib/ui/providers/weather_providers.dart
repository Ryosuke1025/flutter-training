import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/services/service/weather_service.dart';
import 'package:flutter_training/ui/actions/weather_actions.dart';
import 'package:flutter_training/ui/state/weather_state.dart';

final weatherServiceProvider = Provider<WeatherService>(
  (ref) => WeatherService(
    setWeather: ref.read(weatherStateProvider.notifier).setWeather,
    setError: ref.read(weatherStateProvider.notifier).setError,
  ),
);

final weatherActionsProvider = Provider<WeatherActions>(
  (ref) => throw UnimplementedError('Provide WeatherActions via overrides'),
);

final weatherStateProvider =
    AutoDisposeNotifierProvider<WeatherStore, WeatherState>(
      WeatherStore.new,
    );
