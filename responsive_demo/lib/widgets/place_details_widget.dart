import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:responsive_demo/models/place.dart';

class PlaceDetailsWidget extends StatelessWidget {
  final Place place;
  const PlaceDetailsWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return LayoutBuilder(
      builder: (_, constraints) {
        final fontSize = constraints.maxWidth * 0.025;
        final fontSizeSubtitle = constraints.maxWidth * 0.015;

        return constraints.maxWidth >= 600
            ? _buildLargeWidget(primaryColor, fontSize, fontSizeSubtitle)
            : _buildSmallWidget(primaryColor, fontSize, fontSizeSubtitle);
      },
    );
  }

  Widget _buildLargeWidget(
    Color color,
    double fontSize,
    double fontSizeSubtitle,
  ) {
    return Container(
      color: Colors.grey[300],
      child: SingleChildScrollView(
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 9,
          margin: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Image.asset(
                      place.image,
                      width: double.infinity,
                      height: 320,
                      fit: BoxFit.cover,
                    ),
                    _buildTitle(fontSize, fontSizeSubtitle),
                  ],
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildButtons(color),
                    _buildDescription(place.description, fontSize),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallWidget(
    Color color,
    double fontSize,
    double fontSizeSubtitle,
  ) {
    return ListView(
      children: [
        Image.asset(
          place.image,
          width: double.infinity,
          fit: BoxFit.cover,
          height: 320,
        ),
        _buildTitle(fontSize, fontSizeSubtitle),
        const SizedBox(height: 16),
        _buildButtons(color),
        _buildDescription(place.description, fontSize),
      ],
    );
  }

  Widget _buildDescription(String text, double fontSize) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: AutoSizeText(
        text,
        minFontSize: 16,
        maxFontSize: 20,
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  Widget _buildTitle(double fontSize, double fontSizeSubtitle) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  place.title,
                  minFontSize: 20,
                  maxFontSize: 24,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                AutoSizeText(
                  place.subtitle,
                  minFontSize: 16,
                  maxFontSize: 20,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: fontSizeSubtitle,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.star, color: Colors.red[500]),
          const SizedBox(width: 8),
          Text("4.9"),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildButton(Color color, IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildButtons(Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButton(color, Icons.call, "Call"),
        _buildButton(color, Icons.map, "Route"),
        _buildButton(color, Icons.share, "Share"),
      ],
    );
  }
}
