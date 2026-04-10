import 'package:flutter/material.dart';
import 'radius_extension.dart';

extension BorderExtension on Color {
  OutlineInputBorder border({double width = 1.0, double radius = 12}) {
    return OutlineInputBorder(
      borderRadius: radius.br,
      borderSide: BorderSide(color: this, width: width),
    );
  }

  Border all({double width = 1.0}) {
    return Border.all(color: this, width: width);
  }
}
