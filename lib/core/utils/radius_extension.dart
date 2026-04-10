import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension RadiusExtension on num {
  BorderRadius get br => BorderRadius.circular(toDouble().r);

  BorderRadius get tbr =>
      BorderRadius.vertical(top: Radius.circular(toDouble().r));

  BorderRadius get bbr =>
      BorderRadius.vertical(bottom: Radius.circular(toDouble().r));

  BorderRadius get lbr =>
      BorderRadius.horizontal(left: Radius.circular(toDouble().r));

  BorderRadius get rbr =>
      BorderRadius.horizontal(right: Radius.circular(toDouble().r));
}
