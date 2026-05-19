import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/feature/home/data/models/todo_model.dart';
import 'package:todo_march26/feature/home/domain/entities/todo_param.dart';
import 'package:todo_march26/feature/home/domain/repository/base_home_repoistory.dart';

class HomeRepositoryImplementation extends BaseHomeRepoistory{
  @override
  Future<String> createTodo(CreateTodoParam todo) async{
    try{
      var firestore = FirebaseFirestore.instance;
      var userId = FirebaseAuth.instance.currentUser!.uid;

      await firestore.collection(userId).add({
        "title": todo.title,
        "description": todo.description,
        if(todo.deadline != null) "deadline": todo.deadline,
        "createdAt": Timestamp.fromDate(DateTime.now()),
      }).then((value){
        value.id;
        firestore.collection(userId).doc(value.id).update({
          "id": value.id,
        });
      });
      return "200";
    }catch(error){
      return error.toString();
    }
  }

  @override
  Future<List<TodoModel>> getTodos() async{
    try{
      var id = FirebaseAuth.instance.currentUser!.uid;
      var collection = await FirebaseFirestore.instance.collection(id).get();
      var data = collection.docs;
      var todo = data.map((e){
        return TodoModel.fromJson(e.data());
      }).toList();
      return todo;
    }catch(error){
      throw error;
    }
  }

}