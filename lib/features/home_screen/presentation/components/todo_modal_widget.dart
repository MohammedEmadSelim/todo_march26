import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

import '../controllers/home_cubit/home_cubit.dart';

class TodoModalWidget extends StatefulWidget {
  const TodoModalWidget({super.key});

  @override
  State<TodoModalWidget> createState() => _TodoModalWidgetState();
}

class _TodoModalWidgetState extends State<TodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 85.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
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
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.white,
                ),
              ),
              SizedBox(height: 2.h),
              CustomTodoTextFormField(
                hint: "title".tr(),
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },
              ),
              SizedBox(height: 2.h),
              CustomTodoTextFormField(
                hint: "description".tr(),
                controller: descriptionController,
                maxLines: 15,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },
              ),
              SizedBox(height: 2.h),
              DeadLineWidget(deadlineController: deadlineController),
              SizedBox(height: 3.h),
              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if (state is HomeCreateTodoSuccess) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is HomeCreateTodoLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    );
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<HomeCubit>().createTodo(
                          CreateTodoParam(
                            title: titleController.text,
                            description: descriptionController.text,
                            deadline: deadlineController.text,
                          ),
                        );
                      }
                    },
                    title: "add-todo".tr(),
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