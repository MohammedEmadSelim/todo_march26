import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/feature/home/data/repository/home_repository_implementation.dart';
import 'package:todo_march26/feature/home/domain/entities/todo_entity.dart';
import 'package:todo_march26/feature/home/domain/entities/todo_param.dart';
import 'package:todo_march26/feature/home/domain/repository/base_home_repoistory.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  BaseHomeRepoistory homeRepoistory = HomeRepositoryImplementation();

  Future<void> createTodo(CreateTodoParam todo) async {
    emit(HomeCreateTodoLoading());
    var res = await homeRepoistory.createTodo(todo);
    if (res == "200") {
      emit(HomeCreateTodoSuccess());
    } else {
      emit(HomeCreateTodoFailure(res));
    }
  }

  Future<void> fetchTodos() async {
    emit(HomeFetchTodoLoading());
    try{
      var res = await homeRepoistory.getTodos();
      emit(HomeFetchTodoSuccess(res));
    }catch(error){
      emit(HomeCreateTodoFailure(error.toString()));
    }
  }
}
