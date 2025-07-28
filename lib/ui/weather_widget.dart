import 'dart:developer';
import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildSquarePlaceholderWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildMinTemperatureWidget(context),
                ),
                Expanded(
                  child: _buildMaxTemperatureWidget(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Row(
                  children: [
                    Expanded(
                      child: _buildCloseButtonWidget(),
                    ),
                    Expanded(
                      child: _buildReloadButtonWidget(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquarePlaceholderWidget() {
    return const AspectRatio(
      aspectRatio: 1,
      child: Placeholder(),
    );
  }

  Widget _buildMinTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(context, text: '** ℃', color: Colors.blue);
  }

  Widget _buildMaxTemperatureWidget(BuildContext context) {
    return _buildTemperatureWidget(context, text: '** ℃', color: Colors.red);
  }

  Widget _buildTemperatureWidget(
    BuildContext context, {
    required String text,
    required Color color,
  }) {
    final baseStyle = Theme.of(context).textTheme.labelLarge;
    return Text(
      text,
      style: baseStyle?.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCloseButtonWidget() {
    return TextButton(
      onPressed: _onPressedCloseButton,
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Close'),
    );
  }

  Widget _buildReloadButtonWidget() {
    return TextButton(
      onPressed: _onPressedReloadButton,
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: const Text('Reload'),
    );
  }

  void _onPressedCloseButton() {
    log('Close Button Pressed!');
  }

  void _onPressedReloadButton() {
    log('Reload Button Pressed!');
  }
}
