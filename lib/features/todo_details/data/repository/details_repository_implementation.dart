// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
// import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

// class DetailsRepositoryImplementation extends BaseDetailsRepo {
//   @override
//   Future<String> editTodo(EditTodoParam todo) async {
//     try {
//       var fireStore = FirebaseFirestore.instance;

//       fireStore
//           .collection(FirebaseAuth.instance.currentUser!.uid)
//           .doc(todo.id)
//           .update({
//             "title": todo.title,
//             "description": todo.des,
//             "deadline": todo.deadline,
//           });

//       return "200";
//     } catch (e) {
//       return e.toString();
//     }
//   }
// }
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

class DetailsRepositoryImplementation extends BaseDetailsRepo {
  

  @override
  @override
Future<String> editTodo(EditTodoParam param) async {
  try {
    print("--- 1. Started Edit Todo ---");
    var firestore = FirebaseFirestore.instance;
    var userId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> dataToUpdate = {
      "title": param.title,
      "description": param.des,
      "deadline": param.deadline,
    };

    if (param.imageRemoved == true) {
      print("--- 2. Removing Image ---");
      dataToUpdate["image"] = "";
    } 
    else if (param.image != null) {
      print("--- 2. Uploading New Image to Storage... ---");
      final storageRef = FirebaseStorage.instance.ref("todo_march26");
      final fileRef = storageRef.child("${DateTime.now().millisecondsSinceEpoch}.png");
      var file = File(param.image!.path);
      
      // التطبيق غالباً بيعلق في السطر ده لو الـ Storage مش متفعلة
      var res = await fileRef.putFile(file); 
      
      print("--- 3. Image Uploaded! Getting URL... ---");
      var imageLink = await res.ref.getDownloadURL();
      dataToUpdate["image"] = imageLink;
    }

    print("--- 4. Updating Firestore... ---");
    await firestore.collection(userId).doc(param.id).update(dataToUpdate);
    
    print("--- 5. Done Successfully! ---");
   return "200"; // 👈 غيرنا دي لـ success عشان الـ Cubit يفهمها
    
  } catch (e) {
    print("--- ERROR: $e ---");
    return e.toString();
  }
}
// Future<String> editTodo(EditTodoParam param) async {
//   try {
//     var firestore = FirebaseFirestore.instance;
//     var userId = FirebaseAuth.instance.currentUser!.uid;

//     // 1. بنجهز البيانات الأساسية للتعديل
//     Map<String, dynamic> dataToUpdate = {
//       "title": param.title,
//       "description": param.des,
//       "deadline": param.deadline,
//     };

//     // 2. لو المستخدم ضغط على الـ X عشان يحذف الصورة
//     if (param.imageRemoved == true) {
//       dataToUpdate["image"] = ""; // بيفضي حقل الصورة في فايربيس
//     } 
//     // 3. لو المستخدم اختار صورة جديدة من الاستوديو
//     else if (param.image != null) {
//       // بنرفع الصورة الجديدة الأول
//       final storageRef = FirebaseStorage.instance.ref("todo_march26");
//       final fileRef = storageRef.child("${DateTime.now().millisecondsSinceEpoch}.png");
//       var file = File(param.image!.path);
//       var res = await fileRef.putFile(file);
//       var imageLink = await res.ref.getDownloadURL(); // بنجيب الرابط الجديد
      
//       dataToUpdate["image"] = imageLink; // بنضيف الرابط الجديد للبيانات
//     }

//     // 4. نرفع كل التحديثات دي للوثيقة في فايربيس
//     await firestore.collection(userId).doc(param.id).update(dataToUpdate);

//     return "200";
//   } catch (e) {
//     return e.toString();
//   }
// }
  // Future<String> editTodo(EditTodoParam todo) async {
  //   try {
  //     var fireStore = FirebaseFirestore.instance;

  //     // ضفنا كلمة await هنا عشان نستنى فايربيس يرفع الداتا الأول
  //     await fireStore
  //         .collection(FirebaseAuth.instance.currentUser!.uid)
  //         .doc(todo.id)
  //         .update({
  //           "title": todo.title,
  //           "description": todo.des,
  //           "deadline": todo.deadline,
  //         });

  //     return "200";
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }

  // 🗑️ ضفنا دالة الحذف بالكامل
  @override
  Future<String> deleteTodo(String id) async {
    try {
      var fireStore = FirebaseFirestore.instance;

      await fireStore
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(id)
          .delete(); // أمر الحذف من فايربيس

      return "200";
    } catch (e) {
      return e.toString();
    }
  }
}
