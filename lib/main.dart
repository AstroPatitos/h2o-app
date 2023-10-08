import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h2o_app/src/ui/screens/general_information_screen.dart';
import 'package:h2o_app/src/ui/screens/map_screen.dart';
import 'package:h2o_app/src/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:home_widget/home_widget.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  HomeWidget.widgetClicked.listen((val) {
    print("test: $val");
  });
  runApp(const MyApp());
}

dynamic backgroundCallback(Uri? uri) async {
  if (uri?.host == 'updatecounter') {
    dynamic _counter;
    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0).then((value) {
      _counter = value;
      _counter++;
    });
    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  }
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      home: const SplashScreen(),
      initialRoute: 'splash',
      routes: {
        'splash': (_) => const SplashScreen(),
        'main': (context) => const MapScreen(),
        'generalInformation': (context) => const GeneralInformationScreen(),
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0,
        ),
      ),
    );
  }
}
