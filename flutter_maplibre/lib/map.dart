import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

const apiKey = "809d7f73-8498-4f6f-992d-e8aefaa4e0a0";

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Map();
  }
}

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State createState() => MapState();
}

class MapState extends State<Map> {
  MaplibreMapController? mapController;
  late CameraPosition _initialCameraPosition;

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;
  }

  void _onStyleLoadedCallback() async {

  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: MaplibreMap(
        initialCameraPosition: const CameraPosition(target: LatLng(0.0, 0.0)),
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _onStyleLoadedCallback,
        myLocationEnabled: true,
        styleString: _mapStyleUrl(),
        onMapClick: _onMapClick,
        trackCameraPosition: true,
      ),
    );
  }

  String _mapStyleUrl() {
    const styleUrl = "https://tiles.stadiamaps.com/styles/alidade_smooth.json";
    return "$styleUrl?api_key=$apiKey";
  }

}