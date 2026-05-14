import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TodoDetailsScreen extends StatelessWidget {
  const TodoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton( onPressed: () {  }, icon: Icon(Icons.access_time),),
          IconButton( onPressed: () {  }, icon: Icon(Icons.edit_rounded),),
          IconButton( onPressed: () {  }, icon: Icon(Icons.delete_outlined),),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical:2.h , horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Design UI App',style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight(600)
            ),),
            SizedBox(height: 3.h,),
            Text('Make To-DO UI Design for  NTI ',
              style: TextStyle(
                fontSize: 16.sp,
            ),),

          ],
        ),
      ),
    );
  }
}
