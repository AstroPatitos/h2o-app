import 'package:flutter/material.dart';

BoxDecoration customBoxDecoration(
  double radius, {
  Color color = Colors.white,
  Radius? topLeft,
  Radius? topRight,
  Radius? bottomLeft,
  Radius? bottomRight,
  bool hasShadow = true,
}) {
  return BoxDecoration(
    boxShadow: hasShadow ? customBoxShadow() : null,
    color: color,
    borderRadius: BorderRadius.only(
      topLeft: topLeft ?? Radius.circular(radius),
      bottomLeft: bottomLeft ?? Radius.circular(radius),
      bottomRight: bottomRight ?? Radius.circular(radius),
      topRight: topRight ?? Radius.circular(radius),
    ),
  );
}

List<BoxShadow> customBoxShadow() {
  return [
    BoxShadow(
      color: Colors.black.withOpacity(0.16),
      blurRadius: 6,
    )
  ];
}
