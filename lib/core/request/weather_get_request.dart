import 'package:json_annotation/json_annotation.dart';

part 'weather_get_request.g.dart';

@JsonSerializable(createFactory: false)
class WeatherGetRequest {
  const WeatherGetRequest({
    required this.area,
    required this.date,
  });

  final String area;
  final DateTime date;

  Map<String, dynamic> toJson() => _$WeatherGetRequestToJson(this);
}
