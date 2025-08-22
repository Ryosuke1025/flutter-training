// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherGetResponse _$WeatherGetResponseFromJson(Map<String, dynamic> json) =>
    WeatherGetResponse(
      weatherCondition: json['weather_condition'] as String,
      maxTemperature: (json['max_temperature'] as num).toInt(),
      minTemperature: (json['min_temperature'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
    );
