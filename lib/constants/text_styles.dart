import 'package:flutter/material.dart';

import 'colors.dart';

/// Class where all app text styles are stored

class AppTextStyles {
  static const title = TextStyle(
    color: AppColors.textColor,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    // height: 2.8,
    fontFamily: '.SF Pro Display',
  );

  static const subtitle = TextStyle(
    color: AppColors.textColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 2,
    fontFamily: '.SF Pro Display',
  );

  static const regular = TextStyle(
    color: AppColors.textColor,
    fontSize: 13,
    fontWeight: FontWeight.w300,
    fontFamily: '.SF Pro Display',
  );
}
