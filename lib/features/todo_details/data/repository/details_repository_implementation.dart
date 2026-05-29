import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/features/todo_details/domain/entities/delete_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

class DetailsRepositoryImplementation extends BaseDetailsRepository{
  @override
  Future<String> editTodo(EditTodoParam todo) async{
    try{
      var firestore = FirebaseFirestore.instance;
      await firestore.collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(todo.id)
          .update({
        "title": todo.title,
        "description": todo.description,
        "deadline": todo.deadline,
      });
      return "200";
    }catch(error){
      return error.toString();
    }
  }

  @override
  Future<String> deleteTodo(DeleteTodoParam todo) async{
    try{
      var firestore = FirebaseFirestore.instance;
      await firestore.collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(todo.id)
          .delete();

      return "200";
    }catch(error){
      return error.toString();
    }
  }



}