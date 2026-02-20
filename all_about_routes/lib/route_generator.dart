import 'package:all_about_routes/pages/page2.dart';
import 'package:all_about_routes/pages/page3.dart';
import 'package:all_about_routes/pages/page4.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/page2":
        return MaterialPageRoute(builder: (_) => Page2());
      case "/page3":
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Page3(data: args));
        }
        return _errorRoute();
      case "/page4":
        return MaterialPageRoute(builder: (_) => Page4());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text("Error"),
      ),
      body: Center(
        child: Text("Error"),
      ),
    ));
  }
}
