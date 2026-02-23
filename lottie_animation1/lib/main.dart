import 'package:flutter/material.dart';

import 'package:lottie_animation1/pages/animated_list_demo.dart';
import 'package:lottie_animation1/pages/button_animation_demo.dart';
import 'package:lottie_animation1/pages/explicit_animation_demo.dart';
import 'package:lottie_animation1/pages/hero_animation_demo.dart';
import 'package:lottie_animation1/pages/home_menu_page.dart';
import 'package:lottie_animation1/pages/implicit_animation_demo.dart';
import 'package:lottie_animation1/pages/my_home_page.dart';
import 'package:lottie_animation1/pages/page_transition_demo.dart';
import 'package:lottie_animation1/pages/physics_animation_demo.dart';
import 'package:lottie_animation1/pages/staggered_animation_demo.dart';
import 'package:lottie_animation1/utils/page_transitions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animation Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeMenuPage(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/lottie':
            return SlidePageRoute(page: const MyHomePage());
          case '/page-transitions':
            return FadePageRoute(page: const PageTransitionDemo());
          case '/button-animations':
            return ScalePageRoute(page: const ButtonAnimationDemo());
          case '/implicit-animations':
            return RotationPageRoute(page: const ImplicitAnimationDemo());
          case '/explicit-animations':
            return SlidePageRoute(page: const ExplicitAnimationDemo());
          case '/hero-animations':
            return FadePageRoute(page: const HeroAnimationDemo());
          case '/staggered-animations':
            return ScalePageRoute(page: const StaggeredAnimationDemo());
          case '/animated-list':
            return SlidePageRoute(page: const AnimatedListDemo());
          case '/physics-animations':
            return FadePageRoute(page: const PhysicsAnimationDemo());
          default:
            return MaterialPageRoute(builder: (_) => const HomeMenuPage());
        }
      },
    );
  }
}
