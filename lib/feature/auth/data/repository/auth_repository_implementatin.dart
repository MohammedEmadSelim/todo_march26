import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_march26/feature/auth/domain/repository/base_auth_repository.dart';

class AuthRepositoryImplementatin extends BaseAuthRepository{
  var firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> login(String email, String password) async{
    try{
      var res = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if(res.user != null){
        return "200";
      }
      return "something went wrong please, try again later";
    }catch(error){
      return error.toString();
    }
  }

  @override
  Future<String> register(String email, String password) async{
    try{
      var res = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if(res.user != null){
        return "200";
      }
      return "something went wrong please, try again later";
    }catch(error){
      return error.toString();
    }
  }

  @override
  Future<String> sendResetEmail(String email) async{
    try{
       await firebaseAuth.sendPasswordResetEmail(email: email);
       return "200";

    }on FirebaseAuthException catch(error){
      return error.message ??  "something went wrong please, try again later";
    }catch(error){
      return "Something went wrong, please try again later";
    }
  }

  @override
  Future<String> verifyResetCode(String code) async {
    try {
      await firebaseAuth.verifyPasswordResetCode(code);
      return "200";
    } on FirebaseAuthException catch (error) {
      return error.message ?? "Invalid or expired code";
    } catch (error) {
      return "Something went wrong, please try again later";
    }
  }

  @override
  Future<String> confirmNewPassword({
        required String code,
        required String newPassword,
  }) async
  {
    try{
      await firebaseAuth.confirmPasswordReset(code: code, newPassword: newPassword);
      return "200";
    }on FirebaseAuthException catch (error) {
      return error.message ?? "Something went wrong, please try again later";
    }catch(error){
      return "Something went wrong, please try again later";
    }
  }

  @override
  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      return "200";
    } on FirebaseAuthException catch (error) {
      return error.message ?? "Something went wrong, please try again later";
    } catch (error) {
      return "Something went wrong, please try again later";
    }
  }

}