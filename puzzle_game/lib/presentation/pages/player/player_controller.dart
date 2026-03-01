import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puzzle_game/domain/entities/tile.dart';

class PlayerController extends GetxController {
  var level = 0.obs;

  var tiles = <Tile>[].obs;
  var tries = 0.obs;
  var matchedPairs = 0.obs;
  Timer? timer;
  int firstSelectedIndex = -1;
  int secondSelectedIndex = -1;
  bool isProcessing = false;
  RxInt time = 0.obs;

  final List<IconData> _icons = [
    Icons.star,
    Icons.circle,
    Icons.money,
    Icons.night_shelter,
    Icons.alarm,
    Icons.apple,
    Icons.abc,
    Icons.food_bank,
    Icons.cabin,
    Icons.mouse,
    Icons.soup_kitchen,
    Icons.route,
    Icons.face,
    Icons.biotech,
    Icons.cake,
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
    switch (level.value) {
      case 1:
        initGame(2, 2);
        break;
      case 2:
        initGame(4, 4);
        break;
      case 3:
        initGame(6, 5);
        break;
    }
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time++;
    });
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

  void reset() {
    switch (level.value) {
      case 1:
        initGame(2, 2);
        break;
      case 2:
        initGame(4, 4);
        break;
      case 3:
        initGame(4, 4);
        break;
    }
    timer?.cancel();
    time.value = 0;
    startTimer();
  }
  bool isCompleted(){
    return matchedPairs.value == tiles.length ~/ 2;
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
    if (isCompleted()) {
      timer?.cancel();
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
