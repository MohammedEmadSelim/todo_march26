// import 'dart:typed_data';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';
// import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/image_widget.dart';
// import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

// class EditTodoModalWidget extends StatefulWidget {
//   final TextEditingController titleController;

//   final TextEditingController descriptionController;

//   final TextEditingController deadlineController;
//   final String? image;

//   const EditTodoModalWidget({
//     super.key,
//     required this.titleController,
//     required this.descriptionController,
//     required this.deadlineController,
//     this.image,
//   });

//   @override
//   State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
// }

// class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 2.w),
//       height: 85.h,
//       width: 100.w,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.roundToDouble()),
//         color: AppColors.secondaryPink,
//       ),
//       child: SingleChildScrollView(
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               SizedBox(height: 1.h),
//               Container(
//                 width: 30.w,
//                 height: 0.7.h,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(14.roundToDouble()),
//                   color: AppColors.white,
//                 ),
//               ),
//               SizedBox(height: 1.h),

//               CustomTodoTextFormField(
//                 hint: "Title",
//                 controller: widget.titleController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "required_message".tr();
//                   }
//                 },
//               ),
//               SizedBox(height: 1.h),
//               CustomTodoTextFormField(
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "required_message".tr();
//                   }
//                 },

//                 hint: "Description",
//                 maxLines: 15,
//                 controller: widget.descriptionController,
//               ),
//               SizedBox(height: 1.h),
//               DeadLineWidget(deadlineController: widget.deadlineController),
//               SizedBox(height: 1.h),
//               ImagesWidget(
//                 image: (value) async {
//                   if (value != null) {}
//                   print(value);
//                 },
//               ),
//               SizedBox(height: 1.h),
//               if (widget.image != null)
//                 Stack(
//                   children: [
//                     Image.network(widget.image!),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {});
//                           },
//                           child: Container(
//                             margin: EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: AppColors.white,
//                             ),
//                             child: Icon(Icons.close, color: AppColors.grey),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//               BlocConsumer<HomeCubit, HomeState>(
//                 listener: (context, state) {
//                   if (state is HomeCreateTodoSuccess) {
//                     Navigator.pop(context);
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is HomeCreateTodoLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(color: AppColors.white),
//                     );
//                   }
//                   return CustomButton(
//                     onTap: () {
//                       if (formKey.currentState!.validate()) {
//                         // calling create todo
//                         print(widget.titleController.text);
//                         print(widget.descriptionController.text);
//                         print(widget.deadlineController.text);
//                       }

//                       // first step cubit
//                       context.read<HomeCubit>().createTodo(
//                         CreateTodoParam(
//                           title: widget.titleController.text,
//                           description: widget.descriptionController.text,
//                           deadline: widget.deadlineController.text,
//                         ),
//                       );
//                     },
//                     title: "Add Todo",
//                     backgroundColor: AppColors.white,
//                     textColor: AppColors.secondaryPink,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
// تأكد من مسار الـ TodoEntity عندك
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/home_screen/presentation/components/image_widget.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';

class EditTodoModalWidget extends StatefulWidget {
  // 1. المودال هيستقبل الـ Todo بالكامل من برا
  final TodoEntity todo;

  const EditTodoModalWidget({
    super.key,
    required this.todo,
  });

  @override
  State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
}

class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 2. عرفنا الـ Controllers هنا جوه الـ State
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController deadlineController;

  @override
  void initState() {
    super.initState();
    // 3. بنملا الحقول بالبيانات القديمة عشان تظهر للمستخدم وهو بيعدل
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.des);
    deadlineController = TextEditingController(text: widget.todo.deadline);
  }

  @override
  void dispose() {
    // مهم جداً نقفلهم عشان الـ Memory Leak
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
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
                  return null;
                },
              ),
              SizedBox(height: 1.h),
              CustomTodoTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                  return null;
                },
                hint: "Description",
                maxLines: 15,
                controller: descriptionController,
              ),
              SizedBox(height: 1.h),
              DeadLineWidget(deadlineController: deadlineController),
              SizedBox(height: 1.h),

              // 4. استبدلنا الـ HomeCubit بـ TodoDetailsCubit
              BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
listener: (context, state) {
  if (state is TodoDetailsEditSuccess) {
    // 👈 هنا بنقفل المودال بس، ونبعت true لصفحة التفاصيل
    Navigator.pop(context, true); 
  }
  if (state is TodoDetailsFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  }
},
                builder: (context, state) {
                  if (state is TodoDetailsLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    );
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // 5. بنادي دالة editTodo وبنبعت البيانات الجديدة والـ ID القديم
                        context.read<TodoDetailsCubit>().editTodo(
                          EditTodoParam(
                            id: widget.todo.id, // ID العنصر القديم
                            title: titleController.text, // العنوان بعد التعديل
                            des: descriptionController.text, // الوصف بعد التعديل
                            deadline: deadlineController.text, // الوقت بعد التعديل
                          ),
                        );
                      }
                    },
                    title: "Save Edit", // غيرنا الاسم
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
