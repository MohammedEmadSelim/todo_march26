
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';

import 'package:todo_march26/features/home_screen/presentation/components/CreateTodoModalWidget.dart';

import 'package:todo_march26/features/home_screen/presentation/components/fetach_todes.dart';

import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset("assets/images/logo_icon.svg"),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 2.w),
        //     child: GestureDetector(
        //       onTap: () {},
        //       child: SvgPicture.asset("assets/images/Profile.svg"),
        //     ),
        //   ),
        // ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeFetchTodosLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryPink),
            );
          }
          if (state is HomeFetchTodosFailure) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if (state is HomeFetchTodosSuccess) {
            var todos = state.todos;
            return fetach_todes(todos: todos);
          }
          return Text(
            "unknown_error_message".tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.red,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // modal bottom sheet
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: CreateTodoModalWidget(),
            ),
          ).then((value) {
            context.read<HomeCubit>().fetchTodos();
          });
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
