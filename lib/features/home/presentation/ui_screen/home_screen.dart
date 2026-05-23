import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_march26/core/theme/app_colors.dart';
import 'package:todo_march26/core/utlies/widgets/custom_button.dart';
import 'package:todo_march26/features/home/domain/entity/todo_param.dart';
import 'package:todo_march26/features/home/presentation/components/custom_todo_text_field.dart';
import 'package:todo_march26/features/home/presentation/components/deadline_widget.dart';
import 'package:todo_march26/features/home/presentation/components/image_widget.dart';
import 'package:todo_march26/features/home/presentation/controller/home_cubit.dart';
import 'package:todo_march26/features/todo_details/presentation/ui_screens/todo_details_screen.dart';

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
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 1.h),
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              itemCount: todos.length,
              itemBuilder: (context, index) =>
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TodoDetailsScreen(todo: todos[index],),));
                    },
                    child: Card(
                      color: AppColors.primaryPink,

                      child:Padding(
                        padding: EdgeInsets.symmetric(horizontal:3.w,vertical: 1.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    todos[index].title,
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
                            Text(
                              todos[index].desc,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                                color: AppColors.white,
                              ),
                              maxLines: 7,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 1.h,),
                            Row(
                              children: [
                                Text(
                                  "Finished at : ${todos[index].deadline}",
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
                  ),
            );
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
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) =>
                BlocProvider(
                  create: (context) => HomeCubit(),
                  child: CreateTodoModalWidget(),
                ),
          ).then((value) {
            context.read<HomeCubit>().fetchTodos();
          },);
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

class CreateTodoModalWidget extends StatefulWidget {
  const CreateTodoModalWidget({super.key});

  @override
  State<CreateTodoModalWidget> createState() => _CreateTodoModalWidgetState();
}

class _CreateTodoModalWidgetState extends State<CreateTodoModalWidget> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController deadlineController = TextEditingController();

  Uint8List? imageUnit;
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      height: 85.h,
      width: 100.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.roundToDouble()),
        color: AppColors.secondaryPink,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
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

              CustomTodoTextFormField(
                hint: "Title",
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },
              ),
              SizedBox(height: 1.h),
              CustomTodoTextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "required_message".tr();
                  }
                },

                hint: "Description",
                maxLines: 15,
                controller: descriptionController,
              ),
              SizedBox(height: 1.h),
              DeadLineWidget(deadlineController: deadlineController),
              SizedBox(height: 1.h),
              ImagesWidget(
                image: (value) async {
                  if (value != null) {
                    image = value;
                    imageUnit = await value.readAsBytes();
                    setState(() {});
                  }
                  print(value);
                },
              ),
              SizedBox(height: 1.h),
              if (imageUnit != null)
                Stack(
                  children: [
                    Image.memory(imageUnit!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            imageUnit = null;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.white,
                            ),
                            child: Icon(Icons.close, color: AppColors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

              BlocConsumer<HomeCubit, HomeState>(
                listener: (context, state) {
                  if(state is HomeCreateTodoSuccess)
                  {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if(state is HomeCreateTodoLoading){
                    return Center(child: CircularProgressIndicator(color: AppColors.white,),);
                  }
                  return CustomButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        // calling create todo
                        print(titleController.text);
                        print(descriptionController.text);
                        print(deadlineController.text);
                        print(imageUnit);
                      }

                      // first step cubit
                      context.read<HomeCubit>().createTodo(
                        CreateTodoParam(
                          title: titleController.text,
                          description: descriptionController.text,
                          deadline: deadlineController.text,
                          image: image,
                        ),
                      );
                    },
                    title: "Add Todo",
                    backgroundColor: AppColors.white,
                    textColor: AppColors.secondaryPink,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}