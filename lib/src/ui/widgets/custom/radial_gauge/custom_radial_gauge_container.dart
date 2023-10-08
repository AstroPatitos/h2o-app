import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/rendering/object.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:geekyants_flutter_gauges/src/radial_gauge/radial_gauge_container.dart';

import 'custom_render_radial_gauge_container.dart';

class CustomRadialGaugeContainer extends RadialGaugeContainer {
  CustomRadialGaugeContainer({required this.radialGauge})
      : super(key: GlobalKey(), radialGauge: radialGauge);

  final RadialGauge radialGauge;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return CustomRenderRadialGaugeContainer(radialGauge: radialGauge);
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant CustomRenderRadialGaugeContainer renderObject) {
    renderObject.setRadialGauge = radialGauge;
  }
}
