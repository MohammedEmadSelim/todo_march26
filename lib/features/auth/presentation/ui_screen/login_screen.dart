import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/core/utlies/widgets/functions.dart';
import 'package:todo_march26/features/auth/presentation/components/custom_auth_text_field.dart';
import 'package:todo_march26/features/auth/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'package:todo_march26/features/auth/presentation/ui_screen/sign_up_screen.dart';
import 'package:todo_march26/home_screen/presentation/ui_screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            // 1. The custom trigger that stays visible on the screen
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.locale.languageCode.toString() == "en"
                      ? "En"
                      : "العربيه",
                  style: TextStyle(
                    color: AppColors.primaryPink,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(width: 1.w),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryPink,
                  size: 17.sp,
                ),
              ],
            ),

            // 2. What happens when an item is clicked
            onSelected: (String value) {
              print("Selected: $value");
              context.setLocale(Locale(value));
            },

            // 3. The list of options in the menu
            itemBuilder: (BuildContext context) =>
            [
              const PopupMenuItem<String>(value: "en", child: Text("English")),
              const PopupMenuItem<String>(value: "ar", child: Text("العربية")),
            ],
          ),
          //           DropdownMenu<String>(
          //
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
          // SizedBox(width: 1.w,),
          //                 Icon(
          //                   Icons.arrow_forward_ios,
          //                   color: AppColors.primaryPink,
          //                 ),
          //
          //               ],
          //             ),
          //             onSelected: (value) {
          //               print(value);
          //               if (value != null) {
          //                 context.setLocale(Locale(value));
          //               }
          //             },
          //             showTrailingIcon: false,
          //
          //
          //             dropdownMenuEntries: [
          //               DropdownMenuEntry(value: "en", label: "Eng"),
          //               DropdownMenuEntry(value: "ar", label: "هربي"),
          //             ],
          //             width: 25.w,
          //             // ... your other properties
          //             inputDecorationTheme: const InputDecorationTheme(
          //               filled: false, // Set to true if you want a background color
          //               contentPadding: EdgeInsets.zero, // Adjust spacing if needed
          //               border: InputBorder.none,        // Removes the default border
          //               enabledBorder: InputBorder.none, // Removes border when enabled
          //               focusedBorder: InputBorder.none, // Removes border when focused
          //             ),
          //           ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Image.asset("assets/images/logo.png"),
              SizedBox(height: 4.h),

              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field can\'nt be empty";
                  }
                  var reg = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",

                  );

                  if (!reg.hasMatch(value)) {
                    return "valid_message".tr();
                  }
                },
                controller: emailController,
                hint: "email".tr(),
              ),
              SizedBox(height: 2.h),
              CustomTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "this field can\'nt be empty";
                  }
                },
                obscureText: true,
                controller: passwordController,
                hint: "password".tr(),
              ),
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "forget_password".tr(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthLoginSuccess) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          HomeScreen()),
                          (route) => false,
                    );
                  }
                  if (state is AuthLoginFailure) {
                    errorDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoginLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
                    },
                    child: Text(
                      'signup'.tr(),
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
    );
  }


}
