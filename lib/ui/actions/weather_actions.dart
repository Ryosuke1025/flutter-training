class WeatherActions {
  const WeatherActions({required this.updateWeather, required this.clearError});

  final void Function({
    required String area,
    required DateTime date,
  })
  updateWeather;

  final void Function() clearError;
}
