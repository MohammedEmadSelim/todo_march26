import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/auth/domain/repository/base_auth_reposatory.dart';

class AuthRepositoryImplementation extends BaseAuthRepository
{
  var firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> login(String email, String password)async {
    try{
      var res = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(res.user != null)
      {
        return '200';
      }
      return 'something went wrong , please try again later';
    }catch(e){
      return e.toString();
    }
  }

  @override
  Future<String> register(String email, String password)async {
    try{
      var res = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (res.user != null){
        return '200';
      }
      return "something went wrong please, try again later";
    }catch(e){
      return e.toString();
    }

  }

}