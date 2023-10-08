import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h2o_app/src/helpers/printers.dart';
import 'package:h2o_app/src/ui/screens/general_information_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  Future<String> _loadMapStyle() async {
    return await rootBundle.loadString('lib/src/models/custom_map_style.json');
  }

  final LatLng gulfOfMexicoCenter = const LatLng(25.1557, -94.8607);

  final Set<LatLng> waterBodies = {
    const LatLng(25.1557, -94.8607),
  };

  final LatLng upperLeftCorner = const LatLng(30.0, -90.0);
  final LatLng lowerRightCorner = const LatLng(20.0, -80.0);
  final double radius = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(24.9361108, -97.6591505),
          zoom: 5,
        ),
        onMapCreated: (controller) async {
          final String style = await _loadMapStyle();

          setState(() {
            _controller = controller;
            _controller.setMapStyle(style);
          });
        },
        mapType: MapType.normal,
        circles: waterBodies.map((LatLng waterBody) {
          return Circle(
            circleId: CircleId(waterBody.toString()),
            center: waterBody,
            radius: radius *
                6378137, // Convert degrees to meters using Earth's radius.
            fillColor: const Color.fromARGB(255, 56, 102, 129).withOpacity(0.3),
            strokeColor: const Color.fromARGB(255, 56, 102, 129),
            strokeWidth: 2, // Width of the circle outline
          );
        }).toSet(),
        onTap: (LatLng latLng) {
          for (var waterBody in waterBodies) {
            if (LatLngBounds(
              southwest: LatLng(
                  waterBody.latitude - radius, waterBody.longitude - radius),
              northeast: LatLng(
                  waterBody.latitude + radius, waterBody.longitude + radius),
            ).contains(latLng)) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const GeneralInformationScreen(),
                ),
              );
              break;
            }
          }
        },
      ),
    );
  }
}
