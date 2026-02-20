import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Page 1"),
        SizedBox(height: 8),
        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child:Text("go back")),
      ],
    );
  }
}
