import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_game/app/config/app_colors.dart';
import 'package:puzzle_game/app/routes/app_routes.dart';
import 'package:puzzle_game/presentation/pages/levels/levels_controller.dart';
import 'package:puzzle_game/presentation/widgets/responsive_widget.dart';
import 'dart:math' as math;

class LevelsView extends GetView<LevelsController> {
  const LevelsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobileWidget: _buildMobileView(),
      desktopWidget: _buildDesktopView(),
    );
  }

  Widget _buildMobileView() {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Level")),
      body: Center(
        child: Obx(
          () => Column(
            children: [
              const SizedBox(height: 32),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final rotateAnim = Tween(
                    begin: 3.14,
                    end: 0.0,
                  ).animate(animation);
                  return AnimatedBuilder(
                    animation: rotateAnim,
                    child: child,
                    builder: (context, widget) {
                      final isUnder =
                          (ValueKey(
                            controller.mode.value == 'single'
                                ? 'single'
                                : 'two',
                          ) !=
                          widget?.key);
                      var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                      tilt *= isUnder ? -1.0 : 1.0;
                      final value = isUnder
                          ? math.min(rotateAnim.value, 3.14 / 2)
                          : rotateAnim.value;
                      return Transform(
                        transform: Matrix4.rotationY(value)
                          ..setEntry(3, 0, tilt),
                        alignment: Alignment.center,
                        child: widget,
                      );
                    },
                  );
                },
                child: controller.mode.value == "single"
                    ? const Icon(
                        Icons.person,
                        key: ValueKey('single'),
                        size: 100,
                        color: AppColors.primary,
                      )
                    : const Icon(
                        Icons.people,
                        key: ValueKey('two'),
                        size: 100,
                        color: AppColors.secondary,
                      ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildToggleButton(
                      title: "Single Player",
                      isSelected: controller.mode.value == "single",
                      activeColor: AppColors.primary,
                      onTap: () => controller.mode.value = "single",
                    ),
                    _buildToggleButton(
                      title: "Two Player",
                      isSelected: controller.mode.value == "two",
                      activeColor: AppColors.secondary,
                      onTap: () => controller.mode.value = "two",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
             
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  children: [
                    _buildLevelTile(level: 1, title: "Easy 4x4", onTap: (){
                      Get.toNamed(AppRoutes.PLAYER, arguments: {"level": 1});
                    }, color: Colors.green),
                    _buildLevelTile(level: 2, title: "Medium 5x5", onTap: (){
                      Get.toNamed(AppRoutes.PLAYER, arguments: {"level": 2});
                    }, color: Colors.yellow),
                    _buildLevelTile(level: 3, title: "Hard 6x6", onTap: (){
                      Get.toNamed(AppRoutes.PLAYER, arguments: {"level": 3});
                    }, color: Colors.red),
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelTile({
    required int level,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color.withOpacity(0.2)),
              color: color.withOpacity(0.05),
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Level $level",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: color.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String title,
    required bool isSelected,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? AppColors.background : activeColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    return Scaffold(
      appBar: AppBar(title: Text("Select Levels"), centerTitle: true),
      body: Row(
        children: [
          const Drawer(),
          Expanded(child: Center(child: Text("Levels"))),
        ],
      ),
    );
  }
}
