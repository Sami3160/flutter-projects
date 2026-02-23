# 🎬 Flutter Animation Guide — Tween, CurvedAnimation & AnimationController

> A clear mental model for understanding Flutter's explicit animation system.

---

## 🧠 The Animation Pipeline — Think of it Like a Factory

Every Flutter explicit animation is just a **pipeline** with 3 layers:

```
Layer 1              Layer 2                Layer 3
WHO drives it?       HOW does it move?      WHAT values?
─────────────        ─────────────────      ──────────────
AnimationController  CurvedAnimation        Tween
(the engine)         (the feel)             (the range)
```

Each layer is **optional** depending on what you need (except the controller — that's always required).

---

## 🔴 Layer 1: `AnimationController` — The Engine

This is the **only required piece**. It produces a `double` from `0.0 → 1.0` over a duration.

```dart
_ctrl = AnimationController(
  duration: Duration(milliseconds: 500),
  vsync: this,
);
_ctrl.forward();  // starts the clock
```

**Without anything else**, you can already use it:

```dart
FadeTransition(opacity: _ctrl, child: ...)
// Fades 0→1 in 500ms, linear speed. Done!
```

**When is this enough?** When you want a simple `0.0 → 1.0` linear animation.

---

## 🟡 Layer 2: `CurvedAnimation` — The Feel

Wraps the controller to change **HOW** it moves. Without it, everything is linear (robotic). With it, you get natural motion.

```dart
CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)
```

What it does — visual comparison:

```
Linear (no curve):      ████████████████████  same speed throughout
Curves.easeOut:         ████████████▓▓▒▒░░   fast start, gentle stop
Curves.bounceOut:       ████████▒██▒█░       bounces at the end
Curves.elasticOut:      ████████████▒█▒░     springy overshoot
```

You can use it **directly** too:

```dart
FadeTransition(
  opacity: CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
  child: ...
)
// Fades 0→1 in 500ms, with easeOut feel. Done!
```

**When to add this?** When you want motion that doesn't feel robotic.

### Special: `Interval` (used in staggered animations)

`Interval` is a special curve that restricts **WHEN** the animation plays within the overall timeline:

```dart
CurvedAnimation(
  parent: _ctrl,
  curve: Interval(0.3, 0.55, curve: Curves.easeOut),
  // Only animates during 30%–55% of _ctrl's timeline
)
```

Visual example (2000ms controller, 6 staggered items):

```
_ctrl timeline:  0.0 ═══════════════════════════════════════ 1.0
                 |    0.5s    |    0.5s    |    0.5s    |  0.5s  |
                 0ms        500ms       1000ms       1500ms   2000ms

Card 0  (0.0 → 0.25): █████░░░░░░░░░░░░░░░  fades in first
Card 1  (0.1 → 0.35): ░██████░░░░░░░░░░░░░  starts a bit later
Card 2  (0.2 → 0.45): ░░███████░░░░░░░░░░░  starts even later
Card 3  (0.3 → 0.55): ░░░████████░░░░░░░░░  ← stagger effect!
Card 4  (0.4 → 0.65): ░░░░█████████░░░░░░░
Card 5  (0.5 → 0.75): ░░░░░██████████░░░░░  comes in last

█ = actively animating    ░ = waiting or done
```

---

## 🔵 Layer 3: `Tween` — The Range

Maps the `0.0 → 1.0` to **any other value range or type**.

```dart
Tween<double>(begin: 0.5, end: 1.0)                        // half-opacity → full
Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)       // slide from right
Tween<Color>(begin: Colors.red, end: Colors.blue)           // color change
Tween<double>(begin: 200, end: 0)                           // shrink from 200 → 0
```

**When to add this?** Two cases:

1. When you need a **range other than `0.0 → 1.0`** (e.g., opacity from 0.5 → 1.0)
2. When you need a **type other than `double`** (e.g., `Offset`, `Color`, `Size`)

---

## 🔗 How They Connect — The `.animate()` Call

`.animate()` is the glue. You call it on a `Tween` and pass it the controller (or curved animation):

```dart
// Simplest: Tween + Controller
Tween(begin: 0.5, end: 1.0).animate(_ctrl)

// With curve: Tween + CurvedAnimation + Controller
Tween(begin: 0.5, end: 1.0).animate(
  CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)
)

// With Interval (staggered): Tween + CurvedAnimation with Interval + Controller
Tween(begin: 0.0, end: 1.0).animate(
  CurvedAnimation(
    parent: _ctrl,
    curve: Interval(0.3, 0.55, curve: Curves.easeOut),
  ),
)
```

### `.animate()` has TWO jobs:

| Job                              | Example                                    | When needed                                          |
| -------------------------------- | ------------------------------------------ | ---------------------------------------------------- |
| **Type conversion**              | `double → Offset` for `SlideTransition`    | When types don't match                               |
| **Creating a derived animation** | Same `double → double` but with `Interval` | When you need different timing/curve from the parent |

---

## 🗺️ The Decision Flowchart

Ask yourself these questions in order:

```
START
  │
  ▼
  Q1: Do I need the value to go to something
      other than 0.0 → 1.0, or be a non-double type?
  │
  ├── NO  → Don't need Tween
  │         │
  │         ▼
  │         Q2: Do I want a curve (non-linear feel)?
  │         │
  │         ├── NO  → Just use _ctrl directly ✅
  │         │         FadeTransition(opacity: _ctrl)
  │         │
  │         └── YES → Wrap with CurvedAnimation ✅
  │                   FadeTransition(
  │                     opacity: CurvedAnimation(
  │                       parent: _ctrl,
  │                       curve: Curves.easeOut
  │                     )
  │                   )
  │
  └── YES → Need Tween
            │
            ▼
            Q2: Do I want a curve (non-linear feel)?
            │
            ├── NO  → Tween + _ctrl ✅
            │         Tween(begin: X, end: Y).animate(_ctrl)
            │
            └── YES → Tween + CurvedAnimation + _ctrl ✅
                      Tween(begin: X, end: Y).animate(
                        CurvedAnimation(
                          parent: _ctrl,
                          curve: Curves.easeOut
                        )
                      )
```

---

## 📋 Cheat Sheet — Quick Reference

| What you want                        | What you use                        | Code                                                                                                   |
| ------------------------------------ | ----------------------------------- | ------------------------------------------------------------------------------------------------------ |
| Simple fade, linear                  | `_ctrl` alone                       | `FadeTransition(opacity: _ctrl)`                                                                       |
| Fade with nice easing                | `CurvedAnimation`                   | `FadeTransition(opacity: CurvedAnimation(parent: _ctrl, curve: Curves.easeOut))`                       |
| Slide from right                     | `Tween<Offset>` + `_ctrl`           | `SlideTransition(position: Tween(begin: Offset(1,0), end: Offset.zero).animate(_ctrl))`                |
| Slide from right with easing         | `Tween<Offset>` + `CurvedAnimation` | `SlideTransition(position: Tween(...).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut)))` |
| Staggered fade (only during 30%-55%) | `Tween` + `Interval`                | `Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Interval(0.3, 0.55)))`      |
| Scale with bounce                    | `Tween<double>` + `CurvedAnimation` | `Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.bounceOut))`         |
| Color transition                     | `ColorTween` + `_ctrl`              | `ColorTween(begin: Colors.red, end: Colors.blue).animate(_ctrl)`                                       |

---

## 🧩 The Car Analogy

Think of it like a **car**:

| Part                   | Animation Equivalent  | What it controls                           |
| ---------------------- | --------------------- | ------------------------------------------ |
| 🔑 **Engine**          | `AnimationController` | Powers everything, sets the duration       |
| 🛞 **Transmission**    | `CurvedAnimation`     | How smooth/bouncy the ride feels           |
| 🗺️ **GPS Destination** | `Tween`               | Where you're going (what values to output) |

- You **always** need an engine (`AnimationController`)
- You **optionally** add a transmission (`CurvedAnimation`) for feel
- You **optionally** add GPS (`Tween`) to go somewhere other than `0.0 → 1.0`

---

## 🆚 Explicit vs Implicit Animations

This entire guide covers **explicit** animations (you control the `AnimationController`). Flutter also has **implicit** animations that handle all of this for you:

| Implicit (easy)                          | Explicit (flexible)                             |
| ---------------------------------------- | ----------------------------------------------- |
| `AnimatedContainer`                      | `AnimationController` + `Tween` + manual build  |
| `AnimatedOpacity`                        | `FadeTransition`                                |
| `AnimatedPadding`                        | Custom `Tween<EdgeInsets>`                      |
| Just change the value & Flutter animates | Full control over timing, staggering, sequences |

**Rule of thumb:** Use implicit animations first. Switch to explicit when you need staggering, chaining, or fine-grained control.

---

_Generated from animation learning session — Feb 2026_
