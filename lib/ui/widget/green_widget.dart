import 'package:flutter/material.dart';
import 'package:flutter_training/ui/mixin/navigation_mixin.dart';
import 'package:flutter_training/ui/route_observer.dart';
import 'package:flutter_training/ui/widget/weather_widget.dart';

class GreenWidget extends StatefulWidget {
  const GreenWidget({super.key});

  @override
  State<GreenWidget> createState() => GreenWidgetState();
}

class GreenWidgetState extends State<GreenWidget>
    with RouteAware, NavigationMixin {
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
    delayedPush(context, const WeatherWidget());
  }

  @override
  void didPopNext() {
    delayedPush(context, const WeatherWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
    );
  }
}
