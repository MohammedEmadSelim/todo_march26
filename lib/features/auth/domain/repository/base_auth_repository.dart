abstract class BaseAuthRepository {
  Future<String> login(String email , String password);
}