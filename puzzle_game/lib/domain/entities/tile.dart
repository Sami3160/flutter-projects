import 'package:flutter/material.dart';

class Tile {
  final IconData icon;
  bool isFlipped=false;
  bool isMatched=false;
  final int id;
  Tile({required this.icon, required this.id});
}