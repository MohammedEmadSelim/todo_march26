// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
// import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';
// import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_details_screen.dart';

// class custom_tode extends StatelessWidget {
//   const custom_tode({
//     super.key,
//     required this.todos, required this.index,
//   });

//   final List<TodoEntity> todos;
// final int index;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 TodoDetailsScreen(todo: todos[index]),
//           ),
//         ).then((value) {
//           // السطر ده معناه: لو رجعنا من صفحة التفاصيل بقيمة true (يعني تم حذف أو تعديل)
//           if (value == true) {
//             // نادي على دالة جلب البيانات عشان تحدث الشاشة
//             context.read<HomeCubit>().fetchTodos();
//           }
//         });
//       },
//       // onTap: () {
//       //   Navigator.push(context,
//       //   MaterialPageRoute(builder: (context) => TodoDetailsScreen(todo: todos[index],),));
//       // },
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
//         height: 20.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.roundToDouble()),
//           color: AppColors.primaryPink,
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Flexible(
//                   child: Text(
//                     todos[index].title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15.sp,
//                       color: AppColors.white,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Icon(Icons.access_time, color: AppColors.white),
//               ],
//             ),
//             SizedBox(height: 1.h),
//             Expanded(
//               child: Text(
//                 todos[index].des,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 13.sp,
//                   color: AppColors.white,
//                 ),
//                 maxLines: 7,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   "deadline_message".tr(
//                     namedArgs: {"date": "${todos[index].deadline}"},
//                   ),
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 12.sp,
//                     color: AppColors.white,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
// import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';
// import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_details_screen.dart';

// class CustomTodoCard extends StatelessWidget { // 👈 عدلت اسم الكلاس ليكون متوافق مع معايير دارت (PascalCase)
//   const CustomTodoCard({
//     super.key,
//     required this.todos,
//     required this.index,
//   });

//   final List<TodoEntity> todos;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TodoDetailsScreen(todo: todos[index]),
//           ),
//         ).then((value) {
//           if (value == true) {
//             context.read<HomeCubit>().fetchTodos();
//           }
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.only(bottom: 2.h), // مسافة بين الكروت
//         padding: EdgeInsets.all(4.w),
//         // height: 20.h, // 👈 شيلت الارتفاع الثابت عشان الكارت يتمدد حسب محتوى الـ Description
//         decoration: BoxDecoration(
//           color: AppColors.primaryPink,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: AppColors.primaryPink.withOpacity(0.3), // ضل خفيف بنفس لون الكارت
//               blurRadius: 10,
//               spreadRadius: 2,
//               offset: const Offset(0, 4), // نزلنا الضل لتحت شوية
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start, // عشان الكلام يبدأ من الشمال (أو اليمين حسب اللغة)
//           children: [
//             // 📌 الجزء الأول: العنوان وأيقونة الإنجاز
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     todos[index].title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold, // العنوان بقى Bold
//                       fontSize: 16.sp,
//                       color: AppColors.white,
//                       letterSpacing: 0.5,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: BoxDecoration(
//                     color: AppColors.white.withOpacity(0.2), // خلفية شفافة للأيقونة
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     CupertinoIcons.doc_text, // أيقونة أروق شوية من الـ Time هنا
//                     color: Colors.white,
//                     size: 18,
//                   ),
//                 ),
//               ],
//             ),
            
//             SizedBox(height: 1.5.h),
            
//             // 📌 الجزء الثاني: الوصف
//             Text(
//               todos[index].des,
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 12.sp,
//                 color: AppColors.white.withOpacity(0.9), // خلينا الوصف شفاف سيكة عشان يدي تباين مع العنوان
//                 height: 1.4, // مسافة بين السطور
//               ),
//               maxLines: 3, // قللنا السطور عشان شكل الكارت ميبقاش طويل بزيادة
//               overflow: TextOverflow.ellipsis,
//             ),
            
//             SizedBox(height: 2.h),
            
//             // 📌 الجزء الثالث: الوقت والتاريخ (شكل Tag)
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
//               decoration: BoxDecoration(
//                 color: AppColors.white.withOpacity(0.15), // كأنه Tag زجاجي
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min, // عشان الـ Container ياخد مساحة الكلام بس
//                 children: [
//                   const Icon(
//                     CupertinoIcons.clock,
//                     color: Colors.white,
//                     size: 16,
//                   ),
//                   SizedBox(width: 2.w),
//                   Text(
//                     "deadline_message".tr(
//                       namedArgs: {"date": "${todos[index].deadline}"},
//                     ),
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 10.sp,
//                       color: AppColors.white,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_details_screen.dart';

class CustomTodoCard extends StatelessWidget {
  const CustomTodoCard({
    super.key,
    required this.todos,
    required this.index,
  });

  final List<TodoEntity> todos;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailsScreen(todo: todos[index]),
          ),
        ).then((value) {
          if (value == true) {
            context.read<HomeCubit>().fetchTodos();
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.5.h),
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: AppColors.primaryPink,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryPink.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 الجزء الأول: العنوان وأيقونة الإنجاز
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    todos[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp, 
                      color: AppColors.white,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.doc_text,
                    color: Colors.white,
                    size: 24, 
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 1.5.h),
            
            // 📌 الجزء الثاني: الوصف
            Text(
              todos[index].des,
              style: TextStyle(
                fontWeight: FontWeight.w500, 
                fontSize: 14.sp, 
                color: AppColors.white.withOpacity(0.95),
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            
            SizedBox(height: 2.5.h), 
            
            // 📌 الجزء الثالث: الوقت والتاريخ (الشكل الجديد البارز)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.2.h), // 👈 كبرنا مساحة البادج
              decoration: BoxDecoration(
                color: AppColors.white, // 👈 خلفية بيضاء سادة عشان تنطق
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08), // 👈 ضل خفيف جداً للبادج نفسه
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.clock_fill, // 👈 استخدمنا الأيقونة المليانة عشان تكون أوضح
                    color: AppColors.primaryPink, // 👈 لون الأيقونة بينك
                    size: 20, // 👈 كبرنا الأيقونة
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    "deadline_message".tr(
                      namedArgs: {"date": "${todos[index].deadline}"},
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.w800, // 👈 خط عريض جداً (Extra Bold)
                      fontSize: 14.sp, // 👈 كبرنا الخط
                      color: AppColors.primaryPink, // 👈 لون النص بينك
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}