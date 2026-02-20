import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key, this.data});
  final String? data;

  @override
  Widget build(BuildContext context) {
    // final data=ModalRoute.of(context)!.settings.arguments;
    return Column(
      children: [
        Text("$data"),
        SizedBox(height: 8),
        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child:Text("go back")),
      ],
    );
  }
}
