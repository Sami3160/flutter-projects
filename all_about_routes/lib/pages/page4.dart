import 'package:flutter/material.dart';

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    final data=ModalRoute.of(context)!.settings.arguments;
    return Column(
      children: [
        Text("$data"),
        SizedBox(height: 8),
        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child:Text("go back")),
      ],
    );
  }
}
