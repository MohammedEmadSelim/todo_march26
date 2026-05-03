import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/auth/presentation/components/custom_auth_text_field.dart';
import 'package:todo_march26/features/auth/presentation/ui_screen/login_screen.dart';
import 'package:todo_march26/features/auth/presentation/ui_screen/sign_up_screen.dart';

class SignUpScreen extends StatelessWidget {
 SignUpScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                SizedBox(width: 1.w,),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryPink,
                ),

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
              DropdownMenuEntry(value: "ar", label: "هربي"),
            ],
            width: 25.w,
            // ... your other properties
            inputDecorationTheme: const InputDecorationTheme(
              filled: false, // Set to true if you want a background color
              contentPadding: EdgeInsets.zero, // Adjust spacing if needed
              border: InputBorder.none,        // Removes the default border
              enabledBorder: InputBorder.none, // Removes border when enabled
              focusedBorder: InputBorder.none, // Removes border when focused
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Image.asset("assets/images/logo.png"),
            SizedBox(height: 4.h),

            CustomTextFormField(
              controller:emailController ,
              hint: "email".tr(),
            ),
            SizedBox(height: 2.h),
            CustomTextFormField(
              controller: fullNameController,
              hint: "full_name".tr(),
            ), SizedBox(height: 2.h),
            CustomTextFormField(
              controller: passwordController,
              hint: "password".tr(),
            ), SizedBox(height: 2.h),
            CustomTextFormField(
              controller: confirmPasswordController,
              hint: "confirm_password".tr(),
            ),
            SizedBox(height: 2.h),

            SizedBox(height: 2.h),
            CustomButton(onTap: () {}, title: "sign_in".tr()),
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
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),),(route) => false,);
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
    );
  }
}
