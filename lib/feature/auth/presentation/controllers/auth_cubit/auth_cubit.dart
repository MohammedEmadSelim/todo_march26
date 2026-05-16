import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_march26/feature/auth/data/repository/auth_repository_implementatin.dart';
import 'package:todo_march26/feature/auth/domain/repository/base_auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  BaseAuthRepository _authRepository = AuthRepositoryImplementatin();

  Future<void>login(String email, String password) async{
    emit(AuthLoginLoading());
    var res = await _authRepository.login(email, password);
    if(res == "200"){
      emit(AuthLoginSuccess());
    }else{
      emit(AuthLoginFailure(res));
    }
  }

  Future<void>register(String email, String password) async{
    emit(AuthSignUpLoading());
    var res = await _authRepository.register(email, password);
    if(res == "200"){
      emit(AuthSignUpSuccess());
    }else{
      emit(AuthSignUpFailure(res));
    }
  }

  Future<void>sendResetEmail(String email) async{
    emit(AuthSendResetEmailLoading());
    var res = await _authRepository.sendResetEmail(email);
    if(res == "200"){
      emit(AuthSendResetEmailSuccess());
    }else{
      emit(AuthSendResetEmailFailure(res));
    }
  }

  Future<void>verifyResetCode(String code) async {
    emit(AuthVerifyResetCodeLoading());
    var res = await _authRepository.verifyResetCode(code);
    if(res == "200"){
      emit(AuthVerifyResetCodeSuccess(code));
    }else{
      emit(AuthVerifyResetCodeFailure(res));
    }
  }

  Future<void>confirmNewPassword({required String code, required String newPassword}) async {
    emit(AuthConfirmPasswordLoading());
    var res = await _authRepository.confirmNewPassword(code: code, newPassword: newPassword);
    if(res == "200"){
      emit(AuthConfirmPasswordSuccess());
    }else{
      emit(AuthConfirmPasswordFailure(res));
    }
  }

  Future<void>signOut()async {
    emit(AuthSignOutLoading());
    var res = await _authRepository.signOut();
    if(res == "200"){
      emit(AuthSignOutSuccess());
    }else{
      emit(AuthSignOutFailure(res));
    }
  }
}
