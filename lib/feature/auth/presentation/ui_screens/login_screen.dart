import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utiles/widgets/custom_button.dart';
import 'package:todo_march26/core/utiles/widgets/functions.dart';
import 'package:todo_march26/feature/auth/presentation/components/language_swithcher.dart';
import 'package:todo_march26/feature/auth/presentation/components/custom_auth_text_field.dart';
import 'package:todo_march26/feature/auth/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'package:todo_march26/feature/auth/presentation/ui_screens/send_reset_link_screen.dart';
import 'package:todo_march26/feature/auth/presentation/ui_screens/sign_up_screen.dart';
import 'package:todo_march26/feature/home/presentation/ui_screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';
    return  Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Align(
              alignment: isEnglish
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: LanguageSwitcher(),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Image.asset("assets/images/Sign.png"),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
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
                      return "required_message".tr();
                    }
                  },

                  controller: passwordController,
                  hint: "password".tr(),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendResetLinkScreen()));
                      },
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
                    if(state is AuthLoginFailure){
                      errorDialog(context, state.message);

                    }
                    if(state is AuthLoginSuccess){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen(),), (route) => false,);
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthLoginLoading){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
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
                      title: "signin".tr(),
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
                    SizedBox(width: 0.5.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                              (route) => false,
                        );
                      },
                      child: Text(
                        'sign_up'.tr(),
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