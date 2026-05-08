import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';

void errorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Error",
        style: TextStyle(
          color: AppColors.red,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.red,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        CustomButton(
          onTap: () {
            Navigator.pop(context);
          },
          title: "ok",
        ),
      ],
    ),
  );
}