import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

/// Demonstrates physics-based animations — spring, friction, gravity simulations.
class PhysicsAnimationDemo extends StatelessWidget {
  const PhysicsAnimationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D2B),
      appBar: AppBar(
        title: const Text('Physics Animations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Drag the balls and release to see physics simulations in action.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 24),

          // 1. Spring
          _sectionTitle('1. Spring Simulation'),
          _sectionSub('Drag and release — the ball bounces back like a spring'),
          const SizedBox(height: 10),
          const SizedBox(height: 200, child: _SpringBall()),
          const SizedBox(height: 24),

          // 2. Gravity
          _sectionTitle('2. Gravity Drop'),
          _sectionSub('Tap to drop the ball with gravity acceleration'),
          const SizedBox(height: 10),
          const SizedBox(height: 250, child: _GravityBall()),
          const SizedBox(height: 24),

          // 3. Draggable spring card
          _sectionTitle('3. Draggable Spring Card'),
          _sectionSub('Drag and release to see it spring back'),
          const SizedBox(height: 10),
          const SizedBox(
            height: 200,
            child: Center(child: _DraggableSpringCard()),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(
    t,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
  Widget _sectionSub(String t) => Text(
    t,
    style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
  );
}

// ─── Spring Ball ───
class _SpringBall extends StatefulWidget {
  const _SpringBall();
  @override
  State<_SpringBall> createState() => _SpringBallState();
}

class _SpringBallState extends State<_SpringBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  double _dragOffset = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() {
      _dragOffset += d.delta.dx;
      _ctrl.value = _dragOffset;
    });
  }

  void _onPanEnd(DragEndDetails d) {
    final spring = SpringDescription(mass: 1, stiffness: 300, damping: 12);
    final sim = SpringSimulation(
      spring,
      _dragOffset,
      0,
      d.velocity.pixelsPerSecond.dx,
    );
    _ctrl.animateWith(sim);
    _ctrl.addListener(() {
      setState(() => _dragOffset = _ctrl.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Transform.translate(
            offset: Offset(_dragOffset, 0),
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text('🏀', style: TextStyle(fontSize: 28)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Gravity Ball ───
class _GravityBall extends StatefulWidget {
  const _GravityBall();
  @override
  State<_GravityBall> createState() => _GravityBallState();
}

class _GravityBallState extends State<_GravityBall>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  double _y = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController.unbounded(vsync: this);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _drop() {
    _y = 0;
    final sim = GravitySimulation(500, 0, 180, 0);
    _ctrl.animateWith(sim);
    _ctrl.addListener(() {
      setState(() => _y = _ctrl.value.clamp(0.0, 180.0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _drop,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: _y,
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFF416C), Color(0xFFFF4B2B)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('🎾', style: TextStyle(fontSize: 24)),
                  ),
                ),
              ),
            ),
            // Ground line
            Positioned(
              left: 20,
              right: 20,
              bottom: 10,
              child: Container(
                height: 2,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Draggable Spring Card ───
class _DraggableSpringCard extends StatefulWidget {
  const _DraggableSpringCard();
  @override
  State<_DraggableSpringCard> createState() => _DraggableSpringCardState();
}

class _DraggableSpringCardState extends State<_DraggableSpringCard>
    with TickerProviderStateMixin {
  late AnimationController _xCtrl;
  late AnimationController _yCtrl;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _xCtrl = AnimationController.unbounded(vsync: this);
    _yCtrl = AnimationController.unbounded(vsync: this);
    _xCtrl.addListener(
      () => setState(() => _offset = Offset(_xCtrl.value, _offset.dy)),
    );
    _yCtrl.addListener(
      () => setState(() => _offset = Offset(_offset.dx, _yCtrl.value)),
    );
  }

  @override
  void dispose() {
    _xCtrl.dispose();
    _yCtrl.dispose();
    super.dispose();
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() => _offset += d.delta);
    _xCtrl.value = _offset.dx;
    _yCtrl.value = _offset.dy;
  }

  void _onPanEnd(DragEndDetails d) {
    final spring = SpringDescription(mass: 1, stiffness: 200, damping: 10);
    _xCtrl.animateWith(
      SpringSimulation(spring, _offset.dx, 0, d.velocity.pixelsPerSecond.dx),
    );
    _yCtrl.animateWith(
      SpringSimulation(spring, _offset.dy, 0, d.velocity.pixelsPerSecond.dy),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _offset,
        child: Container(
          width: 140,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF11998E), Color(0xFF38EF7D)],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF11998E).withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Drag Me!',
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
