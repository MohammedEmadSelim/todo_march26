import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_todo_text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SvgPicture.asset("assets/images/logo_icon.svg"),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset("assets/images/Profile.svg"),
            ),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 1.h),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        itemCount: 2,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          height: 20.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.roundToDouble()),
            color: AppColors.primaryPink,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      "Design UI App",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.access_time, color: AppColors.white),
                ],
              ),
              SizedBox(height: 1.h),
              Expanded(
                child: Text(
                  "Make Ui design for the mini project post figma link to the trello using  ...",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp,
                    color: AppColors.white,
                  ),
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Created at 1 Sept 2021",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                      color: AppColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // modal bottom sheet
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              height: 85.h,
              width: 100.w,
              decoration: BoxDecoration(color: AppColors.secondaryPink),
              child: Column(
                children: [
                  SizedBox(height: 1.h),
                  Container(
                    width: 30.w,
                    height: 0.7.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.roundToDouble()),
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 1.h),

                  CustomTodoTextFormField(hint: "Title"),
                  SizedBox(height: 1.h),
                  CustomTodoTextFormField(hint: "Description", maxLines: 15),
                  SizedBox(height: 1.h),
                  CustomTodoTextFormField(
                    hint: "Deadline (Optional)",
                    readOnly: true,
                  ),
                  SizedBox(height: 1.h),
                  CustomTodoTextFormField(
                    hint: "Add Image (Optional)",
                    readOnly: true,
                  ),
                  SizedBox(height: 1.h),

                  CustomButton(
                    onTap: () {},
                    title: "Add Todo",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.secondaryPink,
                  ),
                ],
              ),
            ),
          );
        },
        child: Container(
          height: 6.h,
          width: 6.h,
          decoration: BoxDecoration(
            color: AppColors.primaryPink,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}
