import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_demo/models/place.dart';
import 'package:responsive_demo/widgets/details_page.dart';
import 'package:responsive_demo/widgets/responsive_widget.dart';

class GridItemWidget extends StatelessWidget {
  final Place place;
  final ValueChanged<Place> onPlaceChanged;
  const GridItemWidget({
    super.key,
    required this.place,
    required this.onPlaceChanged,
  });
  @override
  Widget build(BuildContext context) {
    final fontSize = MediaQuery.of(context).size.width * 0.025;
    final fontSizeSubtitle = MediaQuery.of(context).size.width * 0.015;
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: InkWell(
        onTap: () {
          final isMobile = ResponsiveWidget.isMobile(context);
          final isTablet = ResponsiveWidget.isTablet(context);
          if (isMobile || isTablet) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsPage(place: place),
              ),
            );
          } else {
            onPlaceChanged(place);
          }
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: AutoSizeText(
              place.title,
              minFontSize: 18,
              maxFontSize: 22,
              style: TextStyle(fontSize: fontSize),
            ),
            subtitle: AutoSizeText(
              place.subtitle,
              minFontSize: 14,
              maxFontSize: 20,
              style: TextStyle(fontSize: fontSizeSubtitle),
            ),
          ),
          child: Ink.image(image: AssetImage(place.image), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
