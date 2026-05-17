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
import 'package:todo_march26/features/auth/presentation/ui_screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              print('Selected: $value');
              context.setLocale(Locale(value));
            },
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  hint: "full_name".tr(),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
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
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hint: "confirm_password".tr(),
                  obSecure: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                    if (value != passwordController.text) {
                      return "identical_message".tr();
                    }
                    return null;
                  },
                ),

                SizedBox(height: 3.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthRegisterFailure) {
                      errorDialog(context, state.message);
                    }
                    if (state is AuthRegisterSuccess) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthRegisterLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryPink,
                        ),
                      );
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
                      title: "sign_up".tr(),
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "have_account".tr(),
                      style: TextStyle(color: AppColors.grey),
                    ),
                    SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "signIn".tr(),
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
