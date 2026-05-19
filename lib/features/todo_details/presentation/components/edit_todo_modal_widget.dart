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

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';
// import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
// // تأكد من مسار الـ TodoEntity عندك
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';

// import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
// import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';

// class EditTodoModalWidget extends StatefulWidget {
//   // 1. المودال هيستقبل الـ Todo بالكامل من برا
//   final TodoEntity todo;

//   const EditTodoModalWidget({super.key, required this.todo});

//   @override
//   State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
// }

// class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   // 2. عرفنا الـ Controllers هنا جوه الـ State
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;
//   late TextEditingController deadlineController;

//   @override
//   void initState() {
//     super.initState();
//     // 3. بنملا الحقول بالبيانات القديمة عشان تظهر للمستخدم وهو بيعدل
//     titleController = TextEditingController(text: widget.todo.title);
//     descriptionController = TextEditingController(text: widget.todo.des);
//     deadlineController = TextEditingController(text: widget.todo.deadline);
//   }

//   @override
//   void dispose() {
//     // مهم جداً نقفلهم عشان الـ Memory Leak
//     titleController.dispose();
//     descriptionController.dispose();
//     deadlineController.dispose();
//     super.dispose();
//   }

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
//                 hint: "Title".tr(),
//                 controller: titleController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "required_message".tr();
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 1.h),
//               CustomTodoTextFormField(
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "required_message".tr();
//                   }
//                   return null;
//                 },
//                 hint: "Description".tr(),
//                 maxLines: 15,
//                 controller: descriptionController,
//               ),
//               SizedBox(height: 1.h),
//               DeadLineWidget(deadlineController: deadlineController),
//               SizedBox(height: 1.h),

//               // 4. استبدلنا الـ HomeCubit بـ TodoDetailsCubit
//               BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
//                 listener: (context, state) {
//                   if (state is TodoDetailsEditSuccess) {
//                     // 👈 هنا بنقفل المودال بس، ونبعت true لصفحة التفاصيل
//                     Navigator.pop(context, true);
//                   }
//                   if (state is TodoDetailsFailure) {
//                     ScaffoldMessenger.of(
//                       context,
//                     ).showSnackBar(SnackBar(content: Text(state.message)));
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is TodoDetailsLoading) {
//                     return Center(
//                       child: CircularProgressIndicator(color: AppColors.white),
//                     );
//                   }
//                   return CustomButton(
//                     onTap: () {
//                       if (formKey.currentState!.validate()) {
//                         // 5. بنادي دالة editTodo وبنبعت البيانات الجديدة والـ ID القديم
//                         context.read<TodoDetailsCubit>().editTodo(
//                           EditTodoParam(
//                             id: widget.todo.id, // ID العنصر القديم
//                             title: titleController.text, // العنوان بعد التعديل
//                             des:
//                                 descriptionController.text, // الوصف بعد التعديل
//                             deadline:
//                                 deadlineController.text, // الوقت بعد التعديل
//                           ),
//                         );
//                       }
//                     },
//                     title: "Save Edit".tr(), // غيرنا الاسم
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
// 3
// import 'dart:io';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart'; // تأكد من الـ import ده
// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';
// import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
// // import 'package:todo_march26/features/home_screen/presentation/components/image_widget.dart'; // 👈 ممكن نشيل ده مبقاش ليه لازمة هنا
// import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
// import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';

// class EditTodoModalWidget extends StatefulWidget {
//   // 1. غيرنا الـ Constructor عشان يستقبل الـ Todo entity بالكامل بدل الـ Controllers
//   final TodoEntity todo;

//   const EditTodoModalWidget({super.key, required this.todo});

//   @override
//   State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
// }

// class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   // 2. عرفنا الـ Controllers هنا جوه الـ State
//   late TextEditingController titleController;
//   late TextEditingController descriptionController;
//   late TextEditingController deadlineController;

//   // 3. متغيرات جديدة لحفظ الصورة الجديدة local أو إشارة الحذف
//   XFile? selectedImageFile;
//   bool imageRemoved = false; // لو true، يبقى المستخدم داس على الـ "X"
//   final ImagePicker picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // 4. بنملا الحقول بالبيانات القديمة عشان تظهر للمستخدم وهو بيعدل
//     titleController = TextEditingController(text: widget.todo.title);
//     descriptionController = TextEditingController(text: widget.todo.des);
//     deadlineController = TextEditingController(text: widget.todo.deadline);
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     deadlineController.dispose();
//     super.dispose();
//   }

//   // 5. دالة فتح الاستوديو واختيار صورة
//   Future<void> pickImage() async {
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         selectedImageFile = image; // بنحفظ الصورة الجديدة هنا عشان نعرض معاينة
//         imageRemoved = false; // لو اختار صورة جديدة، بنلغي إشارة الحذف
//       });
//     }
//   }

//   // 6. دالة إزالة الصورة
//   void removeImage() {
//     setState(() {
//       selectedImageFile = null; // بنشيل المعاينة local
//       imageRemoved = true; // بنبعت إشارة للحذف من فايربيس
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 4.w),
//       // height: 85.h, // 👈 شيلنا الارتفاع الثابت عشان يكون ديناميكي حسب المحتوى
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24.roundToDouble()),
//           topRight: Radius.circular(24.roundToDouble()),
//         ),
//         color: AppColors.secondaryPink,
//       ),
//       child: SingleChildScrollView(
//         // عشان الـ keyboard ميبوظش الشكل
//         child: Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
//           ),
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min, // بياخد مساحة المحتوى بس
//               children: [
//                 SizedBox(height: 1.h),
//                 Container(
//                   width: 15.w,
//                   height: 0.5.h,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(14),
//                     color: AppColors.white.withOpacity(0.5),
//                   ),
//                 ),
//                 SizedBox(height: 2.h),

