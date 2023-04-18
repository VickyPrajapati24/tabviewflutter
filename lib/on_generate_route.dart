import 'package:flutter/material.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      default:
        {
          Container();
        }
    }
    return null;
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(
      settings: const RouteSettings(name: '/', arguments: {}),
      builder: (context) => child);
}
