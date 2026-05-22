import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/core/utlies/widgets/functions.dart';
import 'package:todo_march26/features/auth/presentation/components/custom_auth_text_field.dart';
import 'package:todo_march26/features/auth/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'package:todo_march26/features/auth/presentation/ui_screen/login_screen.dart';
import 'package:todo_march26/features/home_screen/presentation/ui_screens/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // شفافة عشان الشكل المودرن
        elevation: 0,
        actions: [
          // 📌 زر تغيير اللغة الاحترافي (نفس شكل الـ Login)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryPink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primaryPink.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.language, color: AppColors.primaryPink, size: 16.sp),
                    SizedBox(width: 1.5.w),
                    Text(
                      context.locale.languageCode.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.primaryPink,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryPink, size: 18.sp),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Image.asset("assets/images/logo.png"),
                SizedBox(height: 4.h),

                CustomTextFormField(
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    return null; // 👈 ضفنا دي عشان ميديّش Warning
                  },
                  controller: emailController,
                  hint: "email".tr(),
                ),
                SizedBox(height: 2.h),
                
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    return null;
                  },
                  controller: fullNameController,
                  hint: "full_name".tr(),
                ),
                SizedBox(height: 2.h),

                // Password Field
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    if (value.length < 8) {
                      return "length_message".tr();
                    }
                    return null;
                  },
                  obscureText: true,
                  controller: passwordController,
                  hint: "password".tr(),
                ),
                SizedBox(height: 2.h),

                // Confirm Password Field
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    if (value.length < 8) {
                      return "length_message".tr();
                    }
                    if (value != passwordController.text) {
                      return "identical_message".tr();
                    }
                    return null;
                  },
                  controller: confirmPasswordController,
                  hint: "confirm_password".tr(),
                  obscureText: true,
                ),

                SizedBox(height: 4.h),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegisterFailure) {
                      errorDialog(context, state.message);
                    }
                    if (state is AuthRegisterSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthRegisterLoading) {
                      return Center(
                        child: CircularProgressIndicator(color: AppColors.primaryPink),
                      );
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          // 💡 لو الـ Cubit بيقبل الاسم كمان، ضيفه هنا:
                          // context.read<AuthCubit>().register(emailController.text, passwordController.text, fullNameController.text);
                          context.read<AuthCubit>().register(
                                emailController.text,
                                passwordController.text,
                              );
                        }
                      },
                      title: "signup".tr(), // 👈 خليناها signup بدل sign_in
                    );
                  },
                ),
                SizedBox(height: 2.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // يفضل تخلي الترجمة هنا (هل لديك حساب بالفعل؟)
                      'dont_have_account'.tr(), 
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false,
                        );
                      },
                      child: Text(
                        'sign_in'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryPink,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h), // مسافة فاضية تحت عشان الشاشة تبقى مريحة للعين
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sizer/sizer.dart';

// import 'package:todo_march26/core/theme/app_colors.dart';

// import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
// import 'package:todo_march26/core/utlies/widgets/functions.dart';
// import 'package:todo_march26/features/auth/presentation/components/custom_auth_text_field.dart';
// import 'package:todo_march26/features/auth/presentation/controllers/auth_cubit/auth_cubit.dart';
// import 'package:todo_march26/features/auth/presentation/ui_screen/login_screen.dart';
// import 'package:todo_march26/features/home_screen/presentation/ui_screens/home_screen.dart';


// class SignUpScreen extends StatelessWidget {
//   SignUpScreen({super.key});

//   TextEditingController emailController = TextEditingController();
//   TextEditingController fullNameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           DropdownMenu<String>(
//             label: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Eng",
//                   style: TextStyle(
//                     color: AppColors.primaryPink,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16.sp,
//                   ),
//                 ),
//                 SizedBox(width: 1.w),
//                 Icon(Icons.arrow_forward_ios, color: AppColors.primaryPink),
//               ],
//             ),
//             onSelected: (value) {
//               print(value);
//               if (value != null) {
//                 context.setLocale(Locale(value));
//               }
//             },
//             showTrailingIcon: false,
//             dropdownMenuEntries: [
//               DropdownMenuEntry(value: "en", label: "Eng"),
//               DropdownMenuEntry(value: "ar", label: "عربي"),
//             ],
//             width: 25.w,
//             // ... your other properties
//             inputDecorationTheme: const InputDecorationTheme(
//               filled: false,
//               // Set to true if you want a background color
//               contentPadding: EdgeInsets.zero,
//               // Adjust spacing if needed
//               border: InputBorder.none,
//               // Removes the default border
//               enabledBorder: InputBorder.none,
//               // Removes border when enabled
//               focusedBorder: InputBorder.none, // Removes border when focused
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 2.w),
//         child: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: 10.h),
//                 Image.asset("assets/images/logo.png"),
//                 SizedBox(height: 4.h),
            
//                 CustomTextFormField(
//                   autofillHints: const [AutofillHints.email],
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                   },
//                   controller: emailController,
//                   hint: "email".tr(),
//                 ),
//                 SizedBox(height: 2.h),
//                 CustomTextFormField(
                  
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                   },
            
//                   controller: fullNameController,
//                   hint: "full_name".tr(),
//                 ),
//                 SizedBox(height: 2.h),
//                 // pass
//                   CustomTextFormField(
//                    validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                     if (value.length < 8) {
//                       return "length_message".tr();
//                     }
//                   },
//                   obscureText: true,
//                   controller: passwordController,
//                   hint: "password".tr(),
//                 ),
//                 SizedBox(height: 2.h),
//                 // try pas
//                   CustomTextFormField(
//                  validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "required_message".tr();
//                     }
//                     if (value.length < 8) {
//                       return "length_message".tr();
//                     }
//                     if (value != passwordController.text) {
//                       return "identical_message".tr();
//                     }
//                   },
//                   controller: confirmPasswordController,
//                   hint: "confirm_password".tr(),
//                   obscureText: true,
//                 ),
          
//                 SizedBox(height: 2.h),
            
//                 SizedBox(height: 2.h),
//                 BlocConsumer<AuthCubit, AuthState>(
//                   listener: (context, state) {
//                    if(state is AuthRegisterFailure){
//                      errorDialog(context, state.message);
                     
//                    }
//                    if(state is AuthRegisterSuccess){
//                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
//                    }
//                   },
//                   builder: (context, state) {
//                     if(state is AuthRegisterLoading){
//                       return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
//                     }
//                     return CustomButton(
//                       onTap: () {
//                         if (formKey.currentState!.validate()) {
//                           context.read<AuthCubit>().register(
//                             emailController.text,
//                             passwordController.text,
//                           );
//                         }
//                       },
//                       title: "sign_in".tr(),
//                     );
//                   },
//                 ),
//                 SizedBox(height: 2.h),
            
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'dont_have_account'.tr(),
//                       style: TextStyle(
//                         fontWeight: FontWeight.w400,
//                         color: AppColors.grey,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           MaterialPageRoute(builder: (context) => LoginScreen()),
//                               (route) => false,
//                         );
//                       },
//                       child: Text(
//                         'sign_in'.tr(),
//                         style: TextStyle(
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.primaryPink,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
