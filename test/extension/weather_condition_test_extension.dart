import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';

extension WeatherConditionTestExtension on WeatherCondition {
  Finder get finder => find.byWidgetPredicate(
    (widget) => widget is SvgPicture && widget.semanticsLabel == name,
  );
}
