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
                'Tries: ${controller.tries.value} | Matched: ${controller.matchedPairs.value}/${controller.tiles.length ~/ 2}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => GridArea(
                  row: 4,
                  col: 4,
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
}
