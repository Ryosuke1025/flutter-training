import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/core/entity/weather_condition.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/ui/providers/weather_state_notifier_provider.dart';

import 'mock/mock_weather_state_notifier.dart';

Future<ProviderContainer> _pumpMainAppWithMockNotifier(
  WidgetTester tester, {
  bool shouldFail = false,
  WeatherCondition weatherCondition = WeatherCondition.sunny,
}) async {
  final container = ProviderContainer(
    overrides: [
      weatherStateNotifierProvider.overrideWith(
        () => MockWeatherStateNotifier(
          shouldFail: shouldFail,
          weatherCondition: weatherCondition,
        ),
      ),
    ],
  );

  tester.view.physicalSize = const Size(1200, 2400);
  tester.view.devicePixelRatio = 1.0;

  // MainAppを起動
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );

  // GreenWidgetから500ms後にWeatherScreenに自動遷移するのを待つ
  await tester.pumpAndSettle(const Duration(milliseconds: 500));

  return container;
}

void main() {
  testWidgets('晴れの画像が表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(tester);
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SvgPicture && widget.semanticsLabel == 'sunny',
      ),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('曇りの画像が表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(
      tester,
      weatherCondition: WeatherCondition.cloudy,
    );
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SvgPicture && widget.semanticsLabel == 'cloudy',
      ),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('雨の画像が表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(
      tester,
      weatherCondition: WeatherCondition.rainy,
    );
    expect(find.byType(SvgPicture), findsNothing);

    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(
      find.byWidgetPredicate(
        (widget) => widget is SvgPicture && widget.semanticsLabel == 'rainy',
      ),
      findsOneWidget,
    );
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('最高気温が表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(tester);
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    final maxTempFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data == '30 ℃' &&
          widget.style?.color == Colors.red,
    );
    expect(maxTempFinder, findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('最低気温が表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(tester);
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    final minTempFinder = find.byWidgetPredicate(
      (widget) =>
          widget is Text &&
          widget.data == '20 ℃' &&
          widget.style?.color == Colors.blue,
    );
    expect(minTempFinder, findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('エラーダイアログが表示されること', (tester) async {
    await _pumpMainAppWithMockNotifier(tester, shouldFail: true);
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('天気の取得に失敗しました。'), findsOneWidget);
    expect(find.text('無効なパラメーターが指定されました。'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });
}
