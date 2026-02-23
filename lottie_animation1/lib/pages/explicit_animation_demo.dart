import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Demonstrates explicit animations using AnimationController.
class ExplicitAnimationDemo extends StatefulWidget {
  const ExplicitAnimationDemo({super.key});

  @override
  State<ExplicitAnimationDemo> createState() => _ExplicitAnimationDemoState();
}

class _ExplicitAnimationDemoState extends State<ExplicitAnimationDemo>
    with TickerProviderStateMixin {
  // 1. Continuous Rotation
  late AnimationController _rotationCtrl;

  // 2. Pulsating Scale
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  // 3. Color Tween
  late AnimationController _colorCtrl;
  late Animation<Color?> _colorAnim;

  // 4. Curved Path
  late AnimationController _pathCtrl;

  // 5. Chain / Sequence
  late AnimationController _seqCtrl;
  late Animation<double> _seqAnim;

  @override
  void initState() {
    super.initState();

    // 1. Rotation
    _rotationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // 2. Pulse
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnim = Tween(
      begin: 0.9,
      end: 1.15,
    ).animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));

    // 3. Color
    _colorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _colorAnim = ColorTween(
      begin: const Color(0xFF6A11CB),
      end: const Color(0xFFFF416C),
    ).animate(CurvedAnimation(parent: _colorCtrl, curve: Curves.easeInOut));

    // 4. Path
    _pathCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // 5. Sequence
    _seqCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _seqAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.5), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.5), weight: 25),
      TweenSequenceItem(tween: Tween(begin: 1.5, end: 0.0), weight: 25),
    ]).animate(_seqCtrl);
  }

  @override
  void dispose() {
    _rotationCtrl.dispose();
    _pulseCtrl.dispose();
    _colorCtrl.dispose();
    _pathCtrl.dispose();
    _seqCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Explicit Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'These use AnimationController for full control over timing, '
            'direction, and repetition.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // 1. Continuous Rotation
          _card(
            title: '1. Continuous Rotation',
            subtitle: 'AnimationController + RotationTransition',
            child: RotationTransition(
              turns: _rotationCtrl,
              child: _box(const Color(0xFF2575FC), '🔄'),
            ),
          ),

          // 2. Pulsating Scale
          _card(
            title: '2. Pulsating Scale',
            subtitle: 'TweenAnimation + repeat(reverse: true)',
            child: ScaleTransition(
              scale: _pulseAnim,
              child: _box(const Color(0xFFFF416C), '💓'),
            ),
          ),

          // 3. Color Tween
          _card(
            title: '3. Color Tween',
            subtitle: 'ColorTween animating between two colors',
            child: AnimatedBuilder(
              animation: _colorAnim,
              builder: (context, child) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: _colorAnim.value,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text('🎨', style: TextStyle(fontSize: 28)),
                  ),
                );
              },
            ),
          ),

          // 4. Curved Path (circular orbit)
          _card(
            title: '4. Circular Path Motion',
            subtitle: 'Using sin/cos with AnimationController value',
            child: SizedBox(
              height: 150,
              child: AnimatedBuilder(
                animation: _pathCtrl,
                builder: (context, child) {
                  final angle = _pathCtrl.value * 2 * math.pi;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      // Orbit path ring
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                          math.cos(angle) * 55,
                          math.sin(angle) * 55,
                        ),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color(0xFF38EF7D),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // 5. TweenSequence
          _card(
            title: '5. TweenSequence',
            subtitle: 'Multiple tweens in sequence for complex motions',
            child: SizedBox(
              height: 60,
              child: AnimatedBuilder(
                animation: _seqAnim,
                builder: (context, _) {
                  return Stack(
                    children: [
                      Positioned(
                        left:
                            (_seqAnim.value / 1.5) *
                            (MediaQuery.of(context).size.width - 110),
                        top: 5,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('🏃', style: TextStyle(fontSize: 22)),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // 6. Curves Comparison
          _card(
            title: '6. Curves Visualized',
            subtitle: 'How different Curves affect the same Tween',
            child: const _CurvesComparison(),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _box(Color color, String emoji) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28))),
    );
  }

  Widget _card({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 16),
          Center(child: child),
        ],
      ),
    );
  }
}

/// Shows three bars animated with different curves side by side.
class _CurvesComparison extends StatefulWidget {
  const _CurvesComparison();

  @override
  State<_CurvesComparison> createState() => _CurvesComparisonState();
}

class _CurvesComparisonState extends State<_CurvesComparison>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curves = [
      ('linear', Curves.linear, const Color(0xFF6A11CB)),
      ('easeIn', Curves.easeIn, const Color(0xFFFF416C)),
      ('bounce', Curves.bounceOut, const Color(0xFF38EF7D)),
      ('elastic', Curves.elasticOut, const Color(0xFFFFD200)),
    ];

    return Column(
      children: curves.map((item) {
        final anim = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: _ctrl, curve: item.$2));
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              SizedBox(
                width: 55,
                child: Text(
                  item.$1,
                  style: TextStyle(
                    color: item.$3,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: AnimatedBuilder(
                  animation: anim,
                  builder: (context, _) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: 0.1 + anim.value * 0.9,
                        child: Container(
                          height: 22,
                          decoration: BoxDecoration(
                            color: item.$3,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
