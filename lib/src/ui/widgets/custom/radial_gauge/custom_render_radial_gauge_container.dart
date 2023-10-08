import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:geekyants_flutter_gauges/src/radial_gauge/radial_gauge_container_painter.dart';

class CustomRenderRadialGaugeContainer extends RenderRadialGaugeContainer {
  CustomRenderRadialGaugeContainer({
    Key? key,
    required RadialGauge radialGauge,
  })  : _radialGauge = radialGauge,
        super(key: key, radialGauge: radialGauge);

  final RadialGauge _radialGauge;

  void paintRulersAndLabels(
    Canvas canvas,
    double numParts,
    double startAngle,
    double partAngle,
    double radius,
    double thickness,
    double rulerLength,
    Offset center,
  ) {
    bool showFirstLabel = getRadialGauge.track.trackStyle.showFirstLabel;
    bool showLastLabel = getRadialGauge.track.trackStyle.showLastLabel;
    // Primary Ruler Paint
    final Paint primaryRulerPaint = Paint()
      ..color = getRadialGauge.track.trackStyle.primaryRulerColor!
      ..strokeWidth = getRadialGauge.track.trackStyle.primaryRulersWidth!
      ..style = PaintingStyle.stroke;

    // Secondary Ruler Paint
    final Paint secondaryRulerPaint = Paint()
      ..color = getRadialGauge.track.trackStyle.secondaryRulerColor!
      ..strokeWidth = getRadialGauge.track.trackStyle.secondaryRulersWidth!
      ..style = PaintingStyle.stroke;

    // Loop to draw the Rulers and Labels
    for (int i = 0; i <= numParts; i++) {
      double rulerOffset = getRadialGauge.track.trackStyle.rulersOffset ?? 0;
      final double angle =
          startAngle + i * partAngle; // angle of the current part
      final Offset startPoint = Offset(
          (radius - thickness - rulerOffset) * cos(angle),
          (radius - thickness - rulerOffset) * sin(angle));
      final Offset endPoint = Offset(
          ((radius - thickness - rulerOffset) - rulerLength) * cos(angle),
          ((radius - thickness - rulerOffset) - rulerLength) * sin(angle));

      final Offset labelEndPoint = Offset(
          (radius - rulerLength - 20 - thickness) * cos(angle),
          (radius - rulerLength - 20 - thickness) * sin(angle));

      var secondaryRulerInterval =
          getRadialGauge.track.trackStyle.secondaryRulerPerInterval ?? 1;
      var secondaryRulerLength =
          getRadialGauge.track.trackStyle.secondaryRulersHeight ?? 5;

      final double secondaryRulerAngle =
          partAngle / (secondaryRulerInterval + 1);

      // Draw the primary Ruler
      if (getRadialGauge.track.trackStyle.showPrimaryRulers) {
        canvas.drawLine(
            center + startPoint, center + endPoint, primaryRulerPaint);
      }
      if (i != numParts) {
        for (int j = 1; j <= secondaryRulerInterval; j++) {
          final double secondaryAngle = angle + (j * secondaryRulerAngle);
          final Offset secondaryStartPoint = Offset(
              (radius - thickness - rulerOffset) * cos(secondaryAngle),
              (radius - thickness - rulerOffset) * sin(secondaryAngle));

          final Offset secondaryEndPoint = Offset(
              ((radius - thickness - rulerOffset) - secondaryRulerLength) *
                  cos(secondaryAngle),
              ((radius - thickness - rulerOffset) - secondaryRulerLength) *
                  sin(secondaryAngle));

          // Draw the secondary Ruler
          if (getRadialGauge.track.trackStyle.showSecondaryRulers) {
            canvas.drawLine(
              center + secondaryStartPoint,
              center + secondaryEndPoint,
              secondaryRulerPaint,
            );
          }
        }
      }

      //* DRAW  LABELS
      final TextPainter textPainter =
          TextPainter(textDirection: TextDirection.ltr);

      const String labelFormat = '%d';
      final double langle =
          startAngle + i * partAngle; // the angle of the current ruler
      // the y coordinate of the label
      final String label = labelFormat.replaceAll(
          '%d', ((langle - startAngle) * 180 / pi).round().toString());
      double l = double.parse(label);
      double sAngle = _radialGauge.track.startAngle;
      double eAngle = _radialGauge.track.endAngle;

      double range = eAngle - sAngle;
      double start = _radialGauge.track.start;
      double end = _radialGauge.track.end;
      double valueRange = (end - start);

      String exactValue =
          (start + double.parse(((l / range) * valueRange).toStringAsFixed(2)))
              .toInt()
              .toString();
      Color textColor = Colors.black;
      textPainter.text = TextSpan(
          text: '',
          style: getRadialGauge.track.trackStyle.labelStyle ??
              TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
              ));
      textPainter.layout();

      if (i == 0 && !showFirstLabel) {
        continue; // Skip drawing the first label
      }

      // Check if it's the last label and showLastLabel is false
      if (i == numParts && !showLastLabel) {
        continue; // Skip drawing the last label
      }

      final Offset labelOffset = Offset(
          (labelEndPoint.dx + center.dx) - textPainter.width / 2,
          (labelEndPoint.dy + center.dy) - textPainter.height / 2);
      if (getRadialGauge.track.trackStyle.showLabel!) {
        textPainter.paint(canvas, labelOffset);
      }
    }
  }
}
