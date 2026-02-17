import 'package:flutter/material.dart';
import 'package:responsive_demo/models/place.dart';

class PlaceDetailsWidget extends StatelessWidget {
  final Place place;
  PlaceDetailsWidget({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          place.image,
          width: double.infinity,
          fit: BoxFit.cover,
          height: 320,
        ),
        _buildTitle(),
        const SizedBox(height: 16),
        _buildButtons(Theme.of(context).primaryColor),
        _buildDescription(place.description),
      ],
    );
  }

  Widget _buildDescription(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(text, style: TextStyle(fontSize: 20)),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.title, style: TextStyle(fontSize: 24)),
                const SizedBox(height: 8),
                Text(
                  place.subtitle,
                  style: TextStyle(color: Colors.grey[500], fontSize: 20),
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
