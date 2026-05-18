// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
// import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';

// class TodoDetailsScreen extends StatelessWidget {
//   const TodoDetailsScreen({super.key, required this.todo});

//   final TodoEntity todo;

//   @override
//   Widget build(BuildContext context) {
//     final bgColor = const Color(0xFFF5F2F3);
//     final darkText = const Color(0xFF222222);
//     final grayText = Colors.grey.shade700;
//     final lightGrayText = Colors.grey.shade500;
//     final iconColor = Colors.grey.shade800;

//     return BlocProvider(
//       create: (context) => TodoDetailsCubit(),
//       child: Scaffold(
//         backgroundColor: bgColor,
//         body: SafeArea(
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               return SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(minHeight: constraints.maxHeight),
//                   child: IntrinsicHeight(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 16),
//                           // Top App Bar
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 icon: Icon(
//                                     CupertinoIcons.back, color: iconColor),
//                                 padding: EdgeInsets.zero,
//                                 alignment: Alignment.centerLeft,
//                               ),
//                               const Spacer(),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   CupertinoIcons.clock,
//                                   color: iconColor,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   // showModalBottomSheet(context: context, builder:(context) => , )
//                                 },
//                                 icon: Icon(
//                                   CupertinoIcons.pencil,
//                                   color: iconColor,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   CupertinoIcons.delete,
//                                   color: iconColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 32),
//                           // Main Content
//                           Text(
//                             todo.title,
//                             style: GoogleFonts.poppins(
//                               fontSize: 36,
//                               fontWeight: FontWeight.bold,
//                               color: darkText,
//                               height: 1.2,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             todo.des,
//                             style: GoogleFonts.poppins(
//                               fontSize: 19,
//                               fontWeight: FontWeight.normal,
//                               color: grayText,
//                               height: 1.5,
//                             ),
//                           ),
//                           const SizedBox(height: 48),
//                           // Checklist Section

//                           const Spacer(),
//                           const SizedBox(height: 32),
//                           // Bottom Section
//                           Center(
//                             child: Text(
//                               "deadline_message".tr(
//                                 namedArgs: {"date": "${todo.deadline}"},
//                               ),
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.normal,
//                                 color: lightGrayText,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 24),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/todo_details/presentation/controllers/details_cubit/todo_details_cubit.dart';
// لا تنسَ عمل import لملف الـ Edit Modal الخاص بك
import 'package:todo_march26/features/todo_details/presentation/components/edit_todo_modal_widget.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key, required this.todo});

  final TodoEntity todo;

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFF5F2F3);
    final darkText = const Color(0xFF222222);
    final grayText = Colors.grey.shade700;
    final lightGrayText = Colors.grey.shade500;
    final iconColor = Colors.grey.shade800;

    return BlocProvider(
      create: (context) => TodoDetailsCubit(),
      // 1. استخدمنا BlocConsumer بدلاً من Scaffold مباشرة لنستمع للحالات
      child: BlocConsumer<TodoDetailsCubit, TodoDetailsState>(
        listener: (context, state) {
  // 👈 خليناها للحذف بس
  if (state is TodoDetailsDeleteSuccess) {
     Navigator.pop(context, true); 
  }
  if (state is TodoDetailsFailure) {
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
  }
},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: bgColor,
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              // Top App Bar
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.pop(context),
                                    icon: Icon(
                                      CupertinoIcons.back,
                                      color: iconColor,
                                    ),
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  const Spacer(),
                                  // زر التعديل
                                 // زر التعديل
IconButton(
  onPressed: () {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<TodoDetailsCubit>(),
        child: EditTodoModalWidget(todo: todo),
      ),
    ).then((isEdited) {
      // 👈 التعديل هنا: لو المودال قفل وبعتلنا true، نقفل احنا كمان صفحة التفاصيل ونرجع للـ Home
      if (isEdited == true) {
        Navigator.pop(context, true);
      }
    });
  },
  icon: Icon(
    CupertinoIcons.pencil,
    color: iconColor,
  ),
),
                                  // زر الحذف
                                  if (state is TodoDetailsLoading)
                                    const CircularProgressIndicator()
                                  else
                                    IconButton(
                                      onPressed: () {
                                        // 4. استدعاء دالة الحذف وتمرير الـ id
                                        // (تأكد أن الـ TodoEntity يحتوي على متغير id)
                                        context
                                            .read<TodoDetailsCubit>()
                                            .deleteTodo(todo.id);
                                      },
                                      icon: Icon(
                                        CupertinoIcons.delete,
                                        color:
                                            Colors.red, // ميزته باللون الأحمر
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 32),
                              // Main Content
                              Text(
                                todo.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: darkText,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                todo.des,
                                style: GoogleFonts.poppins(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: grayText,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 48),
                              const Spacer(),
                              const SizedBox(height: 32),
                              // Bottom Section
                              Center(
                                child: Text(
                                  "deadline_message".tr(
                                    namedArgs: {"date": "${todo.deadline}"},
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: lightGrayText,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
