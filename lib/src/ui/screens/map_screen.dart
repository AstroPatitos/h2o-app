import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:h2o_app/src/helpers/printers.dart';
import 'package:h2o_app/src/services/location_service.dart';
import 'package:h2o_app/src/ui/components/colors.dart';
import 'package:h2o_app/src/ui/screens/general_information_screen.dart';
import 'package:home_widget/home_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;
  final LatLng gulfOfMexicoCenter = const LatLng(25.1557, -94.8607);

  final Set<LatLng> waterBodies = {
    const LatLng(25.1557, -90.8607),
  };
  final double radius = 25;

  @override
  void initState() {
    super.initState();

    /* _loadPoints().then((value) {
      value.forEach((v) {
        waterBodies.add(
            LatLng(double.parse(v['latitude']), double.parse(v['longitude'])));
      });
    }); */
    waterBodies.add(const LatLng(18.193717, -110.080321));

    HomeWidget.widgetClicked.listen((val) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('generalInformation', (route) => false);
    });
  }

  Future<String> _loadMapStyle() async {
    return await rootBundle.loadString('lib/src/models/custom_map_style.json');
  }

  Future<dynamic> _loadPoints() async {
    dynamic test = jsonDecode(
      await rootBundle.loadString('lib/src/models/points.json'),
    );
    return test;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'H2O Map',
          style: TextStyle(color: primaryColor),
        ),
        backgroundColor: Colors.white,
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
