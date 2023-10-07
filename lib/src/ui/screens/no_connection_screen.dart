import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h2o_app/src/ui/components/colors.dart';
import 'package:h2o_app/src/ui/screens/map_screen.dart';
import 'package:h2o_app/src/ui/widgets/circular_progress.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool _shouldReconnect = false;

  void _reconnect() async {
    setState(() {
      _shouldReconnect = true;
    });
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _navigateToMapScreen();
      } else {
        setState(() {
          _shouldReconnect = false;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        _shouldReconnect = false;
      });
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

  Padding get _titleContent {
    return const Padding(
      padding: EdgeInsets.only(top: 32, bottom: 24),
      child: Text('¡Problemas de conexión!'),
    );
  }

  Padding get _descriptionContent {
    return const Padding(
      padding: EdgeInsets.only(left: 64, right: 64, bottom: 24),
      child: Text(
        'Por favor revisa tu\nservicio de Internet y\nvuelve a intentar',
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: darkGradientAlpha),
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 225,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _titleContent,
              _descriptionContent,
              MaterialButton(
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                disabledColor: Colors.black87,
                elevation: 0,
                onPressed: _reconnect,
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.5,
                    maxWidth: MediaQuery.of(context).size.width * 0.5,
                    maxHeight: 50,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: primaryGradient,
                  ),
                  child: _shouldReconnect
                      ? circularProgress()
                      : const Text('Reintentar',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            color: Colors.white,
                            fontSize: 16,
                          )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
