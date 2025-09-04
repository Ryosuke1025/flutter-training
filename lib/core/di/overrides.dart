import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/actions/weather_actions.dart';
import 'package:flutter_training/ui/providers/weather_providers.dart';

List<Override> overrides = [
  weatherActionsProvider.overrideWith((ref) {
    final service = ref.watch(weatherServiceProvider);
    return WeatherActions(
      updateWeather: ({required area, required date}) async =>
          service.updateWeather(area: area, date: date),
      clearError: service.clearError,
    );
  }),
];
