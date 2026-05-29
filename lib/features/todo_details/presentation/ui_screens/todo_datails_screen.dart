import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/todo_details/presentation/components/delete_modal_widget.dart';
import 'package:todo_march26/features/todo_details/presentation/components/modal_widget_with_data.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit.dart';

import '../../../home_screen/domain/entites/todo_entity.dart';
import '../components/delete_modal_widget.dart';
import '../components/modal_widget_with_data.dart';
import '../controllers/details_cubit.dart';

class TodoDetailsScreen extends StatefulWidget {
  const TodoDetailsScreen({super.key, required this.todo});

  final TodoEntity todo;

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  late TodoEntity currentTodo;
  @override
  void initState() {
    super.initState();
    currentTodo = widget.todo;
  }
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsCubit(),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                    CupertinoIcons.back, color: AppColors.black),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.clock,
                                  color: AppColors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () async{
                                  final editedTodo = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    builder:(context) => BlocProvider(
                                      create: (context) => DetailsCubit(),
                                      child: ModalWidgetWithData(todo: currentTodo,),
                                    ),);
                                  if (editedTodo != null) {
                                    setState(() {
                                      currentTodo = TodoEntity(
                                        id: currentTodo.id,
                                        title: editedTodo.title,
                                        description: editedTodo.description,
                                        deadline: editedTodo.deadline,
                                        createdAt: currentTodo.createdAt,
                                      );
                                    });
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.pencil,
                                  color: AppColors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  final result = await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    barrierColor: Colors.black.withOpacity(0.45),
                                    context: context,
                                    builder:(context) => BlocProvider(
                                      create: (context) => DetailsCubit(),
                                      child: DeleteModalWidget(todo: currentTodo),
                                    ),);
                                  if (result == true) {
                                    Navigator.pop(context, true); // close details screen and tell Home to refresh
                                  }
                                },
                                icon: Icon(
                                  CupertinoIcons.delete,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3.h),
                          // Main Content
                          Text(
                            currentTodo.title,
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            currentTodo.description,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 7.h),
                          // Checklist Section
                          Text(
                            "deadline-details".tr(
                                namedArgs: {"date": "${currentTodo.deadline}"}
                            ),
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.black,
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const Spacer(),

                          // Bottom Section
                          Center(
                            child: Text(
                              "created_at_message".tr(
                                  namedArgs: {"date": DateFormat('d MMM yyyy').format(currentTodo.createdAt)}
                              ),
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.grey,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}