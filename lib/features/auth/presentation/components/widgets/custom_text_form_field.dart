import 'package:flutter/material.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    this.obSecure = false,
    required this.controller,
    this.validator,
    this.onChanged,
  });
  final String hint;
  final bool? obSecure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool visible;

  @override
  void initState() {
    visible = widget.obSecure!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      validator: widget.validator,
      // validator: (value) {
      //   if(value == null || value.isEmpty){
      //     return "required_message".tr();
      //   }
      //   if(widget.hint == 'email'&& !emailRegex.hasMatch(value)){
      //     return "valid_message".tr();
      //   }
      //   return null ;
      // },
      obscureText: visible,
      cursorColor: AppColors.primaryPink,
      decoration: InputDecoration(
        hintText: widget.hint,
        suffixIcon: widget.obSecure!
            ? GestureDetector(
                onTap: () {
                  visible = !visible;
                  setState(() {});
                },
                child: Icon(
                  visible
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
        hintStyle: TextStyle(color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.roundToDouble()),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.roundToDouble()),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.roundToDouble()),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.roundToDouble()),
          borderSide: BorderSide(color: AppColors.grey),
        ),
      ),
    );
  }
}
