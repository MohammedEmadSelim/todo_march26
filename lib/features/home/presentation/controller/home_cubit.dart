import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/features/home/data/reposatory/home_reposatory_implementation.dart';
import 'package:todo_march26/features/home/domain/entity/todo_entity.dart';
import 'package:todo_march26/features/home/domain/entity/todo_param.dart';
import 'package:todo_march26/features/home/domain/reposatory/based_home_reposatory.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  BaseHomeRepository homeRepo = HomeRepositoryImplementation();

  Future<void> createTodo(CreateTodoParam todo) async {
    emit(HomeCreateTodoLoading());
    var res = await homeRepo.createTodo(todo);
    if (res == "200") {
      emit(HomeCreateTodoSuccess());
    } else {
      emit(HomeCreateTodoFailure(res));
    }
  }

  Future<void> fetchTodos() async {
    emit(HomeFetchTodosLoading());
    try {
      var res = await  homeRepo.getTodos();
      emit(HomeFetchTodosSuccess(res));

    } catch (e) {
      emit(HomeCreateTodoFailure(e.toString()));
    }
  }
}
