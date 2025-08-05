import 'package:flutter/material.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => _GreenWidgetState();
}

class _GreenWidgetState extends State<GreenWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
