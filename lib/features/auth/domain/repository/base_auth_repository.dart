abstract class BaseAuthRepository{
  Future<String>login(String email, String password);
  Future<String>register(String email, String password);
  Future<String> sendResetEmail(String email);
  Future<String> verifyResetCode(String code);
  Future<String> confirmNewPassword({required String code, required String newPassword,});
  Future<String> signOut();
}