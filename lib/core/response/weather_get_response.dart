import 'package:json_annotation/json_annotation.dart';

part 'weather_get_response.g.dart';

@JsonSerializable(createToJson: false)
class WeatherGetResponse {
  const WeatherGetResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
    required this.date,
  });

  factory WeatherGetResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherGetResponseFromJson(json);

  @JsonKey(required: true, disallowNullValue: true)
  final String weatherCondition;

  @JsonKey(required: true, disallowNullValue: true)
  final int maxTemperature;

  @JsonKey(required: true, disallowNullValue: true)
  final int minTemperature;

  @JsonKey(required: true, disallowNullValue: true)
  final String date;
}
