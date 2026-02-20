import 'package:all_about_routes/pages/page2.dart';
import 'package:all_about_routes/pages/page3.dart';
import 'package:all_about_routes/pages/page4.dart';
import 'package:flutter/material.dart';

import 'package:all_about_routes/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        '/page2': (_) => Page2(),
        '/page3': (_) => Page3(data: "page 3 static data"),
        '/page4': (_) => Page4(),
      },
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),

      home: const HomePage(),
    );
  }
}
