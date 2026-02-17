import 'package:flutter/material.dart';
import 'package:responsive_demo/widgets/drawer_widget.dart';
import 'package:responsive_demo/widgets/place_gallery_widget.dart';
import 'package:responsive_demo/widgets/responsive_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveWidget.isMobile(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Tourism App")),
      drawer: isMobile ? const DrawerWidget() : null,
      body: ResponsiveWidget(
        mobileWidget: _buildMobileWidget(),
        tabletWidget: _buildTabletWidget(),
        desktopWidget: _buildDesktopWidget(),
      ),
    );
  }
}

Widget _buildMobileWidget() => Container(child: const PlaceGalleryWidget());

Widget _buildDesktopWidget() => Container(
  width: double.infinity,
  height: double.infinity,
  color: Colors.blue,
  child: const Center(
    child: Text("desktop", style: TextStyle(fontSize: 24, color: Colors.white)),
  ),
);

Widget _buildTabletWidget() => Row(
  children: [
    Expanded(flex: 2, child: DrawerWidget()),
    Expanded(flex: 5, child: PlaceGalleryWidget()),
  ],
);
