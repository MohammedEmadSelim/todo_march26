import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

import 'custom_todo_text_field.dart';


class ImagesWidget extends StatefulWidget {
  const ImagesWidget({super.key, required this.image});

  final ValueChanged<XFile?> image;

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomTodoTextFormField(
      onTap: () async {
        var picker = ImagePicker();
        var res = await picker.pickImage(source: ImageSource.gallery);
        widget.image(res);
      },
      hint: "Add Image (Optional)",
      readOnly: true,
    );
  }
}


