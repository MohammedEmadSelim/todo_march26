import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';

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
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "required_message".tr();
        }
      },
      hint: "Deadline (Optional)".tr(),
      controller: deadlineController,
      readOnly: true,
    );
  }
}