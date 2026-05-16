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
import 'package:todo_march26/feature/auth/presentation/ui_screens/verify_code_screen.dart';

class SendResetLinkScreen extends StatelessWidget {
   SendResetLinkScreen({super.key});

   TextEditingController emailController = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "reset_password_link".tr(),
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
                    if(state is AuthSendResetEmailFailure){
                      errorDialog(context, state.message);

                    }
                    if(state is AuthSendResetEmailSuccess){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Reset email sent successfully"),
                        ),
                      );
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(),), (route) => false,);
                    }
                  },
                  builder: (context, state) {
                    if(state is AuthSendResetEmailLoading){
                      return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
                    }
                    return CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().sendResetEmail(emailController.text);
                        }
                      },
                      title: "send_reset_password_link".tr(),
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