//                 // 7. 📌 👈 الجزء الجديد الخاص بعرض/تعديل الصورة جوه المودال
//                 Container(
//                   height: 20.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.white.withOpacity(0.2), // خلفية شفافة
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: AppColors.white.withOpacity(0.3)),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Stack(
//                       children: [
//                         // 👉 منطق العرض:
//                         // لو المستخدم اختار صورة جديدة locally، اعرضها الأول كـ File
//                         if (selectedImageFile != null)
//                           Image.file(
//                             File(selectedImageFile!.path),
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           )
//                         // لو مفيش جديدة، وكان فيه صورة أصلاً في الـ Todo، ومنداسش على حذف، اعرضها من النت كـ Network
//                         else if (widget.todo.image != null && !imageRemoved)
//                           Image.network(
//                             widget.todo.image!,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           )
//                         // لو مفيش خالص، اعرض أيقونة "إضافة صورة"
//                         else
//                           const Center(
//                             child: Icon(
//                               CupertinoIcons.camera,
//                               color: AppColors.white,
//                               size: 40,
//                             ),
//                           ),

//                         // زرار الـ "X" لإزالة الصورة
//                         if (selectedImageFile != null ||
//                             (widget.todo.image != null && !imageRemoved))
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: GestureDetector(
//                               onTap: removeImage,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.black54,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   CupertinoIcons.xmark,
//                                   color: Colors.white,
//                                   size: 16,
//                                 ),
//                               ),
//                             ),
//                           ),

//                         // زرار القلم لتغيير الصورة
//                         Positioned(
//                           bottom: 8,
//                           right: 8,
//                           child: GestureDetector(
//                             onTap: pickImage,
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(
//                                 color: Colors.black54,
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 CupertinoIcons.pencil,
//                                 color: Colors.white,
//                                 size: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 2.h),

//                 CustomTodoTextFormField(
//                   hint: "Title",
//                   controller: titleController,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 1.h),
//                 CustomTodoTextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                     return null;
//                   },
//                   hint: "Description",
//                   maxLines: 6, // قللنا السطور عشان المودال ميبقاش طويل أوي
//                   controller: descriptionController,
//                 ),
//                 SizedBox(height: 1.h),
//                 DeadLineWidget(deadlineController: deadlineController),
//                 SizedBox(height: 2.h),

//                 // 8. استبدلنا الـ HomeCubit بـ TodoDetailsCubit (المنطق الصح للتعديل)
//                 BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
//                  listener: (context, state) {
//   if (state is TodoDetailsEditSuccess) {
//     // 👈 يقفل المودال ويبعت true
//     Navigator.pop(context, true); 
//   }
//   if (state is TodoDetailsFailure) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
//   }
// },
//                   builder: (context, state) {
//                     if (state is TodoDetailsLoading) {
//                       return Center(
//                         child: CircularProgressIndicator(
//                           color: AppColors.white,
//                         ),
//                       );
//                     }
//                     return CustomButton(
//                       onTap: () {
//                         if (formKey.currentState!.validate()) {
//                           // 9. بنادي دالة editTodo وبنبعت البيانات الجديدة والـ id القديم، والـ selectedImageFile
//                           // (تأكد إن EditTodoParam عندك بيستقبل XFile? image و bool? imageRemoved)
//                           context.read<TodoDetailsCubit>().editTodo(
//                             EditTodoParam(
//                               id: widget.todo.id, // ID العنصر القديم
//                               title:
//                                   titleController.text, // العنوان بعد التعديل
//                               des: descriptionController
//                                   .text, // الوصف بعد التعديل
//                               deadline:
//                                   deadlineController.text, // الوقت بعد التعديل
//                               image:
//                                   selectedImageFile, // الصورة الجديدة (File) لو المستخدم اختارها
//                               imageRemoved:
//                                   imageRemoved, // لو المستخدم داس على الـ "X"
//                             ),
//                           );
//                         }
//                       },
//                       title: "Save Edit",
//                       backgroundColor: AppColors.white,
//                       textColor: AppColors.secondaryPink,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 1.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // تأكد من الـ import ده
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home_screen/presentation/components/deadline_widget.dart';
// import 'package:todo_march26/features/home_screen/presentation/components/image_widget.dart'; // 👈 ممكن نشيل ده مبقاش ليه لازمة هنا
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';

class EditTodoModalWidget extends StatefulWidget {
  // 1. غيرنا الـ Constructor عشان يستقبل الـ Todo entity بالكامل بدل الـ Controllers
  final TodoEntity todo;

  const EditTodoModalWidget({super.key, required this.todo});

  @override
  State<EditTodoModalWidget> createState() => _EditTodoModalWidgetState();
}

class _EditTodoModalWidgetState extends State<EditTodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // 2. عرفنا الـ Controllers هنا جوه الـ State
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController deadlineController;

  // 3. متغيرات جديدة لحفظ الصورة الجديدة local أو إشارة الحذف
  XFile? selectedImageFile;
  bool imageRemoved = false; // لو true، يبقى المستخدم داس على الـ "X"
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // 4. بنملا الحقول بالبيانات القديمة عشان تظهر للمستخدم وهو بيعدل
    titleController = TextEditingController(text: widget.todo.title);
    descriptionController = TextEditingController(text: widget.todo.des);
    deadlineController = TextEditingController(text: widget.todo.deadline);
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    deadlineController.dispose();
    super.dispose();
  }

  // 5. دالة فتح الاستوديو واختيار صورة
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImageFile = image; // بنحفظ الصورة الجديدة هنا عشان نعرض معاينة
        imageRemoved = false; // لو اختار صورة جديدة، بنلغي إشارة الحذف
      });
    }
  }

  // 6. دالة إزالة الصورة
  void removeImage() {
    setState(() {
      selectedImageFile = null; // بنشيل المعاينة local
      imageRemoved = true; // بنبعت إشارة للحذف من فايربيس
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      // height: 85.h, // 👈 شيلنا الارتفاع الثابت عشان يكون ديناميكي حسب المحتوى
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.roundToDouble()),
          topRight: Radius.circular(24.roundToDouble()),
        ),
        color: AppColors.secondaryPink,
      ),
      child: SingleChildScrollView(
        // عشان الـ keyboard ميبوظش الشكل
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min, // بياخد مساحة المحتوى بس
              children: [
                SizedBox(height: 1.h),
                Container(
                  width: 15.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.white.withOpacity(0.5),
                  ),
                ),
                SizedBox(height: 2.h),

                // 7. 📌 الجزء الجديد الخاص بعرض/تعديل الصورة جوه المودال (النسخة المتحدثة)
                GestureDetector(
                  onTap: pickImage, // لما يضغط في أي مكان يفتح الاستوديو
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.15), // خلفية أغمق سيكة عشان تبان
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.white.withOpacity(0.3), width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        alignment: Alignment.center, // عشان نخلي النص والأيقونة في النص
                        children: [
                          // 👉 الحالة الأولى: المستخدم اختار صورة جديدة
                          if (selectedImageFile != null)
                            Image.file(File(selectedImageFile!.path), fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                          
                          // 👉 الحالة التانية: فيه صورة جاية من فايربيس (ومش فاضية) ومنداسش حذف
                          else if (widget.todo.image != null && widget.todo.image!.isNotEmpty && !imageRemoved)
                            Image.network(widget.todo.image!, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                          
                          // 👉 الحالة التالتة: مفيش صورة أصلاً (تصميم الكاميرا)
                          else
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.photo_camera, color: AppColors.white.withOpacity(0.8), size: 40),
                                SizedBox(height: 1.h),
                                Text(
                                  "No image. Tap to add", 
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.8),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          
                          // ❌ زرار الـ "X" لإزالة الصورة (يظهر بس لو فيه صورة أصلاً)
                          if (selectedImageFile != null || (widget.todo.image != null && widget.todo.image!.isNotEmpty && !imageRemoved))
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: removeImage,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                  child: const Icon(CupertinoIcons.xmark, color: Colors.white, size: 16),
                                ),
                              ),
                            ),
                          
                          // ✏️ زرار القلم لتغيير الصورة (يظهر بس لو فيه صورة أصلاً)
                          if (selectedImageFile != null || (widget.todo.image != null && widget.todo.image!.isNotEmpty && !imageRemoved))
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                                child: const Icon(CupertinoIcons.pencil, color: Colors.white, size: 16),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

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
                  maxLines: 6, // قللنا السطور عشان المودال ميبقاش طويل أوي
                  controller: descriptionController,
                ),
                SizedBox(height: 1.h),
                DeadLineWidget(deadlineController: deadlineController),
                SizedBox(height: 2.h),

                // 8. استبدلنا الـ HomeCubit بـ TodoDetailsCubit (المنطق الصح للتعديل)
                BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
                  listener: (context, state) {
                    if (state is TodoDetailsEditSuccess) {
                      // 👈 يقفل المودال ويبعت true لصفحة التفاصيل عشان تقفل وتحدث
                      Navigator.pop(context, true); 
                    }
                    if (state is TodoDetailsFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is TodoDetailsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                        ),
                      );
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // 9. بنادي دالة editTodo وبنبعت البيانات الجديدة والـ id القديم، والـ selectedImageFile
                          context.read<TodoDetailsCubit>().editTodo(
                            EditTodoParam(
                              id: widget.todo.id, // ID العنصر القديم
                              title: titleController.text, // العنوان بعد التعديل
                              des: descriptionController.text, // الوصف بعد التعديل
                              deadline: deadlineController.text, // الوقت بعد التعديل
                              image: selectedImageFile, // الصورة الجديدة (File) لو المستخدم اختارها
                              imageRemoved: imageRemoved, // لو المستخدم داس على الـ "X"
                            ),
                          );
                        }
                      },
                      title: "Save Edit",
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
      ),
    );
  }
}
