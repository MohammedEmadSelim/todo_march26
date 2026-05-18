import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_march26/home_screen/domain/entites/todo_param.dart';

import '../../domain/repository/base_home_repository.dart';

class HomeRepositoryImplementation extends BaseHomeRepository {
  @override
  Future<String> createTodo(CreateTodoParam todo) async {
    var imageLink;
    try {
      if (todo.image != null) {
        final storageRef = FirebaseStorage.instance.ref("todo_march26");
        final fileRef = storageRef.child("${DateTime.now().millisecondsSinceEpoch}.png");
        var file = File(todo.image!.path);
        var res = await fileRef.putFile(file);
        imageLink =await res.ref.getDownloadURL();
        print(imageLink);
      }
      var firestore = FirebaseFirestore.instance;
      var userId = FirebaseAuth.instance.currentUser!.uid;

      firestore.collection(userId).add({
        "title": todo.title,
        "description": todo.description,
        "deadline": todo.deadline,
        if (imageLink != null)
          "image": imageLink
      });
      print("done");

      return "200";
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
}
