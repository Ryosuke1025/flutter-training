import 'package:json_annotation/json_annotation.dart';

part 'weather_get_response.g.dart';

@JsonSerializable(
  createToJson: false,
  checked: true,
  disallowUnrecognizedKeys: true,
)
class WeatherGetResponse {
  const WeatherGetResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherGetResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherGetResponseFromJson(json);

  @JsonKey(name: 'weather_condition', required: true, disallowNullValue: true)
  final String weatherCondition;

  @JsonKey(name: 'max_temperature', required: true, disallowNullValue: true)
  final int maxTemperature;

  @JsonKey(name: 'min_temperature', required: true, disallowNullValue: true)
  final int minTemperature;

  @JsonKey(required: true, disallowNullValue: true)
  final String date;
}
