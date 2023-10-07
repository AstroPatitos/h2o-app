import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
          ),
        ));
  }
}
