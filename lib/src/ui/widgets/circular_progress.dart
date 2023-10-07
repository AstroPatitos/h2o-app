import 'package:flutter/material.dart';
import 'package:h2o_app/src/ui/components/colors.dart';

Center circularProgress({
  Color? color,
}) {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        (color != null) ? color : secondaryColor,
      ),
    ),
  );
}
