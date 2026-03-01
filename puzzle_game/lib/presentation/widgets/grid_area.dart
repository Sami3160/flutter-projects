import 'dart:math';
import 'package:flutter/material.dart';
import 'package:puzzle_game/app/config/app_colors.dart';
import 'package:puzzle_game/domain/entities/tile.dart';

class GridArea extends StatelessWidget {
  final int row;
  final int col;
  final List<Tile> tiles;
  final void Function(int) onTapTile;

  const GridArea({
    super.key,
    required this.row,
    required this.col,
    required this.tiles,
    required this.onTapTile,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: col,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: row * col,
      itemBuilder: (context, index) {
        final tile = tiles[index];
        return GestureDetector(
          onTap: () => onTapTile(index),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final rotateAnim = Tween(
                begin: 3.14159,
                end: 0.0,
              ).animate(animation);
              return AnimatedBuilder(
                animation: rotateAnim,
                child: child,
                builder: (context, widget) {
                  final isUnder = (ValueKey(tile.isFlipped) != widget?.key);
                  var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                  tilt *= isUnder ? -1.0 : 1.0;
                  final value = isUnder
                      ? min(rotateAnim.value, 3.14159 / 2)
                      : rotateAnim.value;
                  return Transform(
                    transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                    alignment: Alignment.center,
                    child: widget,
                  );
                },
              );
            },
            layoutBuilder: (widget, list) =>
                Stack(children: [widget!, ...list]),
            child: tile.isFlipped ? _buildFront(tile) : _buildBack(),
          ),
        );
      },
    );
  }

  Widget _buildFront(Tile tile) {
    return Container(
      key: const ValueKey(true),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            tile.isMatched ? Colors.green.shade100 : Colors.white,
            tile.isMatched ? Colors.green.shade300 : Colors.grey.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: tile.isMatched ? Colors.green.shade400 : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Center(
        child: Icon(
          tile.icon,
          size: 40,
          color: tile.isMatched ? Colors.green.shade800 : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Container(
      key: const ValueKey(false),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary.withOpacity(0.8), AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Center(
        child: Icon(
          Icons.help_outline_rounded,
          size: 40,
          color: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}
