import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/features/todo_details/data/repository/details_repository_implementation.dart';
import 'package:todo_march26/features/todo_details/domain/entities/delete_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/entities/edit_todo_param.dart';
import 'package:todo_march26/features/todo_details/domain/repository/base_details_repository.dart';

import '../../data/repository/details_repository_implementation.dart';
import '../../domain/entities/delete_todo_param.dart';
import '../../domain/repository/base_details_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  BaseDetailsRepository detailsRepository = DetailsRepositoryImplementation();

  Future<void> EditTodo(EditTodoParam todo) async{
    emit(DetailsLoading());
    var res = await detailsRepository.editTodo(todo);
    if(res == "200"){
      emit(DetailsSuccess());
    }{
      emit(DetailsFailure(res));
    }
  }

  Future<void> DeleteTodo(DeleteTodoParam todo)async{
    emit(DetailsDeleteLoading());
    var res = await detailsRepository.deleteTodo(todo);
    if(res == "200"){
      emit(DetailsSuccess());
    }{
      emit(DetailsFailure(res));
    }
  }
}