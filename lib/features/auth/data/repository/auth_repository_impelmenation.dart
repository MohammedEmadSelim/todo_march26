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
      if (res.user != null) {
        return "200";
      }
      return "something went wrong please, try again later";
    } catch (e) {
      return e.toString();
    }
  }
}
