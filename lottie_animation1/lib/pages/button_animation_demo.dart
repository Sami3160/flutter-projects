import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Demonstrates various button tap animation techniques.
class ButtonAnimationDemo extends StatelessWidget {
  const ButtonAnimationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Button Tap Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Tap each button to see its animation',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // 1. Scale Down on Tap
          const _DemoLabel(label: '1. Scale Down on Tap'),
          const _ScaleButton(),
          const SizedBox(height: 20),

          // 2. Bounce Effect
          const _DemoLabel(label: '2. Bounce Effect'),
          const _BounceButton(),
          const SizedBox(height: 20),

          // 3. Ink Ripple (Material)
          const _DemoLabel(label: '3. Material Ink Ripple'),
          const _InkRippleButton(),
          const SizedBox(height: 20),

          // 4. Color Change on Tap
          const _DemoLabel(label: '4. Animated Color Change'),
          const _ColorChangeButton(),
          const SizedBox(height: 20),

          // 5. Rotation on Tap
          const _DemoLabel(label: '5. Rotation on Tap'),
          const _RotateButton(),
          const SizedBox(height: 20),

          // 6. Elevation / Shadow Animation
          const _DemoLabel(label: '6. Elevation Animation'),
          const _ElevationButton(),
          const SizedBox(height: 20),

          // 7. Border Glow on Tap
          const _DemoLabel(label: '7. Border Glow on Tap'),
          const _GlowButton(),
          const SizedBox(height: 20),

          // 8. Icon Morph on Tap
          const _DemoLabel(label: '8. Animated Icon Toggle'),
          const _AnimatedIconButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _DemoLabel extends StatelessWidget {
  final String label;
  const _DemoLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ─── 1. Scale Button ───
class _ScaleButton extends StatefulWidget {
  const _ScaleButton();

  @override
  State<_ScaleButton> createState() => _ScaleButtonState();
}

class _ScaleButtonState extends State<_ScaleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scale = Tween(
      begin: 1.0,
      end: 0.92,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: _buttonContainer('Tap & Hold Me', const [
          Color(0xFF6A11CB),
          Color(0xFF2575FC),
        ]),
      ),
    );
  }
}

// ─── 2. Bounce Button ───
class _BounceButton extends StatefulWidget {
  const _BounceButton();

  @override
  State<_BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<_BounceButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bounce = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.85), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.85, end: 1.1), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.1, end: 0.95), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _ctrl.forward(from: 0);
      },
      child: AnimatedBuilder(
        animation: _bounce,
        builder: (context, child) =>
            Transform.scale(scale: _bounce.value, child: child),
        child: _buttonContainer('Tap to Bounce', const [
          Color(0xFF11998E),
          Color(0xFF38EF7D),
        ]),
      ),
    );
  }
}

// ─── 3. Ink Ripple ───
class _InkRippleButton extends StatelessWidget {
  const _InkRippleButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        splashColor: const Color(0xFFFF416C).withValues(alpha: 0.4),
        highlightColor: const Color(0xFFFF416C).withValues(alpha: 0.15),
        onTap: () {},
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          child: const Center(
            child: Text(
              'Material Ripple',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── 4. Color Change Button ───
class _ColorChangeButton extends StatefulWidget {
  const _ColorChangeButton();

  @override
  State<_ColorChangeButton> createState() => _ColorChangeButtonState();
}

class _ColorChangeButtonState extends State<_ColorChangeButton> {
  bool _tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _tapped = true),
      onTapUp: (_) => setState(() => _tapped = false),
      onTapCancel: () => setState(() => _tapped = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _tapped
                ? const [Color(0xFFFFD200), Color(0xFFFF6B00)]
                : const [Color(0xFFF7971E), Color(0xFFFFD200)],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Center(
          child: Text(
            'Hold to Change Color',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── 5. Rotate Button ───
class _RotateButton extends StatefulWidget {
  const _RotateButton();

  @override
  State<_RotateButton> createState() => _RotateButtonState();
}

class _RotateButtonState extends State<_RotateButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ctrl.forward(from: 0),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) {
          return Transform.rotate(
            angle: math.sin(_ctrl.value * math.pi * 2) * 0.1,
            child: child,
          );
        },
        child: _buttonContainer('Tap to Wiggle', const [
          Color(0xFFDA22FF),
          Color(0xFF9733EE),
        ]),
      ),
    );
  }
}

// ─── 6. Elevation Button ───
class _ElevationButton extends StatefulWidget {
  const _ElevationButton();

  @override
  State<_ElevationButton> createState() => _ElevationButtonState();
}

class _ElevationButtonState extends State<_ElevationButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(
                0xFF00C9FF,
              ).withValues(alpha: _pressed ? 0.1 : 0.5),
              blurRadius: _pressed ? 4 : 20,
              offset: Offset(0, _pressed ? 2 : 8),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Hold to Lower Shadow',
            style: TextStyle(
              color: Color(0xFF0D0D2B),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── 7. Glow Button ───
class _GlowButton extends StatefulWidget {
  const _GlowButton();

  @override
  State<_GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<_GlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Color.lerp(
                const Color(0xFFFC5C7D),
                const Color(0xFF6A82FB),
                _ctrl.value,
              )!,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.lerp(
                  const Color(0xFFFC5C7D),
                  const Color(0xFF6A82FB),
                  _ctrl.value,
                )!.withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 1,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Glowing Border',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─── 8. Animated Icon Button ───
class _AnimatedIconButton extends StatefulWidget {
  const _AnimatedIconButton();

  @override
  State<_AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<_AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  bool _toggled = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _toggled = !_toggled;
      if (_toggled) {
        _ctrl.forward();
      } else {
        _ctrl.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              progress: _ctrl,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text(
              'Tap to Toggle Icon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Helper ───
Widget _buttonContainer(String label, List<Color> gradient) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradient),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
