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
import 'package:todo_march26/feature/auth/presentation/ui_screens/forget_password_screen.dart';

class VerifyCodeScreen extends StatelessWidget {
   VerifyCodeScreen({super.key});

   GlobalKey<FormState> formKey = GlobalKey<FormState>();
   final codeController = TextEditingController();
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
                SizedBox(height: 13.h),
                CustomTextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required_message".tr();
                    }
                  },
                  controller: codeController,
                  hint: "enter_code".tr(),
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "enter_the_code".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if(state is AuthVerifyResetCodeFailure){
                      errorDialog(context, state.message);

                    }
                    if(state is AuthVerifyResetCodeSuccess){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen(code: extractOobCode(codeController.text),),), (route) => false,);
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthVerifyResetCodeLoading){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          final oobCode = extractOobCode(codeController.text);
                          context.read<AuthCubit>().verifyResetCode(oobCode);
                        }
                      },
                      title: "verify_code".tr(),
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

String extractOobCode(String input) {
  final text = input.trim();

  final uri = Uri.tryParse(text);

  if (uri != null && uri.queryParameters.containsKey('oobCode')) {
    return uri.queryParameters['oobCode'] ?? '';
  }

  return text;
}
