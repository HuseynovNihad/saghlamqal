import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizedBoxExtension on num {
  Widget get hs => SizedBox(height: toDouble().h);

  Widget get hw => SizedBox(width: toDouble().w);
}
