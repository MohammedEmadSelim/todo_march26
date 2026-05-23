import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home/domain/entity/todo_entity.dart';
import 'package:todo_march26/features/home/domain/entity/todo_param.dart';
import 'package:todo_march26/features/home/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/home/presentation/components/image_widget.dart';
import 'package:todo_march26/features/home/presentation/ui_screen/home_screen.dart';
import 'package:todo_march26/features/todo_details/domain/entity/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/presentation/controller/todo_details_cubit.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key, required this.todo, });
  final TodoEntity todo;

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFF5F2F3);
    final darkText = const Color(0xFF222222);
    final grayText = Colors.grey.shade700;
    final lightGrayText = Colors.grey.shade500;
    final iconColor = Colors.grey.shade800;

    return BlocProvider(
      create: (context) => TodoDetailsCubit(),
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          // Top App Bar
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                    CupertinoIcons.back, color: iconColor),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.clock,
                                  color: iconColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) =>
                                        BlocProvider(
                                          create: (context) => TodoDetailsCubit(),
                                          child: EditTodoModalWidget(oldTitle: todo.title,oldDescription: todo.desc,oldDeadline: todo.deadline,),
                                        ),
                                  ).then((value) {
                                    context.read<TodoDetailsCubit>();
                                  },);
                                },
                                icon: Icon(
                                  CupertinoIcons.pencil,
                                  color: iconColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.delete,
                                  color: iconColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                          // Main Content
                          Text(
                            todo.title,
                            style: GoogleFonts.poppins(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: darkText,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            todo.desc,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.normal,
                              color: grayText,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 48),
                          // Checklist Section

                          const Spacer(),
                          const SizedBox(height: 32),
                          // Bottom Section
                          Center(
                            child: Text(
                              "Finished at : ${todo.deadline}",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: lightGrayText,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}



class EditTodoModalWidget extends StatefulWidget {
  const EditTodoModalWidget({super.key, required this.oldTitle, required this.oldDescription, required this.oldDeadline,});
  final String oldTitle;
  final String oldDescription;
  final String oldDeadline;

  @override
  State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();

}
class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  Uint8List? imageUnit;
  XFile? image;
@override
  void initState() {
    super.initState();
    titleController.text = widget.oldTitle;
    descriptionController.text = widget.oldDescription;
    deadlineController.text = widget.oldDeadline;

  }
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
                controller: titleController,
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
                controller: descriptionController,
              ),
              SizedBox(height: 1.h),
              DeadLineWidget(deadlineController: deadlineController),
              SizedBox(height: 1.h),
              ImagesWidget(
                image: (value) async {
                  if (value != null) {
                    image = value;
                    imageUnit = await value.readAsBytes();
                    setState(() {});
                  }
                },
              ),
              SizedBox(height: 1.h),
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

              BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
                listener: (context, state) {
                  if(state is TodoDetailsSuccess)
                  {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if(state is TodoDetailsLoading){
                    return Center(child: CircularProgressIndicator(color: AppColors.white,),);
                  }
                  return CustomButton(
                    onTap: () {
                      formKey.currentState!.validate();

                      // // first step cubit
                      context.read<TodoDetailsCubit>().editTodo(EditTodoParam(title: titleController.text, des: descriptionController.text, deadline: deadlineController.text));
                      // setState(() {});
                      Navigator.pop(context);
                      },
                    title: "Edit Todo",
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