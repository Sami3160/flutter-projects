import 'package:flutter/material.dart';
import 'package:responsive_demo/data/places.dart';
import 'package:responsive_demo/models/place.dart';
import 'package:responsive_demo/widgets/grid_item_widget.dart';

class PlaceGalleryWidget extends StatelessWidget {
  final bool isHorizantal;
  final ValueChanged<Place> onPlaceChanged;
  const PlaceGalleryWidget({
    super.key,
    this.isHorizantal = false,
    required this.onPlaceChanged,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: isHorizantal ? 1 : 2,
        scrollDirection: isHorizantal ? Axis.horizontal : Axis.vertical,
        children: allPlaces
            .map<Widget>(
              (place) =>
                  GridItemWidget(place: place, onPlaceChanged: onPlaceChanged),
            )
            .toList(),
      ),
    );
  }
}
