import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/auth/data/repository/auth_reposatory_implementation.dart';
import 'package:todo_march26/auth/domain/repository/base_auth_reposatory.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
 BaseAuthRepository _authRepository = AuthRepositoryImplementation();
  AuthCubit() : super(AuthInitial());

  Future<void> register (String email , String password) async
  {
    emit(AuthRegisterLoading());
    var res = await _authRepository.register(email, password);
    if(res == '200'){
      emit(AuthRegisterSuccess());
    }else{
      emit(AuthRegisterFailure(res.toString()));
    }
  }
}
