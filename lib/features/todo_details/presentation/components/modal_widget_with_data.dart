import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit.dart';

import '../../../../core/utlies/widgets/custom_button.dart';

class ModalWidgetWithData extends StatefulWidget {
  ModalWidgetWithData({super.key, required this.todo});

  final TodoEntity todo;

  @override
  State<ModalWidgetWithData> createState() => _ModalWidgetWithDataState();
}

class _ModalWidgetWithDataState extends State<ModalWidgetWithData> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.todo.title;
    descriptionController.text = widget.todo.description;
    deadlineController.text = widget.todo.deadline ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

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
              BlocConsumer<DetailsCubit, DetailsState>(
                listener: (context, state) {
                  if(state is DetailsSuccess)
                  {
                    Navigator.pop(
                      context,
                      EditTodoParam(
                        id: widget.todo.id!,
                        title: titleController.text,
                        description: descriptionController.text,
                        deadline: deadlineController.text.isEmpty ? null : deadlineController.text,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if(state is DetailsLoading){
                    return Center(child: CircularProgressIndicator(color: AppColors.white,),);
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {

                        final editedTodo  = EditTodoParam(
                          id: widget.todo.id!,
                          title: titleController.text,
                          description: descriptionController.text,
                          deadline: deadlineController.text.isEmpty ? null : deadlineController.text ,
                        );
                        context.read<DetailsCubit>().EditTodo(editedTodo);
                      }
                    },
                    title: "update-todo".tr(),
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