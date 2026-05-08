abstract class BaseAuthRepository {
  Future<String> login(String email , String password);
  Future<String> register(String email, String password);
}