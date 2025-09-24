import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/core/entity/weather.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/ui/providers/weather_state_notifier_provider.dart';
import 'package:flutter_training/ui/screens/weather_screen.dart';

import 'mock/mock_weather_state_notifier.dart';

Future<void> _pumpWeatherScreenWithMockNotifier(
  WidgetTester tester, {
  required Weather weather,
}) async {
  // 適切な画面サイズを設定してレイアウトオーバーフローを防ぐ
  tester.view.physicalSize = const Size(1200, 2400);
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    tester.view.reset();
  });

  // WeatherScreenを起動してproviderを差し替え
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        weatherStateNotifierProvider.overrideWith(
          () => MockWeatherStateNotifier(weather: weather),
        ),
      ],
      child: const MaterialApp(
        home: WeatherScreen(),
      ),
    ),
  );
}

void main() {
  testWidgets('晴れの画像が表示されること', (tester) async {
    final weather = Weather(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 30,
      minTemperature: 20,
      date: DateTime.parse('2024-01-01T00:00:00Z'),
    );

    await _pumpWeatherScreenWithMockNotifier(tester, weather: weather);
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.bySemanticsLabel(weather.weatherCondition.name),
      findsOneWidget,
    );
  });

  testWidgets('曇りの画像が表示されること', (tester) async {
    final weather = Weather(
      weatherCondition: WeatherCondition.cloudy,
      maxTemperature: 30,
      minTemperature: 20,
      date: DateTime.parse('2024-01-01T00:00:00Z'),
    );

    await _pumpWeatherScreenWithMockNotifier(tester, weather: weather);
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.bySemanticsLabel(weather.weatherCondition.name),
      findsOneWidget,
    );
  });

  testWidgets('雨の画像が表示されること', (tester) async {
    final weather = Weather(
      weatherCondition: WeatherCondition.rainy,
      maxTemperature: 30,
      minTemperature: 20,
      date: DateTime.parse('2024-01-01T00:00:00Z'),
    );

    await _pumpWeatherScreenWithMockNotifier(tester, weather: weather);
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.bySemanticsLabel(weather.weatherCondition.name),
      findsOneWidget,
    );
  });

  testWidgets('最高気温が表示されること', (tester) async {
    final weather = Weather(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 30,
      minTemperature: 20,
      date: DateTime.parse('2024-01-01T00:00:00Z'),
    );

    await _pumpWeatherScreenWithMockNotifier(tester, weather: weather);
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(find.text('${weather.maxTemperature} ℃'), findsOneWidget);
  });

  testWidgets('最低気温が表示されること', (tester) async {
    final weather = Weather(
      weatherCondition: WeatherCondition.sunny,
      maxTemperature: 30,
      minTemperature: 20,
      date: DateTime.parse('2024-01-01T00:00:00Z'),
    );

    await _pumpWeatherScreenWithMockNotifier(tester, weather: weather);
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(find.text('${weather.minTemperature} ℃'), findsOneWidget);
  });
}
