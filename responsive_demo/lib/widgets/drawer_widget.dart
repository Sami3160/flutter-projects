import 'package:flutter/material.dart';
import 'package:responsive_demo/data/states.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: allStates.length + 1,
        itemBuilder: (context, index) =>
            index == 0 ? _buildHeader() : _buildMenuItem(index),
      ),
    );
  }

  Widget _buildHeader() => DrawerHeader(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ExactAssetImage("images/leh.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      alignment: AlignmentDirectional.bottomStart,
      child: Text("India", style: TextStyle(color: Colors.white, fontSize: 26)),
    ),
  );

  Widget _buildMenuItem(int index) => ListTile(
    leading: const Icon(Icons.location_city),
    title: Text(allStates[index - 1], style: TextStyle(fontSize: 22)),
  );
}
