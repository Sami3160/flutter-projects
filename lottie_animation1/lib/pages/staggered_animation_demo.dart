import 'package:flutter/material.dart';

/// Demonstrates staggered animations - multiple animations running
/// with different delays to create sequenced effects.
class StaggeredAnimationDemo extends StatefulWidget {
  const StaggeredAnimationDemo({super.key});

  @override
  State<StaggeredAnimationDemo> createState() => _StaggeredAnimationDemoState();
}

class _StaggeredAnimationDemoState extends State<StaggeredAnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Animation<double> _delayedFade(double start, double end) {
    return Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );
  }

  Animation<Offset> _delayedSlide(double start, double end) {
    return Tween(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = [
      _StaggerItem('Profile Card', Icons.person, const [
        Color(0xFF6A11CB),
        Color(0xFF2575FC),
      ]),
      _StaggerItem('Notifications', Icons.notifications, const [
        Color(0xFFFF416C),
        Color(0xFFFF4B2B),
      ]),
      _StaggerItem('Messages', Icons.message, const [
        Color(0xFF11998E),
        Color(0xFF38EF7D),
      ]),
      _StaggerItem('Settings', Icons.settings, const [
        Color(0xFFF7971E),
        Color(0xFFFFD200),
      ]),
      _StaggerItem('Analytics', Icons.bar_chart, const [
        Color(0xFFDA22FF),
        Color(0xFF9733EE),
      ]),
      _StaggerItem('Favorites', Icons.favorite, const [
        Color(0xFFFC5C7D),
        Color(0xFF6A82FB),
      ]),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Staggered Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.replay_rounded),
            onPressed: () => _ctrl.forward(from: 0),
            tooltip: 'Replay',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Header staggered in first
          FadeTransition(
            opacity: _delayedFade(0.0, 0.2),
            child: SlideTransition(
              position: _delayedSlide(0.0, 0.2),
              child: Text(
                'Each item enters with a different delay using Interval',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Staggered cards
          for (int i = 0; i < items.length; i++) ...[
            _buildStaggeredCard(items[i], i, items.length),
            const SizedBox(height: 12),
          ],

          const SizedBox(height: 24),

          // Staggered circular indicators
          FadeTransition(
            opacity: _delayedFade(0.7, 0.9),
            child: const Text(
              'Staggered Circles',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (i) {
              final start = 0.5 + i * 0.08;
              final end = (start + 0.15).clamp(0.0, 1.0);
              return FadeTransition(
                opacity: _delayedFade(start, end),
                child: ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _ctrl,
                      curve: Interval(start, end, curve: Curves.elasticOut),
                    ),
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          HSLColor.fromAHSL(1, i * 60.0, 0.8, 0.6).toColor(),
                          HSLColor.fromAHSL(
                            1,
                            i * 60.0 + 30,
                            0.8,
                            0.5,
                          ).toColor(),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildStaggeredCard(_StaggerItem item, int index, int total) {
    final start = index * 0.1;
    final end = (start + 0.25).clamp(0.0, 1.0);

    return FadeTransition(
      opacity: _delayedFade(start, end),
      child: SlideTransition(
        position: _delayedSlide(start, end),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                item.colors[0].withValues(alpha: 0.2),
                item.colors[1].withValues(alpha: 0.08),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: item.colors[0].withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: item.colors),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: Colors.white, size: 22),
              ),
              const SizedBox(width: 14),
              Text(
                item.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaggerItem {
  final String label;
  final IconData icon;
  final List<Color> colors;
  const _StaggerItem(this.label, this.icon, this.colors);
}
