import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/features/home_screen/presentation/components/todo_modal_widget.dart';
import 'package:todo_march26/features/home_screen/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:todo_march26/features/profile/presentation/ui_screens/profile_screen.dart';
import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_datails_screen.dart';

import '../components/todo_modal_widget.dart';
import '../controllers/home_cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SvgPicture.asset("assets/images/logo_icon.svg"),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
              },
              child: SvgPicture.asset("assets/images/Vector.svg"),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit,HomeState>(
        builder: (context, state){
          if(state is HomeFetchTodoLoading){
            return Center(child: CircularProgressIndicator(color: AppColors.primaryPink,),);
          }
          if(state is HomeFetchTodoFailure){
            return Center(
              child: Text(
                state.message,
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }
          if(state is HomeFetchTodoSuccess){
            var todos =state.todos;
            return todos.isNotEmpty ? ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              itemCount: todos.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () async{
                    await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TodoDetailsScreen(todo: todos[index])),
                    );
                    context.read<HomeCubit>().fetchTodos();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.h,horizontal: 4.w),
                    height: 17.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.primaryPink,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                todos[index].title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                  color: AppColors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(Icons.access_time, color: AppColors.white, size: 18.sp,),
                          ],),
                        SizedBox(height: 1.h),
                        Expanded(
                          child: Text(
                            todos[index].description,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 16.sp,
                              color: AppColors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "created_at_message".tr(
                                namedArgs: {"date": DateFormat('d MMM yyyy').format(todos[index].createdAt)},
                              ),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },

            ) : Center(child: Text(
              "no_todos_to_show".tr(),
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryPink,
              ),
            ),);
          }
          return Center(
            child: Text(
              "unknown_error_message".tr(),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => BlocProvider(
              create: (context) => HomeCubit(),
              child: TodoModalWidget(),
            ),
          ).then((value){
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