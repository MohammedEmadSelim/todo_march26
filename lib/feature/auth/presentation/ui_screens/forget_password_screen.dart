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
import 'package:todo_march26/feature/auth/presentation/ui_screens/login_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key, required this.code});

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String code;

  @override
  Widget build(BuildContext context) {
    final isEnglish = context.locale.languageCode == 'en';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    if (value.length < 8) {
                      return "length_message".tr();
                    }
                  },
                  obscureText: true,
                  controller: passwordController,
                  hint: "password".tr(),
                ),
                SizedBox(height: 2.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }

                    if (value != passwordController.text) {
                      return "identical_message".tr();
                    }
                  },
                  obscureText: true,
                  controller: confirmPasswordController,
                  hint: "confirm_password".tr(),
                ),
                SizedBox(height: 2.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is AuthConfirmPasswordFailure){
                      errorDialog(context, state.message);

                    }
                    if(state is AuthConfirmPasswordSuccess){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthConfirmPasswordLoading){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().confirmNewPassword(
                            code: code,
                            newPassword: passwordController.text,
                          );
                        }
                      },
                      title: "change_password".tr(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
