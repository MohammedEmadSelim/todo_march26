

import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/home_screen/presentation/components/image_widget.dart';
import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

class CreateTodoModalWidget extends StatefulWidget {
  @override
  State<CreateTodoModalWidget> createState() => _CreateTodoModalWidgetState();
}

class _CreateTodoModalWidgetState extends State<CreateTodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  Uint8List? imageUnit;
  XFile? image;

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
              SizedBox(height: 2.h),
              Container(
                width: 30.w,
                height: 0.7.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.roundToDouble()),
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 2.h),

              CustomTodoTextFormField(
                hint: "Title".tr(),
                controller: titleController,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },
              ),
              SizedBox(height: 2.h),
              CustomTodoTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },

                hint: "Description".tr(),
                maxLines: 15,
                controller: descriptionController,
              ),
              SizedBox(height: 2.h),
              DeadLineWidget(deadlineController: deadlineController),
              SizedBox(height: 2.h),
              ImagesWidget(
                image: (value) async {
                  if (value != null) {
                    image = value;
                    imageUnit = await value!.readAsBytes();
                    setState(() {});
                  }
                  print(value);
                },
              ),
              SizedBox(height: 2.h),
              if (imageUnit != null)
                Stack(
                  children: [
                    Image.memory(imageUnit!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imageUnit = null;
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
                        print(titleController.text);
                        print(descriptionController.text);
                        print(deadlineController.text);
                        print(imageUnit);
                      }

                      // first step cubit
                      context.read<HomeCubit>().createTodo(
                        CreateTodoParam(
                          title: titleController.text,
                          description: descriptionController.text,
                          deadline: deadlineController.text,
                          image: image,
                        ),
                      );
                    },
                    title: "Add Todo",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.secondaryPink,
                  );
                },
              ),
              SizedBox(height: 1.h),
            
            ],
          ),
        ),
      ),
    );
  }
}
