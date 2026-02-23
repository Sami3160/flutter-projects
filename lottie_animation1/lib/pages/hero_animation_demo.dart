import 'package:flutter/material.dart';

class HeroAnimationDemo extends StatelessWidget {
  const HeroAnimationDemo({super.key});

  static const _items = [
    _HeroItem('🌅', 'Sunset', Color(0xFFFF416C), Color(0xFFFF4B2B)),
    _HeroItem('🏔️', 'Mountain', Color(0xFF6A11CB), Color(0xFF2575FC)),
    _HeroItem('🌊', 'Ocean', Color(0xFF00C9FF), Color(0xFF92FE9D)),
    _HeroItem('🌲', 'Forest', Color(0xFF11998E), Color(0xFF38EF7D)),
    _HeroItem('🌙', 'Night Sky', Color(0xFFDA22FF), Color(0xFF9733EE)),
    _HeroItem('🏜️', 'Desert', Color(0xFFF7971E), Color(0xFFFFD200)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Hero Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              'Tap a card to see the Hero shared element transition.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _HeroDetailPage(item: item),
                    ),
                  ),
                  child: Hero(
                    tag: 'hero-${item.label}',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [item.c1, item.c2]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              item.emoji,
                              style: const TextStyle(fontSize: 44),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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
  }
}

class _HeroDetailPage extends StatelessWidget {
  final _HeroItem item;
  const _HeroDetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      body: Column(
        children: [
          Hero(
            tag: 'hero-${item.label}',
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [item.c1, item.c2]),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item.emoji, style: const TextStyle(fontSize: 80)),
                      const SizedBox(height: 12),
                      Text(
                        item.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hero Animation Detail',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Wrap both source and destination widgets with Hero and give them the same tag. Flutter handles the rest!',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 15,
                      height: 1.6,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Go Back'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroItem {
  final String emoji, label;
  final Color c1, c2;
  const _HeroItem(this.emoji, this.label, this.c1, this.c2);
}
