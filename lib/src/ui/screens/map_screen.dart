
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //late GoogleMapController _controller;

  void initState() {
    super.initState();
    
    HomeWidget.widgetClicked.listen((val) {
      Navigator.of(context).pushNamedAndRemoveUntil('generalInformation', (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map Screen'),
        ),
        body: Text("Mapa"));
  }
}
