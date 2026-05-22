import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
// لو هتفعل تسجيل الخروج الحقيقي من فايربيس، شيل الكومنت عن السطر ده:
// import 'package:firebase_auth/firebase_auth.dart'; 

import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

import 'package:todo_march26/features/home_screen/presentation/components/CreateTodoModalWidget.dart';
import 'package:todo_march26/features/home_screen/presentation/components/fetach_todes.dart';
import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:todo_march26/features/auth/presentation/ui_screen/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // 📌 دالة إظهار رسالة التأكيد (Dialog) بتصميم احترافي
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: AppColors.white,
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.logout_rounded, color: AppColors.primaryPink),
              ),
              SizedBox(width: 3.w),
              Text(
                "Log Out".tr(),
                style: TextStyle(
                  color: AppColors.primaryPink,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          content: Text(
            "Are you sure you want to log out?".tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 2.h, right: 4.w, left: 4.w),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: Text(
                "Cancel".tr(),
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPink,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              ),
              onPressed: () async {
                // await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(
                "Yes, Log out".tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0,
        centerTitle: true, 
        
        // 📌 1. الجزء الأيسر: زر تغيير اللغة (أخد مساحة ومحاذاة مظبوطة)
        leadingWidth: 25.w, 
        leading: Padding(
          padding: EdgeInsets.only(left: 4.w), // مسافة من الشمال قد اليمين بالظبط
          child: Center( // عشان الزرار يتوسطن بالطول
            child: PopupMenuButton<String>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              offset: const Offset(0, 45),
              color: Colors.white,
              elevation: 4,
              onSelected: (String value) {
                context.setLocale(Locale(value));
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: "en",
                  child: Row(
                    children: [
                      Text("🇺🇸", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 3.w),
                      const Text("English", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  value: "ar",
                  child: Row(
                    children: [
                      Text("🇪🇬", style: TextStyle(fontSize: 16.sp)),
                      SizedBox(width: 3.w),
                      const Text("العربية", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.language, color: AppColors.primaryPink, size: 14.sp),
                    SizedBox(width: 1.w),
                    Text(
                      context.locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.primaryPink,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // 📌 2. الجزء الأوسط: اللوجو
        title: SvgPicture.asset(
          "assets/images/logo_icon.svg",
          height: 4.5.h, // كبرناه سيكة عشان يملى عينه في النص
        ),

        // 📌 3. الجزء الأيمن: زر تسجيل الخروج
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 4.w), // نفس المساحة اللي على الشمال بالظبط
            child: IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: AppColors.primaryPink,
                size: 22.sp, // كبرناه سيكة عشان يوزن حجم زرار اللغة اللي قصاده
              ),
              onPressed: () {
                _showLogoutDialog(context);
              },
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeFetchTodosLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryPink),
            );
          }
          if (state is HomeFetchTodosFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (state is HomeFetchTodosSuccess) {
            var todos = state.todos;
            return fetach_todes(todos: todos);
          }
          return Text(
            "unknown_error_message".tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // modal bottom sheet
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: CreateTodoModalWidget(),
            ),
          ).then((value) {
            context.read<HomeCubit>().fetchTodos();
          });
        },
        child: Container(
          height: 6.h,
          width: 6.h,
          decoration: BoxDecoration(
            color: AppColors.primaryPink,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryPink.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:sizer/sizer.dart';
// import 'package:todo_march26/core/theme/app_colors.dart';

// import 'package:todo_march26/features/home_screen/presentation/components/CreateTodoModalWidget.dart';

// import 'package:todo_march26/features/home_screen/presentation/components/fetach_todes.dart';

// import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: SvgPicture.asset("assets/images/logo_icon.svg"),
//         // actions: [
//         //   Padding(
//         //     padding: EdgeInsets.symmetric(horizontal: 2.w),
//         //     child: GestureDetector(
//         //       onTap: () {},
//         //       child: SvgPicture.asset("assets/images/Profile.svg"),
//         //     ),
//         //   ),
//         // ],
//       ),
//       body: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           if (state is HomeFetchTodosLoading) {
//             return Center(
//               child: CircularProgressIndicator(color: AppColors.primaryPink),
//             );
//           }
//           if (state is HomeFetchTodosFailure) {
//             return Center(
//               child: Text(
//                 state.message,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: AppColors.red,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             );
//           }
//           if (state is HomeFetchTodosSuccess) {
//             var todos = state.todos;
//             return fetach_todes(todos: todos);
//           }
//           return Text(
//             "unknown_error_message".tr(),
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: AppColors.red,
//               fontWeight: FontWeight.w500,
//             ),
//           );
//         },
//       ),
//       floatingActionButton: GestureDetector(
//         onTap: () {
//           // modal bottom sheet
//           showModalBottomSheet(
//             isScrollControlled: true,
//             context: context,
//             builder: (context) => BlocProvider(
//               create: (context) => HomeCubit(),
//               child: CreateTodoModalWidget(),
//             ),
//           ).then((value) {
//             context.read<HomeCubit>().fetchTodos();
//           });
//         },
//         child: Container(
//           height: 6.h,
//           width: 6.h,
//           decoration: BoxDecoration(
//             color: AppColors.primaryPink,
//             shape: BoxShape.circle,
//           ),
//           child: Icon(Icons.add, color: AppColors.white),
//         ),
//       ),
//     );
//   }
// }
