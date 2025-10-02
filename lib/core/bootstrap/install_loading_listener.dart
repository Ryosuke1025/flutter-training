import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/ui/providers/weather_state_notifier_provider.dart';

void installLoadingListener(
  WidgetRef ref,
  GlobalKey<NavigatorState> navigatorKey,
) {
  OverlayEntry? loadingEntry;
  ref.listen(weatherStateNotifierProvider.select((s) => s.isLoading), (
    prev,
    next,
  ) {
    final currentContext = navigatorKey.currentContext;
    if (currentContext == null || identical(prev, next)) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final overlay = Navigator.of(currentContext).overlay;
      if (overlay == null) {
        return;
      }

      if (next) {
        if (loadingEntry != null) {
          return;
        }
        loadingEntry = _buildLoadingOverlayEntry();
        overlay.insert(loadingEntry!);
      } else {
        loadingEntry?.remove();
        loadingEntry = null;
      }
    });
  });
}

OverlayEntry _buildLoadingOverlayEntry() {
  return OverlayEntry(
    builder: (_) => const Stack(
      children: [
        ModalBarrier(dismissible: false, color: Colors.black54),
        Center(child: CircularProgressIndicator(color: Colors.blue)),
      ],
    ),
  );
}
