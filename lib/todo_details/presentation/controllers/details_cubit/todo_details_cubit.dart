import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/todo_details/data/repository/details_repository_implementation.dart';
import 'package:todo_march26/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/todo_details/domain/repository/base_details_repository.dart';

part 'todo_details_state.dart';

class TodoDetailsCubit extends Cubit<TodoDetailsState> {
  TodoDetailsCubit() : super(TodoDetailsInitial());
   BaseDetailsRepo  detailsRepo = DetailsRepositoryImplementation();


   Future<void> EditeTodo(EditTodoParam todo)async{
     emit(TodoDetailsLoading());
     var res = await detailsRepo.editTodo(todo);

     if(res == "200"){
       emit(TodoDetailsSuccess());
     }{
       emit(TodoDetailsFailure(res));

     }
   }
}
