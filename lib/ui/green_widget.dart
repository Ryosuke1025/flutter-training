import 'package:flutter/material.dart';
import 'package:flutter_training/ui/route_observer.dart';
import 'package:flutter_training/ui/weather_widget.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => GreenWidgetState();
}

class GreenWidgetState extends State<GreenWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _pushWeatherWidget(context);
  }

  @override
  void didPopNext() {
    _pushWeatherWidget(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }

  void _pushWeatherWidget(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 500), () async {
        if (context.mounted) {
          await Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const Scaffold(
                body: Center(
                  child: WeatherWidget(),
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
