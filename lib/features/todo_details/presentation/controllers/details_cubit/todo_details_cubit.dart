// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';
// import 'package:todo_march26/features/todo_details/data/repository/details_repository_implementation.dart';
// import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
// import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

// part 'todo_details_state.dart';

// class TodoDetailsCubit extends Cubit<TodoDetailsState> {
//   TodoDetailsCubit() : super(TodoDetailsInitial());
//    BaseDetailsRepo  detailsRepo = DetailsRepositoryImplementation();


//    Future<void> EditeTodo(EditTodoParam todo)async{
//      emit(TodoDetailsLoading());
//      var res = await detailsRepo.editTodo(todo);

//      if(res == "200"){
//        emit(TodoDetailsSuccess());
//      }{
//        emit(TodoDetailsFailure(res));

//      }
//    }
// }
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/features/todo_details/data/repository/details_repository_implementation.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

part 'todo_details_state.dart';

class TodoDetailsCubit extends Cubit<TodoDetailsState> {
  TodoDetailsCubit() : super(TodoDetailsInitial());
  
  BaseDetailsRepo detailsRepo = DetailsRepositoryImplementation();

  // ✏️ دالة التعديل (صلحنا اسم الدالة والقوس)
  Future<void> editTodo(EditTodoParam todo) async {
    emit(TodoDetailsLoading());
    var res = await detailsRepo.editTodo(todo);

    if (res == "200") {
      emit(TodoDetailsEditSuccess());
    } else { // تم تصحيح القوس هنا
      emit(TodoDetailsFailure(res));
    }
  }

  // 🗑️ دالة الحذف الجديدة
  Future<void> deleteTodo(String id) async {
    emit(TodoDetailsLoading());
    var res = await detailsRepo.deleteTodo(id);

    if (res == "200") {
      emit(TodoDetailsDeleteSuccess());
    } else {
      emit(TodoDetailsFailure(res));
    }
  }
}
