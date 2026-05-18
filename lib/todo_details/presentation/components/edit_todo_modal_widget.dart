import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/home_screen/domain/entites/todo_param.dart';
import 'package:todo_march26/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/home_screen/presentation/components/deadline_widget.dart';
import 'package:todo_march26/home_screen/presentation/components/image_widget.dart';
import 'package:todo_march26/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

class EditTodoModalWidget extends StatefulWidget {
  final TextEditingController titleController;

  final TextEditingController descriptionController;

  final TextEditingController deadlineController;
  final String? image;

  const EditTodoModalWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.deadlineController,
    this.image,
  });

  @override
  State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
}

class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      height: 85.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.roundToDouble()),
        color: AppColors.secondaryPink,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 1.h),
              Container(
                width: 30.w,
                height: 0.7.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.roundToDouble()),
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 1.h),

              CustomTodoTextFormField(
                hint: "Title",
                controller: widget.titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },
              ),
              SizedBox(height: 1.h),
              CustomTodoTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },

                hint: "Description",
                maxLines: 15,
                controller: widget.descriptionController,
              ),
              SizedBox(height: 1.h),
              DeadLineWidget(deadlineController: widget.deadlineController),
              SizedBox(height: 1.h),
              ImagesWidget(
                image: (value) async {
                  if (value != null) {}
                  print(value);
                },
              ),
              SizedBox(height: 1.h),
              if (widget.image != null)
                Stack(
                  children: [
                    Image.network(widget.image!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Icon(Icons.close, color: AppColors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeCreateTodoSuccess) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is HomeCreateTodoLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    );
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // calling create todo
                        print(widget.titleController.text);
                        print(widget.descriptionController.text);
                        print(widget.deadlineController.text);
                      }

                      // first step cubit
                      context.read<HomeCubit>().createTodo(
                        CreateTodoParam(
                          title: widget.titleController.text,
                          description: widget.descriptionController.text,
                          deadline: widget.deadlineController.text,
                        ),
                      );
                    },
                    title: "Add Todo",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.secondaryPink,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
