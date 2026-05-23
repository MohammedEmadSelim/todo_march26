import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

class CustomTodoTextFormField extends StatelessWidget {
  const CustomTodoTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.hint,
    this.maxLines,
    this.readOnly = false, this.onTap,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hint;
  final int? maxLines;
  final bool? readOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      controller: controller,
      validator: validator,
      cursorColor: AppColors.white,
      maxLines: maxLines,
      onTap: onTap,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: !readOnly!?AppColors.white:AppColors.white.withAlpha(140)),

        enabledBorder: !readOnly!
            ? OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.6.w),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white.withAlpha(100),
            width: 0.6.w,
          ),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        ),
        focusedBorder: !readOnly!
            ? OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white, width: 0.6.w),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        )
            : OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white.withAlpha(100),
            width: 0.6.w,
          ),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        ),
      ),
    );
  }
}