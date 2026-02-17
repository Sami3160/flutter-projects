import 'package:flutter/material.dart';
import 'package:responsive_demo/models/place.dart';
import 'package:responsive_demo/widgets/place_details_widget.dart';

class DetailsPage extends StatelessWidget{
  final Place place;
  const DetailsPage({required this.place, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        centerTitle: true,
      ),
      body: PlaceDetailsWidget(place: place),
    );
  }
}