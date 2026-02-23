import 'package:flutter/material.dart';

/// Demonstrates implicit animations — Flutter's easiest animation approach.
/// These widgets automatically animate between old and new values.
class ImplicitAnimationDemo extends StatefulWidget {
  const ImplicitAnimationDemo({super.key});

  @override
  State<ImplicitAnimationDemo> createState() => _ImplicitAnimationDemoState();
}

class _ImplicitAnimationDemoState extends State<ImplicitAnimationDemo> {
  // AnimatedContainer states
  bool _expanded = false;
  Color _containerColor = const Color(0xFF6A11CB);
  double _containerRadius = 14;

  // AnimatedOpacity state
  bool _visible = true;

  // AnimatedAlign state
  bool _alignedLeft = true;

  // AnimatedCrossFade state
  bool _showFirst = true;

  // AnimatedPositioned state
  bool _movedRight = false;

  // AnimatedDefaultTextStyle state
  bool _bigText = false;

  // AnimatedRotation state
  double _turns = 0;

  // AnimatedScale state
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Implicit Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Tap "Toggle" to see each animation. These use Flutter\'s built-in '
            'Animated* widgets — no AnimationController needed!',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // 1. AnimatedContainer
          _buildSection(
            title: '1. AnimatedContainer',
            onToggle: () {
              setState(() {
                _expanded = !_expanded;
                _containerColor = _expanded
                    ? const Color(0xFFFF416C)
                    : const Color(0xFF6A11CB);
                _containerRadius = _expanded ? 40 : 14;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              width: _expanded ? 280 : 160,
              height: _expanded ? 120 : 80,
              decoration: BoxDecoration(
                color: _containerColor,
                borderRadius: BorderRadius.circular(_containerRadius),
              ),
              child: const Center(
                child: Text('🎨', style: TextStyle(fontSize: 28)),
              ),
            ),
          ),

          // 2. AnimatedOpacity
          _buildSection(
            title: '2. AnimatedOpacity',
            onToggle: () => setState(() => _visible = !_visible),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 600),
              opacity: _visible ? 1.0 : 0.0,
              child: Container(
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'I fade away!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),

          // 3. AnimatedAlign
          _buildSection(
            title: '3. AnimatedAlign',
            onToggle: () => setState(() => _alignedLeft = !_alignedLeft),
            child: SizedBox(
              height: 70,
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutBack,
                alignment: _alignedLeft
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDA22FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('↔️', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            ),
          ),

          // 4. AnimatedCrossFade
          _buildSection(
            title: '4. AnimatedCrossFade',
            onToggle: () => setState(() => _showFirst = !_showFirst),
            child: AnimatedCrossFade(
              firstChild: Container(
                width: 200,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7971E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'Widget A',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              secondChild: Container(
                width: 200,
                height: 90,
                decoration: BoxDecoration(
                  color: const Color(0xFF2575FC),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text(
                    'Widget B',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 400),
            ),
          ),

          // 5. AnimatedPositioned
          _buildSection(
            title: '5. AnimatedPositioned',
            onToggle: () => setState(() => _movedRight = !_movedRight),
            child: SizedBox(
              height: 80,
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                    left: _movedRight ? 200 : 0,
                    top: 5,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text('📦', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 6. AnimatedDefaultTextStyle
          _buildSection(
            title: '6. AnimatedDefaultTextStyle',
            onToggle: () => setState(() => _bigText = !_bigText),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 400),
              style: TextStyle(
                fontSize: _bigText ? 32 : 18,
                color: _bigText
                    ? const Color(0xFF38EF7D)
                    : const Color(0xFFFFD200),
                fontWeight: _bigText ? FontWeight.bold : FontWeight.normal,
              ),
              child: const Text('Hello Flutter!'),
            ),
          ),

          // 7. AnimatedRotation
          _buildSection(
            title: '7. AnimatedRotation',
            onToggle: () => setState(() => _turns += 0.25),
            child: AnimatedRotation(
              turns: _turns,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C9FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('🔄', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
          ),

          // 8. AnimatedScale
          _buildSection(
            title: '8. AnimatedScale',
            onToggle: () {
              setState(() => _scale = _scale == 1.0 ? 1.5 : 1.0);
            },
            child: AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutBack,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Center(
                  child: Text('🔍', style: TextStyle(fontSize: 24)),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required VoidCallback onToggle,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: onToggle,
                child: const Text(
                  'Toggle',
                  style: TextStyle(color: Color(0xFF38EF7D)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(child: child),
        ],
      ),
    );
  }
}
