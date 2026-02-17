import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_demo/data/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.025;
    return Drawer(
      child: ListView.builder(
        itemCount: allStates.length + 1,
        itemBuilder: (context, index) =>
            index == 0 ? _buildHeader(fontSize) : _buildMenuItem(index),
      ),
    );
  }

  Widget _buildHeader(double fontSize) => DrawerHeader(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ExactAssetImage("images/leh.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      alignment: AlignmentDirectional.bottomStart,
      child: AutoSizeText(
        "India",
        minFontSize: 26,
        maxFontSize: 30,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    ),
  );

  Widget _buildMenuItem(int index) => ListTile(
    leading: const Icon(Icons.location_city),
    title: Text(allStates[index - 1], style: TextStyle(fontSize: 22)),
  );
}
