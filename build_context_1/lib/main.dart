import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff123456),
      
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static bool _isMobile(BuildContext context)=>MediaQuery.of(context).size.width<600;
  static bool _isTablet(BuildContext context)=>MediaQuery.of(context).size.width<1024;
  static bool _isDesktop(BuildContext context)=>MediaQuery.of(context).size.width<1024;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // Theme.of(context).primaryColor;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You have pushed the button $_counter times'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
   
        backgroundColor: _isMobile(context)?Colors.red: _isTablet(context)?Colors.green:Colors.blue ,
        title: Text(widget.title),
      ),
      body: Container(
        width: double.infinity  ,
        decoration: BoxDecoration(
          color: _isMobile(context)?Colors.red: _isTablet(context)?Colors.green:Colors.blue ,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
