import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:puzzle_game/app/config/app_colors.dart';
import 'package:puzzle_game/app/routes/app_routes.dart';
import 'package:puzzle_game/presentation/pages/home/home_controller.dart';
import 'package:puzzle_game/presentation/widgets/responsive_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobileWidget: _buildMobileView(),
      desktopWidget: _buildDesktopView(),
    );
  }

  Widget _buildMobileView() {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      // drawer: Drawer(),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_buildHeroSection()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Center(
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              text: "Welcome to",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.normal,
                color: Color(0xFFcbcbcb),
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Tile ",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: AppColors.primary.withOpacity(0.5),
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                TextSpan(
                  text: "Puzzle",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: AppColors.secondary,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: AppColors.secondary.withOpacity(0.5),
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Lottie.asset(
            'assets/animation/motion_quizflip_loop.json',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(AppRoutes.LEVELS, arguments: {"mode": "single"});
                },
                icon: const Icon(Icons.person),
                label: const Text("Single Player"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(AppRoutes.LEVELS, arguments: {"mode": "two"});
                },
                icon: const Icon(Icons.people),
                label: const Text("Two Player"),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: "Play multiple levels of game with single and two player mode",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Color(0xFFcbcbcb),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildDesktopView() {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), centerTitle: true),
      body: Row(
        children: [Expanded(child: Center(child: Text("Home1")))],
      ),
    );
  }
}
