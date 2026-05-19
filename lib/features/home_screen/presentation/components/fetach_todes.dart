
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/presentation/components/custom_tode.dart';

class fetach_todes extends StatelessWidget {
  const fetach_todes({
    super.key,
    required this.todos,
  });

  final List<TodoEntity> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 1.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
      itemCount: todos.length,
      itemBuilder: (context, index) => CustomTodoCard(todos: todos,index: index,),
    );
  }
}

