import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher();

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        context.setLocale(
          isEnglish ? const Locale('ar') : const Locale('en'),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'language_change'.tr(),
                style: TextStyle(
                  color: AppColors.primaryPink,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(width: 1.w),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryPink,
                size: 16.sp,
              ),
            ]

        ),
      ),
    );
  }
}