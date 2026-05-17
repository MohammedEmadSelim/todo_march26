import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/features/auth/data/repository/auth_repository_implementation.dart';
import 'package:todo_march26/features/auth/domain/repository/base_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final BaseAuthRepository _authRepository = AuthRepositoryImplementation();

  Future<void> login(String email, String password) async {
    emit(AuthLoginLoading());
    var res = await _authRepository.login(email, password);
    if (res == "200") {
      emit(AuthLoginSuccess());
    } else {
      emit(AuthLoginFailure(res));
    }
  }

  Future<void> register(String email, String password)async{
    emit(AuthRegisterLoading());
    var res = await _authRepository.register(email, password);
    if(res == "200"){
      emit(AuthLoginSuccess());
    }
    else{
      emit(AuthRegisterFailure(res.toString()));
    }

  }
}
