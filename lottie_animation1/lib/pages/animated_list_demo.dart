import 'package:flutter/material.dart';

/// Demonstrates AnimatedList — adding and removing items with animations.
class AnimatedListDemo extends StatefulWidget {
  const AnimatedListDemo({super.key});

  @override
  State<AnimatedListDemo> createState() => _AnimatedListDemoState();
}

class _AnimatedListDemoState extends State<AnimatedListDemo> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<String> _items = ['Item 1', 'Item 2', 'Item 3'];
  int _counter = 3;

  final _gradients = const [
    [Color(0xFF6A11CB), Color(0xFF2575FC)],
    [Color(0xFFFF416C), Color(0xFFFF4B2B)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
    [Color(0xFFF7971E), Color(0xFFFFD200)],
    [Color(0xFFDA22FF), Color(0xFF9733EE)],
    [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
    [Color(0xFF00C9FF), Color(0xFF92FE9D)],
  ];

  void _addItem() {
    _counter++;
    final index = _items.length;
    _items.add('Item $_counter');
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 400),
    );
  }

  void _removeItem(int index) {
    final removed = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removed, index, animation),
      duration: const Duration(milliseconds: 350),
    );
  }

  Widget _buildItem(String item, int index, Animation<double> animation) {
    final colors = _gradients[index % _gradients.length];
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
      child: FadeTransition(
        opacity: animation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors[0].withValues(alpha: 0.3),
                colors[1].withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: colors[0].withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.widgets_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  item,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red.shade300,
                  size: 20,
                ),
                onPressed: () {
                  final currentIndex = _items.indexOf(item);
                  if (currentIndex >= 0) _removeItem(currentIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Animated List'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              'Items slide in when added and slide out when removed using AnimatedList.',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) =>
                  _buildItem(_items[index], index, animation),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addItem,
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        backgroundColor: const Color(0xFF6A11CB),
      ),
    );
  }
}
