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

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownMenu<String>(
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Eng",
                  style: TextStyle(
                    color: AppColors.primaryPink,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 1.w),
                Icon(Icons.arrow_forward_ios, color: AppColors.primaryPink),
              ],
            ),
            onSelected: (value) {
              print(value);
              if (value != null) {
                context.setLocale(Locale(value));
              }
            },
            showTrailingIcon: false,
            dropdownMenuEntries: [
              DropdownMenuEntry(value: "en", label: "Eng"),
              DropdownMenuEntry(value: "ar", label: "عربي"),
            ],
            width: 25.w,
            // ... your other properties
            inputDecorationTheme: const InputDecorationTheme(
              filled: false,
              // Set to true if you want a background color
              contentPadding: EdgeInsets.zero,
              // Adjust spacing if needed
              border: InputBorder.none,
              // Removes the default border
              enabledBorder: InputBorder.none,
              // Removes border when enabled
              focusedBorder: InputBorder.none, // Removes border when focused
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
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
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
                  },
            
                  controller: fullNameController,
                  hint: "full_name".tr(),
                ),
                SizedBox(height: 2.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    if (value.length < 8) {
                      return "length_message".tr();
                    }
                  },
            
                  controller: passwordController,
                  hint: "password".tr(),
                ),
                SizedBox(height: 2.h),
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
                  },
                  controller: confirmPasswordController,
                  hint: "confirm_password".tr(),
                ),
                SizedBox(height: 2.h),
            
                SizedBox(height: 2.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                   if(state is AuthRegisterFailure){
                     errorDialog(context, state.message);
                     
                   }
                   if(state is AuthRegisterSuccess){
                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
                   }
                  },
                  builder: (context, state) {
                    if(state is AuthRegisterLoading){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      title: "sign_in".tr(),
                    );
                  },
                ),
                SizedBox(height: 2.h),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont_have_account'.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey,
                      ),
                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
