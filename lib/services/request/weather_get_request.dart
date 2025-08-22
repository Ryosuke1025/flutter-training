class WeatherGetRequest {
  const WeatherGetRequest({
    required this.area,
    required this.date,
  });

  final String area;
  final DateTime date;

  Map<String, dynamic> toMap() => <String, dynamic>{
    'area': area,
    'date': date.toIso8601String(),
  };
}
