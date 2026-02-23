import 'package:flutter/material.dart';

class HomeMenuPage extends StatefulWidget {
  const HomeMenuPage({super.key});

  @override
  State<HomeMenuPage> createState() => _HomeMenuPageState();
}

class _HomeMenuPageState extends State<HomeMenuPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<_MenuItem> _menuItems = [
    _MenuItem(
      title: 'Lottie Animations',
      subtitle: 'Third-party JSON-based animations',
      icon: Icons.animation,
      route: '/lottie',
      gradient: [Color(0xFF6A11CB), Color(0xFF2575FC)],
    ),
    _MenuItem(
      title: 'Page Transitions',
      subtitle: 'Custom screen change animations',
      icon: Icons.swap_horiz_rounded,
      route: '/page-transitions',
      gradient: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
    ),
    _MenuItem(
      title: 'Button Tap Animations',
      subtitle: 'Scale, bounce, ripple on tap',
      icon: Icons.touch_app_rounded,
      route: '/button-animations',
      gradient: [Color(0xFF11998E), Color(0xFF38EF7D)],
    ),
    _MenuItem(
      title: 'Implicit Animations',
      subtitle: 'AnimatedContainer, Opacity & more',
      icon: Icons.auto_awesome,
      route: '/implicit-animations',
      gradient: [Color(0xFFF7971E), Color(0xFFFFD200)],
    ),
    _MenuItem(
      title: 'Explicit Animations',
      subtitle: 'AnimationController driven',
      icon: Icons.settings_input_component_rounded,
      route: '/explicit-animations',
      gradient: [Color(0xFFDA22FF), Color(0xFF9733EE)],
    ),
    _MenuItem(
      title: 'Hero Animations',
      subtitle: 'Shared element transitions',
      icon: Icons.flight_takeoff_rounded,
      route: '/hero-animations',
      gradient: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
    ),
    _MenuItem(
      title: 'Staggered Animations',
      subtitle: 'Sequential & overlapping animations',
      icon: Icons.stacked_bar_chart_rounded,
      route: '/staggered-animations',
      gradient: [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
    ),
    _MenuItem(
      title: 'Animated List',
      subtitle: 'Add/remove items with animation',
      icon: Icons.list_alt_rounded,
      route: '/animated-list',
      gradient: [Color(0xFF43E97B), Color(0xFF38F9D7)],
    ),
    _MenuItem(
      title: 'Physics Animations',
      subtitle: 'Spring, friction & gravity based',
      icon: Icons.science_rounded,
      route: '/physics-animations',
      gradient: [Color(0xFFF093FB), Color(0xFFF5576C)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🎬 Flutter Animations',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Everything you need to know about animations',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return _AnimatedMenuCard(
                      item: _menuItems[index],
                      index: index,
                      parentAnimation: _fadeAnimation,
                    );
                  }, childCount: _menuItems.length),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 30)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedMenuCard extends StatefulWidget {
  final _MenuItem item;
  final int index;
  final Animation<double> parentAnimation;

  const _AnimatedMenuCard({
    required this.item,
    required this.index,
    required this.parentAnimation,
  });

  @override
  State<_AnimatedMenuCard> createState() => _AnimatedMenuCardState();
}

class _AnimatedMenuCardState extends State<_AnimatedMenuCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Stagger the entrance of each card
    final delay = widget.index * 0.1;
    final start = delay.clamp(0.0, 0.7);
    final end = (start + 0.3).clamp(0.0, 1.0);

    final slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: widget.parentAnimation,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        );

    final fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.parentAnimation,
        curve: Interval(start, end, curve: Curves.easeOut),
      ),
    );

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeIn,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 - _scaleAnimation.value,
              child: child,
            );
          },
          child: GestureDetector(
            onTapDown: (_) => _scaleController.forward(),
            onTapUp: (_) {
              _scaleController.reverse();
              Navigator.pushNamed(context, widget.item.route);
            },
            onTapCancel: () => _scaleController.reverse(),
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.item.gradient[0].withValues(alpha: 0.25),
                    widget.item.gradient[1].withValues(alpha: 0.10),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: widget.item.gradient[0].withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: widget.item.gradient),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      widget.item.icon,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.item.subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white.withValues(alpha: 0.4),
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final List<Color> gradient;

  const _MenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.gradient,
  });
}
