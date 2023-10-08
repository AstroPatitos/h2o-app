import 'package:flutter/widgets.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:geekyants_flutter_gauges/src/radial_gauge/radial_gauge.dart';
import 'package:geekyants_flutter_gauges/src/radial_gauge/radial_gauge_state.dart';

import 'custom_radial_gauge_container.dart';

class CustomRadialGauge extends RadialGauge {
  const CustomRadialGauge({
    Key? key,
    required this.track,
    this.valueBar,
    this.xCenterCoordinate = 0.5,
    this.yCenterCoordinate = 0.5,
    this.radiusFactor = 1,
    this.shapePointer = const [],
    this.needlePointer = const [],
    this.widgetPointer = const [],
  }) : super(
          key: key,
          track: track,
          valueBar: valueBar,
          xCenterCoordinate: xCenterCoordinate,
          yCenterCoordinate: yCenterCoordinate,
          radiusFactor: radiusFactor,
          shapePointer: shapePointer,
          needlePointer: needlePointer,
          widgetPointer: widgetPointer,
        );

  final double xCenterCoordinate;
  final double yCenterCoordinate;
  final double radiusFactor;
  final List<RadialShapePointer>? shapePointer;
  final List<RadialWidgetPointer> widgetPointer;
  final RadialTrack track;
  final List<NeedlePointer>? needlePointer;
  final List<RadialValueBar>? valueBar;

  @override
  State<RadialGauge> createState() => _CustomRadialGuageState();
}

class _CustomRadialGuageState extends State<RadialGauge> {
  late List<Widget> _radialGaugeWidgets;

  @override
  void initState() {
    super.initState();
    _radialGaugeWidgets = <Widget>[];
  }

  @override
  void didUpdateWidget(RadialGauge oldWidget) {
    if (widget != oldWidget) {
      _radialGaugeWidgets = <Widget>[];
    }
    super.didUpdateWidget(oldWidget);
  }

  List<Widget> _buildChildWidgets(BuildContext context) {
    _radialGaugeWidgets.clear();

    _radialGaugeWidgets.add(CustomRadialGaugeContainer(
      radialGauge: widget,
    ));

    if (widget.needlePointer != null) {
      for (int i = 0; i < widget.needlePointer!.length; i++) {
        _addChild(widget.needlePointer![i], null, null);
      }
    }
    if (widget.widgetPointer != null) {
      for (int i = 0; i < widget.widgetPointer!.length; i++) {
        _addChild(widget.widgetPointer![i], null, null);
      }
    }
    if (widget.valueBar != null) {
      for (int i = 0; i < widget.valueBar!.length; i++) {
        _addChild(widget.valueBar![i], null, null);
      }
    }

    if (widget.shapePointer != null) {
      for (int i = 0; i < widget.shapePointer!.length; i++) {
        _addChild(widget.shapePointer![i], null, null);
      }
    }
    return _radialGaugeWidgets;
  }

  void _addChild(Widget child, Animation<double>? animation,
      AnimationController? controller) {
    _radialGaugeWidgets.add(RadialGaugeState(
      rGauge: widget,
      track: widget.track,
      child: child,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RRadialGauge(
      rGauge: widget,
      children: _buildChildWidgets(context),
    );
  }
}
