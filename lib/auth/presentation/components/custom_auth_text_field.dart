import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField({
    super.key,
    required this.controller,
    this.validator,
    required this.hint,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hint;
  final bool? obscureText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool visible;

  @override
  void initState() {
    visible = widget.obscureText!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: visible,

      decoration: InputDecoration(
        hintText: widget.hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey),
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        ),
        suffixIcon: widget.obscureText!
            ? GestureDetector(
          onTap: () {
            visible = !visible;
            setState(() {});
          },
          child: Icon(visible?Icons.visibility_off:Icons.visibility),
        )
            : null,
      ),
    );
  }
}