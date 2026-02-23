import 'package:flutter/material.dart';
import 'package:lottie_animation1/utils/page_transitions.dart';

/// Demonstrates different types of page/screen transition animations.
class PageTransitionDemo extends StatelessWidget {
  const PageTransitionDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Page Transitions'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const _SectionHeader(
            title: 'Custom Route Transitions',
            description:
                'Tap each button to navigate to a dummy page using a different transition animation. '
                'These are built using PageRouteBuilder.',
          ),
          const SizedBox(height: 16),
          _TransitionButton(
            label: '➡️  Slide from Right',
            color: const Color(0xFF6A11CB),
            onTap: () => Navigator.push(
              context,
              SlidePageRoute(page: const _DummyPage(title: 'Slide Right')),
            ),
          ),
          _TransitionButton(
            label: '⬆️  Slide from Bottom',
            color: const Color(0xFF2575FC),
            onTap: () => Navigator.push(
              context,
              SlideUpPageRoute(page: const _DummyPage(title: 'Slide Up')),
            ),
          ),
          _TransitionButton(
            label: '🌫️  Fade In',
            color: const Color(0xFFFF416C),
            onTap: () => Navigator.push(
              context,
              FadePageRoute(page: const _DummyPage(title: 'Fade')),
            ),
          ),
          _TransitionButton(
            label: '🔍  Scale (Zoom In)',
            color: const Color(0xFF11998E),
            onTap: () => Navigator.push(
              context,
              ScalePageRoute(page: const _DummyPage(title: 'Scale')),
            ),
          ),
          _TransitionButton(
            label: '🔄  Rotation + Fade',
            color: const Color(0xFFDA22FF),
            onTap: () => Navigator.push(
              context,
              RotationPageRoute(
                page: const _DummyPage(title: 'Rotation + Fade'),
              ),
            ),
          ),
          _TransitionButton(
            label: '✨  Fancy Combined',
            color: const Color(0xFFF7971E),
            onTap: () => Navigator.push(
              context,
              FancyPageRoute(page: const _DummyPage(title: 'Fancy Combined')),
            ),
          ),
          const SizedBox(height: 30),
          const _CodeSnippet(
            title: 'How it works — PageRouteBuilder',
            code: '''
// In page_transitions.dart:
class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page})
    : super(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (ctx, anim, secondaryAnim) => page,
        transitionsBuilder: (ctx, anim, secondaryAnim, child) {
          final curved = CurvedAnimation(
            parent: anim,
            curve: Curves.easeInOutCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          );
        },
      );
}

// Usage:
Navigator.push(
  context,
  SlidePageRoute(page: MyNextPage()),
);
''',
          ),
        ],
      ),
    );
  }
}

class _TransitionButton extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _TransitionButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_TransitionButton> createState() => _TransitionButtonState();
}

class _TransitionButtonState extends State<_TransitionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) =>
              Transform.scale(scale: _scaleAnim.value, child: child),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: widget.color.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: widget.color,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DummyPage extends StatelessWidget {
  final String title;
  const _DummyPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 80,
              color: Colors.green.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              '$title Transition',
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 10),
            Text(
              'Press back to see the reverse animation',
              style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String description;

  const _SectionHeader({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.55),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _CodeSnippet extends StatelessWidget {
  final String title;
  final String code;

  const _CodeSnippet({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.code, color: Colors.amber.shade300, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.amber.shade300,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            code.trim(),
            style: const TextStyle(
              color: Color(0xFFAEB7C0),
              fontFamily: 'monospace',
              fontSize: 12,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
