import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:h2o_app/src/ui/components/box_decoration.dart';
import 'package:h2o_app/src/ui/widgets/custom/radial_gauge/custom_radial_gauge.dart';

class GeneralInformationScreen extends StatefulWidget {
  const GeneralInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GeneralInformationScreenState();
}

class _GeneralInformationScreenState extends State<GeneralInformationScreen> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  final List<Map<String, dynamic>> dangerFactors = [
    {
      'icon': 'assets/icons/wind.svg',
      'title': 'Climate effect',
      'level': 2,
    },
    {
      'icon': 'assets/icons/water.svg',
      'title': 'Water depth',
      'level': 2,
    },
    {
      'icon': 'assets/icons/temperature.svg',
      'title': 'Water temperature',
      'level': 0,
    },
    {
      'icon': 'assets/icons/toxic.svg',
      'title': 'Contamination',
      'level': 2,
    },
    {
      'icon': 'assets/icons/shark.svg',
      'title': 'Dangerous animals',
      'level': 1,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  Color _getDangerousColor(int level) {
    if (level == 0) {
      return Colors.green;
    } else if (level == 1) {
      return const Color.fromARGB(255, 238, 226, 115);
    } else {
      return Colors.red;
    }
  }

  Color _getDangerousBackgroundColor(int level) {
    if (level == 0) {
      return const Color.fromARGB(255, 143, 223, 146);
    } else if (level == 1) {
      return const Color.fromARGB(255, 238, 227, 132);
    } else {
      return const Color.fromRGBO(255, 200, 200, 1.0);
    }
  }

  Icon _getDangerousIcon(int level) {
    if (level == 0) {
      return const Icon(
        Icons.check,
        color: Color.fromARGB(255, 48, 143, 51),
        size: 20,
      );
    } else if (level == 1) {
      return const Icon(
        Icons.warning_amber_outlined,
        color: Color.fromARGB(255, 151, 139, 32),
        size: 20,
      );
    } else {
      return const Icon(
        Icons.warning_amber_outlined,
        color: Color.fromARGB(255, 179, 42, 42),
        size: 20,
      );
    }
  }

  SizedBox _renderBottomBar(BuildContext context) {
    return SizedBox(
      height: 80,
      child: BottomNavigationBar(
        onTap: (index) {},
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.insert_drive_file), label: 'Local fauna'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: 'Reviews'),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb), label: 'Fun facts'),
        ],
      ),
    );
  }

  RadialGauge _renderRadialGauge() {
    return const CustomRadialGauge(
      track: RadialTrack(
        startAngle: 0,
        endAngle: 180,
        color: Colors.grey,
        start: 0,
        end: 3,
        steps: 3,
        trackStyle: TrackStyle(
          showLastLabel: true,
          secondaryRulerColor: Colors.grey,
          primaryRulersHeight: 5,
          secondaryRulersHeight: 5,
          secondaryRulerPerInterval: 3,
        ),
      ),
      valueBar: [
        RadialValueBar(
          value: 3,
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.green],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          valueBarThickness: 13,
        ),
        RadialValueBar(
          value: 2,
          gradient: LinearGradient(
            colors: [Colors.yellowAccent, Colors.yellow],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          valueBarThickness: 13,
        ),
        RadialValueBar(
          value: 1,
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          valueBarThickness: 13,
        ),
      ],
      needlePointer: [
        NeedlePointer(
          needleHeight: 25,
          needleWidth: 8,
          value: 1.5,
          color: Colors.red,
          tailColor: Colors.black,
          tailRadius: 15,
          needleStyle: NeedleStyle.gaugeNeedle,
        )
      ],
    );
  }

  Container get _qualityOfWaterContainer {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 35),
      child: Container(
        height: 160,
        width: 180,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: IgnorePointer(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 130,
                            child: _renderRadialGauge(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: const Text(
                    'Quality of Water',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF860000),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container get _swimmingSafetyContainer {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 35),
      child: Container(
          height: 160,
          width: 180,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/swimming.svg',
                width: 60,
                height: 60,
              ),
              const Positioned(
                top: 3,
                child: Icon(
                  Icons.block,
                  color: Color(0xFF860000),
                  size: 95,
                ),
              ),
              Column(
                children: const [
                  SizedBox(height: 87),
                  Text(
                    'Swimming Safety',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF860000),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lago Chernobyl'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.star_border,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: _renderBottomBar(context),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _qualityOfWaterContainer,
                  _swimmingSafetyContainer,
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                width: MediaQuery.of(context).size.width,
                decoration: customBoxDecoration(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Danger factors',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: dangerFactors
                            .map(
                              (dangerFactor) => Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          dangerFactor['icon'],
                                          width: 32,
                                          height: 32,
                                          colorFilter: ColorFilter.mode(
                                              _getDangerousColor(
                                                  dangerFactor['level']),
                                              BlendMode.srcIn),
                                        ),
                                        const SizedBox(width: 25),
                                        Text(
                                          dangerFactor['title'],
                                          style: TextStyle(
                                            color: _getDangerousColor(
                                                dangerFactor['level']),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(3),
                                      height: 32,
                                      width: 32,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _getDangerousBackgroundColor(
                                              dangerFactor['level'])),
                                      child: _getDangerousIcon(
                                          dangerFactor['level']),
                                    )
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
