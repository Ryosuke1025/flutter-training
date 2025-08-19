import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  Future<void> performAfterLayout(Future<void> Function() action) async {
    await WidgetsBinding.instance.endOfFrame;
    if (mounted) {
      await action();
    }
  }
}
