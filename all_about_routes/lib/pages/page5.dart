import 'package:flutter/material.dart';

class Page5 extends StatefulWidget {
  const Page5({super.key});

  @override
  State<Page5> createState() => _Page5State();
}

class _Page5State extends State<Page5> {
  int _currentIndex = 0;

  // GlobalKey for the nested Navigator
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nested Routing")),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: '/tab1',
        onGenerateRoute: _onGenerateRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // Navigate using the nested navigator
          switch (index) {
            case 0:
              _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                '/tab1',
                (route) => false,
              );
              break;
            case 1:
              _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                '/tab2',
                (route) => false,
              );
              break;
            case 2:
              _navigatorKey.currentState!.pushNamedAndRemoveUntil(
                '/tab3',
                (route) => false,
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Tab 1"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Tab 2"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tab 3"),
        ],
      ),
    );
  }

  // This is the nested route generator — only handles routes INSIDE this page
  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/tab1':
        return MaterialPageRoute(builder: (_) => const _Tab1());
      case '/tab2':
        return MaterialPageRoute(builder: (_) => const _Tab2());
      case '/tab3':
        return MaterialPageRoute(builder: (_) => const _Tab3());
      case '/tab1/detail':
        return MaterialPageRoute(builder: (_) => const _Tab1Detail());
      default:
        return MaterialPageRoute(
          builder: (_) => const Center(child: Text("Unknown nested route")),
        );
    }
  }
}

// --- Sub-pages that live INSIDE the nested Navigator ---

class _Tab1 extends StatelessWidget {
  const _Tab1();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tab 1 - Home", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // This navigates WITHIN the nested navigator (bottom bar stays!)
              Navigator.of(context).pushNamed('/tab1/detail');
            },
            child: const Text("Go to Tab 1 Detail (nested push)"),
          ),
        ],
      ),
    );
  }
}

class _Tab1Detail extends StatelessWidget {
  const _Tab1Detail();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Tab 1 - Detail Page", style: TextStyle(fontSize: 24)),
          const SizedBox(height: 10),
          const Text(
            "Notice: the bottom nav bar is still visible!\n"
            "This page was pushed inside the nested Navigator.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Go back (nested pop)"),
          ),
        ],
      ),
    );
  }
}

class _Tab2 extends StatelessWidget {
  const _Tab2();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Tab 2 - Search", style: TextStyle(fontSize: 24)),
    );
  }
}

class _Tab3 extends StatelessWidget {
  const _Tab3();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Tab 3 - Profile", style: TextStyle(fontSize: 24)),
    );
  }
}
