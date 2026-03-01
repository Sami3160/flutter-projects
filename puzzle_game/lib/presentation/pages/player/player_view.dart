import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_game/presentation/pages/player/player_controller.dart';
import 'package:puzzle_game/presentation/widgets/grid_area.dart';

class PlayerView extends GetView<PlayerController> {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memory Game')),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Obx(
              () => Text(
                'Tries: ${controller.tries.value} | Matched: ${controller.matchedPairs.value}/${controller.tiles.length ~/ 2} | Time : ${controller.time.value}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Obx(
              () => controller.isCompleted()
                  ? Column(
                      children: [
                        _buildControls(controller),
                        const SizedBox(height: 20),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: Obx(
                () => GridArea(
                  row: controller.level.value == 1
                      ? 2
                      : controller.level.value == 2
                      ? 4
                      : 6,
                  col: controller.level.value == 1
                      ? 2
                      : controller.level.value == 2
                      ? 4
                      : 5,
                  tiles: controller.tiles.toList(),
                  onTapTile: controller.onTileTapped,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(PlayerController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 12,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: const Text('Back'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
        ),
        ElevatedButton(
          onPressed: () => controller.reset(),
          child: const Text('Restart'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
