// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_get_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherGetResponse _$WeatherGetResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'WeatherGetResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'weather_condition',
            'max_temperature',
            'min_temperature',
            'date',
          ],
          requiredKeys: const [
            'weather_condition',
            'max_temperature',
            'min_temperature',
            'date',
          ],
          disallowNullValues: const [
            'weather_condition',
            'max_temperature',
            'min_temperature',
            'date',
          ],
        );
        final val = WeatherGetResponse(
          weatherCondition: $checkedConvert(
            'weather_condition',
            (v) => v as String,
          ),
          maxTemperature: $checkedConvert(
            'max_temperature',
            (v) => (v as num).toInt(),
          ),
          minTemperature: $checkedConvert(
            'min_temperature',
            (v) => (v as num).toInt(),
          ),
          date: $checkedConvert('date', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature',
      },
    );
