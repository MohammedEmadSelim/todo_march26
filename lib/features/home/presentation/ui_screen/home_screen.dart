import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            SizedBox(width: 3.5.w),
            SvgPicture.asset('assets/images/logo_icon.svg'),
          ],
        ),
        actions: [
          SvgPicture.asset('assets/images/Profile.svg'),
          SizedBox(width: 6.w),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 2.h),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoDetailsScreen()),
            );
          },
          child: Card(
            color: AppColors.primaryPink,
            margin: EdgeInsets.symmetric(horizontal: 5.w),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 78.w,
                        child: Text(
                          'Design UI App',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight(600),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.access_time,
                        color: AppColors.white,
                        size: 18.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Make Ui design for the mini project post figma link to the trello using ...',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'Created at 1 Sept 2021',
                    style: TextStyle(color: AppColors.white, fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(height: 2.h),
        itemCount: 5,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Container(
              height: 85.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors.secondaryPink,
                borderRadius: BorderRadius.circular(12.roundToDouble()),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 5.h),
                  child: Column(
                    children: [
                      TodoTextField(title: 'Title'),
                      SizedBox(height: 2.h),
                      TodoTextField(title: 'Description', maxLines: 10),
                      SizedBox(height: 2.h),
                      DeadLineWidget(),
                      SizedBox(height: 2.h),
                      TodoTextField(title: 'Upload Pic', readOnly: true),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: CircleAvatar(
          backgroundColor: AppColors.primaryPink,
          child: Icon(Icons.add, color: AppColors.white),
        ),
      ),
    );
  }
}

class DeadLineWidget extends StatefulWidget {
  const DeadLineWidget({
    super.key,
  });

  @override
  State<DeadLineWidget> createState() => _DeadLineWidgetState();
}

class _DeadLineWidgetState extends State<DeadLineWidget> {
  final TextEditingController deadlineController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TodoTextField(
      controller: deadlineController,
      title: 'Deadline',
      readOnly: true,
      onTap: () async {
        var res = await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if(res != null){
          deadlineController.text = DateFormat("EEEE, dd MMM").format(res);
        }
      },
    );
  }
}

class TodoTextField extends StatelessWidget {
  const TodoTextField({
    super.key,
    this.maxLines = 1,
    this.readOnly = false,
    required this.title,
    this.onTap,
    this.controller,
  });
  final int? maxLines;
  final bool? readOnly;
  final String title;
  final void Function()? onTap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      maxLines: maxLines,
      readOnly: readOnly!,
      style: TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: AppColors.white),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.roundToDouble()),
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.roundToDouble()),
          borderSide: BorderSide(color: AppColors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.roundToDouble()),
          borderSide: BorderSide(color: AppColors.white),
        ),
      ),
    );
  }
}
