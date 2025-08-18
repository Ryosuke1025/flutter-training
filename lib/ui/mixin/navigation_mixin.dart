import 'package:flutter/material.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  Future<void> delayedPush(BuildContext context, Widget widget) async {
    await WidgetsBinding.instance.endOfFrame;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (context.mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => widget),
      );
      if (context.mounted) {
        await delayedPush(context, widget);
      }
    }
  }
}
