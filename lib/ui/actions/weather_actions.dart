class WeatherActions {
  const WeatherActions({required this.updateWeather, required this.clearError});

  final Future<void> Function({
    required String area,
    required DateTime date,
  })
  updateWeather;

  final void Function() clearError;
}
