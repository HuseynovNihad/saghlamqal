import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppPaddingExtension on num {
  EdgeInsets get p => EdgeInsets.all(toDouble().r);

  EdgeInsets get px => EdgeInsets.symmetric(horizontal: toDouble().w);

  EdgeInsets get py => EdgeInsets.symmetric(vertical: toDouble().h);

  EdgeInsets get pt => EdgeInsets.only(top: toDouble().h);
  EdgeInsets get pb => EdgeInsets.only(bottom: toDouble().h);
  EdgeInsets get pl => EdgeInsets.only(left: toDouble().w);
  EdgeInsets get pr => EdgeInsets.only(right: toDouble().w);
}
