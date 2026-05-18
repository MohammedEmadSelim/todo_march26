import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/home_screen/presentation/components/custom_todo_text_field.dart';

class DeadLineWidget extends StatelessWidget {
  const DeadLineWidget({super.key, required this.deadlineController});

  final TextEditingController deadlineController;

  @override
  Widget build(BuildContext context) {
    return CustomTodoTextFormField(
      onTap: () async {
        var res = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (res != null) {
          deadlineController.text = DateFormat("EEEE, dd MMM").format(res);
        }
        print(res);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "required_message".tr();
        }
      },
      hint: "Deadline (Optional)",
      controller: deadlineController,
      readOnly: true,
    );
  }
}