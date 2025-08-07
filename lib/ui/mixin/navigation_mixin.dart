import 'package:flutter/material.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  void delayedPush(BuildContext context, Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        if (context.mounted) {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => Scaffold(
                body: Center(
                  child: widget,
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
