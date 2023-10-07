import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h2o_app/src/ui/screens/map_screen.dart';
import 'package:h2o_app/src/ui/screens/no_connection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  _checkConnection() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _navigateToMapScreen();
      } else {
        _navigateNoConnectionPage();
      }
    } on SocketException catch (_) {
      _navigateNoConnectionPage();
    }
  }

  void _navigateToMapScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );
  }

  void _navigateNoConnectionPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NoConnectionScreen(),
      ),
    );
  }

  BoxDecoration get _boxDecoration {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color.fromARGB(255, 56, 146, 250),
          Color.fromARGB(255, 25, 95, 175),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: _boxDecoration,
          ),
          Container(
            alignment: const Alignment(0.03, 0.03),
            padding: const EdgeInsets.all(20),
            child: const Image(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          )
        ],
      ),
    );
  }
}
