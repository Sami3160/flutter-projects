import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_game/domain/entities/tile.dart';

class PlayerController extends GetxController {
  var level = 0.obs;

  var tiles = <Tile>[].obs;
  var tries = 0.obs;
  var matchedPairs = 0.obs;

  int firstSelectedIndex = -1;
  int secondSelectedIndex = -1;
  bool isProcessing = false;

  final List<IconData> _icons = [
    Icons.star,
    Icons.circle,
    Icons.money,
    Icons.night_shelter,
    Icons.alarm,
    Icons.apple,
    Icons.abc,
    Icons.food_bank,
  ];

  @override
  void onInit() {
    super.onInit();
    // Safely parse arguments
    if (Get.arguments != null && Get.arguments is Map) {
      level.value = Get.arguments["level"] ?? 1;
    } else {
      level.value = 1;
    }

    initGame(4, 4);
  }

  void initGame(int row, int col) {
    _icons.shuffle();
    tiles.value = List.generate(
      row * col,
      (index) => Tile(
        icon: _icons[(index ~/ 2) % _icons.length],
        id: (index ~/ 2) % _icons.length,
      ),
    );
    tiles.shuffle();
    tries.value = 0;
    matchedPairs.value = 0;
    firstSelectedIndex = -1;
    secondSelectedIndex = -1;
    isProcessing = false;
  }

  void onTileTapped(int index) async {
    if (isProcessing || tiles[index].isFlipped || tiles[index].isMatched) {
      return;
    }

    tiles[index].isFlipped = true;

    if (firstSelectedIndex == -1) {
      firstSelectedIndex = index;
    } else if (secondSelectedIndex == -1) {
      secondSelectedIndex = index;
      isProcessing = true;
    }

    tiles.refresh();

    if (firstSelectedIndex != -1 && secondSelectedIndex != -1) {
      await Future.delayed(const Duration(seconds: 1));

      if (tiles[firstSelectedIndex].id == tiles[secondSelectedIndex].id) {
        matchedPairs.value++;
        tiles[firstSelectedIndex].isMatched = true;
        tiles[secondSelectedIndex].isMatched = true;
      } else {
        tries.value++;
        tiles[firstSelectedIndex].isFlipped = false;
        tiles[secondSelectedIndex].isFlipped = false;
      }

      firstSelectedIndex = -1;
      secondSelectedIndex = -1;
      isProcessing = false;

      tiles.refresh();
    }
  }
}
