import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/features/todo_details/domain/entity/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

class DetailsRepositoryImplementation extends BaseDetailsRepo {
  @override
  Future<String> editTodo(EditTodoParam todo) async {
    try {
      var fireStore = FirebaseFirestore.instance;

      fireStore
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(todo.id)
          .update({
        "title": todo.title,
        "description": todo.des,
        "deadline": todo.deadline,
      });

      return "200";
    } catch (e) {
      return e.toString();
    }
  }
}