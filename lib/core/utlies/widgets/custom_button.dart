
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.title, this.backgroundColor, this.textColor});

  final void Function() onTap;
  final String title;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90.w,
        height: 6.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.roundToDouble()),
          color:backgroundColor ??AppColors.primaryPink,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: textColor??AppColors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
