import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/features/auth/domain/repository/base_auth_repository.dart';

class AuthRepositoryImplementation extends BaseAuthRepository {
  var firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> login(String email, String password) async {
    try {
      var res = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (res.user != null) return "200";
      return "Something went wrong, please try again later";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> register(String email, String password) async {
    try {
      var res = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (res.user != null) return "200";
      return "Something went wrong, please try again later";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> sendResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "200";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> verifyResetCode(String code) async {
    try {
      await firebaseAuth.verifyPasswordResetCode(code);
      return "200";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> confirmNewPassword({
    required String code,
    required String newPassword,
  }) async {
    try {
      await firebaseAuth.confirmPasswordReset(
        code: code,
        newPassword: newPassword,
      );
      return "200";
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      return "200";
    } catch (e) {
      return e.toString();
    }
  }
}