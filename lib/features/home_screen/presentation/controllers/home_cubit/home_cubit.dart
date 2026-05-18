import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/features/home_screen/data/repository/home_repository_implementation.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_entity.dart';
import 'package:todo_march26/features/home_screen/domain/entites/todo_param.dart';
import 'package:todo_march26/features/home_screen/domain/repository/base_home_repository.dart';

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
