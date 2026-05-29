import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/todo_details/domain/entities/delete_todo_param.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit.dart';

import '../../../../core/utlies/widgets/custom_button.dart';
import '../../../home_screen/domain/entites/todo_entity.dart';
import '../../domain/entities/delete_todo_param.dart';
import '../controllers/details_cubit.dart';

class DeleteModalWidget extends StatelessWidget {
  DeleteModalWidget({super.key, required this.todo});

  final TodoEntity todo;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      height: 18.h,
      width: 100.w,
      child: Column(
        children: [
          SizedBox(height: 3.h),
          BlocConsumer<DetailsCubit, DetailsState>(
            listener: (context, state) {
              if(state is DetailsDeleteSuccess)
              {
                //Navigator.pop(context, true);
              }
            },
            builder: (context, state) {
              if(state is DetailsDeleteLoading){
                return Center(child: CircularProgressIndicator(color: AppColors.white,),);
              }
              return CustomButton(
                onTap: () {
                  context.read<DetailsCubit>().DeleteTodo(DeleteTodoParam(id: todo.id!));
                  Navigator.pop(context, true);
                },
                title: "delete-todo".tr(),
                backgroundColor: AppColors.white,
                textColor: AppColors.secondaryPink,
              );
            },
          ),
          SizedBox(height: 1.h),
          CustomButton(
            onTap: () {
              Navigator.pop(context);
            },
            title: "cancel".tr(),
            backgroundColor: AppColors.white,
            textColor: Colors.green,
          ),
        ],
      ),
    );
  }
}