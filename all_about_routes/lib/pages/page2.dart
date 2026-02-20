import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Page 2"),
        SizedBox(height: 8),
        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child:Text("go back")),
      ],
    );
  }
}
