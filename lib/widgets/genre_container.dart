import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';

class GenreContainer extends StatelessWidget {
  final String genre;
  const GenreContainer({required this.genre, super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 26.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.r),
          child: Text(
            genre,
            style: AppTextStyles.regular.copyWith(fontSize: 11),
          ),
        ),
      );
}
