import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Durations.extralong1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'assets/animations/Interactive Mood Selector UI.json',
              repeat: true,
              reverse: true,
              width: 250,
            ),
          ),
          Lottie.asset(
            controller: _controller,
            'assets/animations/confetti.json',
            repeat: false,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
            // width: 250,
            // height: 250,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var ticker = _controller.forward();
          ticker.whenComplete(() => _controller.reset());
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
