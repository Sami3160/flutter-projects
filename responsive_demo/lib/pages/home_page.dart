import 'package:flutter/material.dart';
import 'package:responsive_demo/widgets/drawer_widget.dart';
import 'package:responsive_demo/widgets/responsive_widget.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    final isMobile=ResponsiveWidget.isMobile(context);
  
    return Scaffold(
      appBar: AppBar(title: const Text("Tourism App"),),
      drawer: isMobile? const DrawerWidget():null,
      body: ResponsiveWidget(mobileWidget: _buildMobileWidget(), tabletWidget: _buildTabletWidget(), desktopWidget: _buildDesktopWidget()),
    );
  }
}

Widget _buildMobileWidget()=>Container(
  color: Colors.red,
  child: const Center(child: Text("Mobile")),
);

Widget _buildDesktopWidget()=>Container(
  color: Colors.green,
  child: const Center(child: Text("Desktop")),
);

Widget _buildTabletWidget()=>Container(
  color: Colors.blue,
  child: const Center(child: Text("Tablet")),
);