import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlng/latlng.dart';

const kMarker = "https://www.sccpre.cat/png/big/16/164026_map-marker-png.png";

class MapScreen extends StatefulWidget {
  MapScreen(BuildContext context, {required Key key}) : super(key: key);

  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<LatLng> _touches = [];
  List<Polygon> _polygons = [];

  void _addMarker(LatLng pos) {
    setState(() => _touches.add(pos));
  }

  Polygon _buildPolygonFromTouches() {
    return Polygon(
      points: _touches.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      borderColor: Colors.black,
      borderStrokeWidth: 3.0,
      color: Colors.black26,
      isDotted: true,
    );
  }

  void _onMarkerTap(LatLng pos, bool isFirst) {
    if (!isFirst) return;
    _touches.add(pos);
    _polygons.add(_buildPolygonFromTouches());
    _touches.clear();
    setState(() {}); // Force rebuild
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];
    for (var i = 0; i < _touches.length; i++) {
      final pos = _touches[i];
      markers.add(Marker(
        width: 30.0,
        height: 30.0,
        point: pos,
        builder: (_) => GestureDetector(
          onTap: () => _onMarkerTap(pos, i == 0),
          onLongPress: () => setState(() => _touches.removeAt(i)),
          child: Image.network(kMarker),
        ),
      ));
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
        onTap: _addMarker,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://tiles.stadiamaps.com/styles/alidade_smooth.json?api_key=809d7f73-8498-4f6f-992d-e8aefaa4e0a0",
        ),
        PolygonLayerOptions(polygons: _polygons),
        MarkerLayerOptions(markers: _buildMarkers()),
      ],
    );
  }
}