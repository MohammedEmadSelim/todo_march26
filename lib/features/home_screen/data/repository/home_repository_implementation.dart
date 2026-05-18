// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:todo_march26/features/home_screen/data/models/todo_model.dart';
// import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
// import 'package:todo_march26/features/home_screen/domain/repository/base_home_repository.dart';

// class HomeRepositoryImplementation extends BaseHomeRepository {
//   @override
//   Future<String> createTodo(CreateTodoParam todo) async {
//     var imageLink;
//     try {
//       if (todo.image != null) {
//         final storageRef = FirebaseStorage.instance.ref("todo_march26");
//         final fileRef = storageRef.child(
//           "${DateTime.now().millisecondsSinceEpoch}.png",
//         );
//         var file = File(todo.image!.path);
//         var res = await fileRef.putFile(file);
//         imageLink = await res.ref.getDownloadURL();
//         print(imageLink);
//       }
//       var firestore = FirebaseFirestore.instance;
//       var userId = FirebaseAuth.instance.currentUser!.uid;

//       firestore.collection(userId).add({
//         "title": todo.title,
//         "description": todo.description,
//         "deadline": todo.deadline,
//         if (imageLink != null) "image": imageLink,
//       }).then((value) {
//         value.id;
//         firestore.collection(userId).doc(value.id).update({
//           "id":value.id
//         });
//       },);
//       print("done");

//       return "200";
//     } catch (e) {
//       print(e.toString());
//       return e.toString();
//     }
//   }

//   @override
//   Future<List<TodoModel>> getTodos() async {
//     try {
//       var id = FirebaseAuth.instance.currentUser!.uid;
//       var collection = await FirebaseFirestore.instance.collection(id).get();
//       var data = collection.docs;
//       var todo = data.map((e) {
//         return TodoModel.fromJson(e.data());
//       }).toList();
//       return todo;
//     } catch (e) {
//       throw e;
//     }
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_march26/features/home_screen/data/models/todo_model.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
import 'package:todo_march26/features/home_screen/domain/repository/base_home_repository.dart';

class HomeRepositoryImplementation extends BaseHomeRepository {
  @override
  Future<String> createTodo(CreateTodoParam todo) async {
    var imageLink;
    try {
      if (todo.image != null) {
        final storageRef = FirebaseStorage.instance.ref("todo_march26");
        final fileRef = storageRef.child(
          "${DateTime.now().millisecondsSinceEpoch}.png",
        );
        var file = File(todo.image!.path);
        var res = await fileRef.putFile(file);
        imageLink = await res.ref.getDownloadURL();
        print(imageLink);
      }
      var firestore = FirebaseFirestore.instance;
      var userId = FirebaseAuth.instance.currentUser!.uid;

      firestore.collection(userId).add({
        "title": todo.title,
        "description": todo.description,
        "deadline": todo.deadline,
        if (imageLink != null) "image": imageLink,
      }).then((value) {
        // ملحوظة: الخطوة دي ممتازة إنك بتحفظ الـ ID جوه الوثيقة نفسها
        firestore.collection(userId).doc(value.id).update({
          "id": value.id
        });
      });
      print("done");

      return "200";
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      var id = FirebaseAuth.instance.currentUser!.uid;
      var collection = await FirebaseFirestore.instance.collection(id).get();
      var data = collection.docs;
      
      var todo = data.map((e) {
        // 👈 التعديل هنا: مررنا e.id كعنصر تاني للـ fromJson
        return TodoModel.fromJson(e.data(), e.id);
      }).toList();
      
      return todo;
    } catch (e) {
      throw e;
    }
  }
}
