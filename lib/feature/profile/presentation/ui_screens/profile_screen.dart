import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/feature/auth/presentation/controllers/auth_cubit/auth_cubit.dart';
import 'package:todo_march26/feature/auth/presentation/ui_screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 7.h,),
            Center(child: SvgPicture.asset("assets/images/rafiki.svg")),
            SizedBox(height: 10.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "name".tr(),
                  style: TextStyle(
                    fontSize: 17.sp
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp,),
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "change_email".tr(),
                  style: TextStyle(
                      fontSize: 17.sp
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp,),
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "change_pass".tr(),
                  style: TextStyle(
                      fontSize: 17.sp
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp,),
              ],
            ),
            SizedBox(height: 3.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "change_language".tr(),
                  style: TextStyle(
                      fontSize: 17.sp
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16.sp,),
              ],
            ),
            SizedBox(height: 3.h,),
            GestureDetector(
              onTap: (){
                context.read<AuthCubit>().signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
              },
              child: Text(
                'logout'.tr(),
                style: TextStyle(
                  color: AppColors.primaryPink,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
