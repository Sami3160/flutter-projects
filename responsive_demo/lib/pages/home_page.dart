import 'package:flutter/material.dart';
import 'package:responsive_demo/data/places.dart';
import 'package:responsive_demo/models/place.dart';
import 'package:responsive_demo/widgets/drawer_widget.dart';
import 'package:responsive_demo/widgets/place_details_widget.dart';
import 'package:responsive_demo/widgets/place_gallery_widget.dart';
import 'package:responsive_demo/widgets/responsive_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Place selectedPlace = allPlaces[0];
  void changePlace(Place place) => setState(() => selectedPlace = place);

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

  Widget _buildMobileWidget() =>
      PlaceGalleryWidget(onPlaceChanged: changePlace);

  Widget _buildDesktopWidget() => Row(
    children: [
      Expanded(child: DrawerWidget()),
      Expanded(flex: 3, child: _buildBody()),
    ],
  );

  Widget _buildTabletWidget() => Row(
    children: [
      Expanded(flex: 2, child: DrawerWidget()),
      Expanded(flex: 5, child: PlaceGalleryWidget(onPlaceChanged: changePlace)),
    ],
  );

  Widget _buildBody() => Column(
    children: [
      Expanded(
        child: PlaceGalleryWidget(
          isHorizantal: true,
          onPlaceChanged: changePlace,
        ),
      ),
      Expanded(flex: 2, child: PlaceDetailsWidget(place: selectedPlace)),
    ],
  );
}
