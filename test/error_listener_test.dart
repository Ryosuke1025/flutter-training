import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/main.dart';
import 'package:flutter_training/ui/providers/weather_state_notifier_provider.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'mock/mock_weather_state_notifier.dart';

Future<void> _pumpMainAppWithErrorNotifier(
  WidgetTester tester, {
  required YumemiWeatherError error,
}) async {
  final container = ProviderContainer(
    overrides: [
      weatherStateNotifierProvider.overrideWith(
        () => MockWeatherStateNotifier(error: error),
      ),
    ],
  );

  // 適切な画面サイズを設定してレイアウトオーバーフローを防ぐ
  tester.view.physicalSize = const Size(1200, 2400);
  tester.view.devicePixelRatio = 1.0;

  addTearDown(() {
    container.dispose();
    tester.view.reset();
  });

  // MainAppを起動
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );

  // GreenWidgetから500ms後にWeatherScreenに自動遷移するのを待つ
  await tester.pumpAndSettle(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('無効なパラメーターエラーダイアログが表示されること', (tester) async {
    await _pumpMainAppWithErrorNotifier(
      tester,
      error: YumemiWeatherError.invalidParameter,
    );

    // Reloadボタンをタップ
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('天気の取得に失敗しました。'), findsOneWidget);
    expect(find.text('無効なパラメーターが指定されました。'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    // OKボタンをタップ
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('不明なエラーダイアログが表示されること', (tester) async {
    await _pumpMainAppWithErrorNotifier(
      tester,
      error: YumemiWeatherError.unknown,
    );

    // Reloadボタンをタップ
    await tester.tap(find.text('Reload'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('天気の取得に失敗しました。'), findsOneWidget);
    expect(find.text('不明なエラーが発生しました。'), findsOneWidget);
    expect(find.text('OK'), findsOneWidget);

    // OKボタンをタップ
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
  });
}
