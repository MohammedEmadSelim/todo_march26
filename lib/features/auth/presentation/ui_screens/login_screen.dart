import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/core/utlies/widgets/functions.dart';
import 'package:todo_march26/features/auth/presentation/components/widgets/custom_text_form_field.dart';
import 'package:todo_march26/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:todo_march26/features/auth/presentation/ui_screens/sign_up_screen.dart';
import 'package:todo_march26/features/home/presentation/ui_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+\-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            borderRadius: BorderRadius.circular(16.roundToDouble()),
            menuPadding: EdgeInsets.all(0),
            child: Row(
              children: [
                Text(
                  context.locale.languageCode.toString() == 'en'
                      ? 'En'
                      : 'العربية',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.primaryPink,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.sp,
                  color: AppColors.primaryPink,
                ),
              ],
            ),
            itemBuilder: (context) => [
              CheckedPopupMenuItem(
                child: Text(
                  'English',

                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.primaryPink,
                  ),
                ),
              ),
              CheckedPopupMenuItem(
                child: Text(
                  'العربية',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.primaryPink,
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              context.setLocale(Locale(value));
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 12.h),
                SvgPicture.asset('assets/images/login.svg'),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  hint: 'email'.tr(),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    if (!emailRegex.hasMatch(value)) {
                      return "valid_message".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                CustomTextFormField(
                  hint: 'password'.tr(),
                  obSecure: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'forget_password'.tr(),
                      style: TextStyle(color: AppColors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoginSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
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
                      title: 'sign_in'.tr(),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "don't_have_account".tr(),
                      style: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "signup".tr(),
                        style: TextStyle(
                          color: AppColors.primaryPink,
                          fontWeight: FontWeight(500),
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
